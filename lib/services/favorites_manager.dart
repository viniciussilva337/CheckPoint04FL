import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';

class FavoritesManager {
  static final List<Movie> _favorites = [];

  static void addFavorite(Movie movie) {
    _favorites.add(movie);
  }

  static void removeFavorite(Movie movie) {
    _favorites.remove(movie);
  }

  static List<Movie> getFavorites() {
    return _favorites;
  }

  static bool isFavorite(Movie movie) {
    return _favorites.contains(movie);
  }
}
