import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/services/api_services.dart';

class MovieDetailPage extends StatefulWidget {
  final int movieId; // Recebe o ID do filme selecionado

  const MovieDetailPage({Key? key, required this.movieId}) : super(key: key);

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  late Future<Movie> movieDetails;

  @override
  void initState() {
    super.initState();
    movieDetails = _fetchMovieDetails(widget.movieId);
  }

  Future<Movie> _fetchMovieDetails(int movieId) async {
    return await ApiServices().getMovieDetails(movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Details'),
      ),
      body: FutureBuilder<Movie>(
        future: movieDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load movie details'));
          } else if (snapshot.hasData) {
            final movie = snapshot.data!;
            return SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Release Date: ${movie.releaseDate?.toLocal().toString().split(' ')[0] ?? 'N/A'}',
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Rating: ${movie.voteAverage}/10',
                  ),
                  SizedBox(height: 16),
                  Text(
                    movie.overview,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            );
          }
          return Container(); // Caso nenhum estado seja atendido
        },
      ),
    );
  }
}
