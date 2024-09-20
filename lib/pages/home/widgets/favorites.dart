import 'package:flutter/material.dart';
import 'package:movie_app/common/utils.dart'; // Certifique-se de que o utils esteja correto
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/pages/movie_detail_page.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Carregar a lista de favoritos do armazenamento local
    return Scaffold(
      appBar: AppBar(title: const Text('Meus Favoritos')),
      body: FutureBuilder<List<Movie>>(
        // Substitua o Future com a lógica que carrega os filmes favoritos
        future:
            loadFavorites(), // Função para carregar favoritos (a ser implementada)
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final movie = snapshot.data![index];
                return ListTile(
                  title: Text(movie.title),
                  leading: Image.network(
                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                    width: 50,
                  ),
                  onTap: () {
                    // Navegar para a página de detalhes do filme
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailPage(
                            movieId: movie.id), // Acesse a página de detalhes
                      ),
                    );
                  },
                );
              },
            );
          }
          return const Center(child: Text('Nenhum filme favorito encontrado.'));
        },
      ),
    );
  }

  Future<List<Movie>> loadFavorites() async {
    // Implementar a lógica para carregar os filmes favoritos do armazenamento local
    return []; // Retornar a lista de favoritos (exemplo vazio)
  }
}
