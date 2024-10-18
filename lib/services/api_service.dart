import 'package:dio/dio.dart';
import '../models/games.dart'; 

class GamesRepository {
  final Dio _dio;

  GamesRepository(this._dio);

  Future<Games> fetchAllGames(String? searchQuery, int page) async {
    final url = searchQuery != null 
        ? 'https://odigital.pro/football_fields_api/games/?search=$searchQuery' 
        : 'https://odigital.pro/football_fields_api/games/';
    
    try {
      final response = await _dio.get(url);
     
    
      return Games.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load cities: $e');
    }
  }
}
