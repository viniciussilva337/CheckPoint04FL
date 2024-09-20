import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app/common/utils.dart';
import 'package:movie_app/models/movie_model.dart'; // Certifique-se de importar o modelo

const baseUrl = 'https://api.themoviedb.org/3';
const key = '?api_key=$apiKey';

class ApiServices {
  // Função privada para simplificar a lógica de fetch
  Future<Result> _fetchMovies(String endpoint) async {
    final url =
        '$baseUrl$endpoint$key'; // Certifique-se de que não há barra extra

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
    return _fetchMovies('/movie/top_rated');
  }

  Future<Result> getNowPlayingMovies() async {
    return _fetchMovies('/movie/now_playing');
  }

  Future<Result> getUpcomingMovies() async {
    return _fetchMovies('/movie/upcoming');
  }

  Future<Result> getPopularMovies() async {
    return _fetchMovies('/movie/popular');
  }

  // Método para buscar detalhes de um filme específico
  Future<Movie> getMovieDetails(int movieId) async {
    final url = Uri.parse('$baseUrl/movie/$movieId$key');
    print("Fetching movie details from URL: $url"); // Para debugging

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return Movie.fromJson(jsonDecode(response.body));
      } else {
        throw Exception(
            'Failed to load movie details: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to load movie details: $e');
    }
  }

  // Método para buscar filmes semelhantes
  Future<Result> getSimilarMovies(int movieId) async {
    return _fetchMovies(
        '/movie/$movieId/similar'); // Endpoint para filmes semelhantes
  }
}
