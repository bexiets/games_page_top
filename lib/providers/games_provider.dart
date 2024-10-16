import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import '../models/games.dart';

part 'games_provider.g.dart';

@riverpod
class GamesProvider extends _$GamesProvider {
  @override
 Future<List<Games>> build() async {
    final games = await fetchGames(); 
    return [games]; 
  }

  Future<Games> fetchGames([String searchQuery = '']) async {
  final Dio dio = Dio();
  final prefs = await SharedPreferences.getInstance();

  try {
    final response = await dio.get(
      'https://odigital.pro/football_fields_api/games/',
      queryParameters: {'search': searchQuery},
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.data;
      print('API Response: $data');
      
      // Check if the 'results' field is present and is a list
      if (data['results'] != null && data['results'] is List) {
        List<dynamic> gamesData = data['results'];

        if (gamesData.isEmpty) {
          print('No games found in the results.');
          return Games(
            count: data['count'] as int?,
            next: data['next'] as String?,
            previous: data['previous'] as String?,
            results: [],
          );  
        }

        
        List<Results> resultsList = gamesData.map((game) => Results.fromJson(game)).toList();

        await prefs.setString('games', jsonEncode(data));
        print('Cached games data: ${prefs.getString('games')}');

        return Games(
          count: data['count'] as int?,
          next: data['next'] as String?,
          previous: data['previous'] as String?,
          results: resultsList,
        );
      } else {
        throw Exception('Unexpected response structure: No results found.');
      }
    } else {
      throw Exception('Failed to fetch games: ${response.statusCode}');
    }
  } catch (e) {
    print('Error occurred while fetching games: $e');

    final cachedGames = prefs.getString('games');
    if (cachedGames != null) {
      print('Using cached games data.');
      Map<String, dynamic> cachedData = jsonDecode(cachedGames);
      return Games.fromJson(cachedData);  // Return the Games object from cached data
    } else {
      throw Exception('Error fetching games and no cached data available');
    }
  }
}

}
