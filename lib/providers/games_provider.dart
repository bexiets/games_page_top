import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import '../models/games.dart';

part 'games_provider.g.dart';

@riverpod
class GamesProvider extends _$GamesProvider {
  int currentPageAll = 1;
  int currentPageNearby = 1;
  bool _hasMoreAll = true;
  bool _hasMoreNearby = true;
  List<Results> _allResults = [];
  List<Results> _nearbyResults = [];

  @override
  Future<List<Games>> build() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );

    return await fetchGames(
      latitude: position.latitude,
      longitude: position.longitude,
      isNear: false,
    );
  }

  Future<List<Games>> fetchGames({
    int page = 1,
    String searchQuery = '',
    double? latitude,
    double? longitude,
    bool? isNear = false,
  }) async {
    final Dio dio = Dio();
    final prefs = await SharedPreferences.getInstance();

  
    if ((isNear == true && !_hasMoreNearby && page != 1) ||
        (isNear == false && !_hasMoreAll && page != 1)) {
      return _convertResultsToGames(isNear! ? _nearbyResults : _allResults);
    }

    try {
      final response = await dio.get(
        'https://odigital.pro/football_fields_api/games/',
        queryParameters: {
          'search': searchQuery,
          'page': page,
          'is_near': isNear,
          'latitude': latitude,
          'longitude': longitude,
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;

        if (data['results'] != null && data['results'] is List) {
          List<dynamic> gamesData = data['results'];

          if (gamesData.isEmpty && page == 1) {
            if (isNear!) {
              _hasMoreNearby = false;
            } else {
              _hasMoreAll = false;
            }
            return [];
          }

          List<Results> resultsList = gamesData.map((game) => Results.fromJson(game)).toList();

          await prefs.setString('games', jsonEncode(data));

          if (page == 1) {
            if (isNear!) {
              _nearbyResults = resultsList;
            } else {
              _allResults = resultsList;
            }
          } else {
            if (isNear!) {
              _nearbyResults.addAll(resultsList);
            } else {
              _allResults.addAll(resultsList);
            }
          }

          if (isNear) {
            currentPageNearby = page;
            _hasMoreNearby = data['next'] != null;
          } else {
            currentPageAll = page;
            _hasMoreAll = data['next'] != null;
          }

          return _convertResultsToGames(isNear ? _nearbyResults : _allResults);
        } else {
          throw Exception('Unexpected response structure: No results found.');
        }
      } else {
        throw Exception('Failed to fetch games: ${response.statusCode}');
      }
    } catch (e) {
      final cachedGames = prefs.getString('games');
      if (cachedGames != null) {
        Map<String, dynamic> cachedData = jsonDecode(cachedGames);
        final cachedResults = Games.fromJson(cachedData).results;
        return _convertResultsToGames(cachedResults);
      } else {
        throw Exception('Error fetching games and no cached data available');
      }
    }
  }

  Future<void> loadMoreGames({bool isNear = false}) async {
    if (isNear) {
      if (_hasMoreNearby) {
        await fetchGames(page: currentPageNearby + 1, isNear: true);
      }
    } else {
      if (_hasMoreAll) {
        await fetchGames(page: currentPageAll + 1, isNear: false);
      }
    }
  }

  bool hasMoreGames({bool isNear = false}) => isNear ? _hasMoreNearby : _hasMoreAll;

  List<Games> _convertResultsToGames(List<Results> results) {
    return results.map((result) {
      return Games(
        count: results.length,
        next: null,
        previous: null,
        results: [result],
      );
    }).toList();
  }
}
