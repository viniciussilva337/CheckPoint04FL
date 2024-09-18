import 'dart:convert';
import 'package:movie_app/common/utils.dart'; // Certifique-se de que 'apiKey' está definido em utils.dart
import 'package:movie_app/models/movie_model.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://api.themoviedb.org/3/';
const key = '?api_key=$apiKey';

class ApiServices {
  // Função privada para simplificar a lógica de fetch
  Future<Result> _fetchMovies(String endpoint) async {
    final url = '$baseUrl$endpoint$key';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return Result.fromJson(jsonDecode(response.body));
      } else {
        throw Exception(
            'Failed to load movies: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to load movies: $e');
    }
  }

  Future<Result> getTopRatedMovies() async {
    return _fetchMovies('movie/top_rated');
  }

  Future<Result> getNowPlayingMovies() async {
    return _fetchMovies('movie/now_playing');
  }

  Future<Result> getUpcomingMovies() async {
    return _fetchMovies('movie/upcoming');
  }

  Future<Result> getPopularMovies() async {
    return _fetchMovies('movie/popular');
  }
}
