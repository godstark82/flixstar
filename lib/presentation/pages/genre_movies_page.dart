import 'package:dooflix/data/models/genre_model.dart';
import 'package:dooflix/data/models/movie_model.dart';
import 'package:dooflix/data/repositories/movie_repo.dart';
import 'package:dooflix/presentation/widgets/movie_card.dart';
import 'package:flutter/material.dart';
import 'package:load_items/load_items.dart';

class GenreMoviesPage extends StatelessWidget {
  final GenreMovieModel genre;
  const GenreMoviesPage({super.key, required this.genre});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${genre.name} Movies')),
      body: LoadItems<Movie>(
        type: LoadItemsType.grid,
        itemsLoader: (List<Movie> currentItems) async {
          int page = currentItems.length ~/ 20 + 1;
          MovieRepository repo = MovieRepository();
          final newData = await repo.getGenreMovies(genre.id, page: page);
          return newData;
        },
        itemWidth: 120,
        bottomLoadingBuilder: () => Align(
            alignment: Alignment.bottomCenter,
            child: LinearProgressIndicator()),
            gridChildAspectRatio: 10/16,
        gridCrossAxisCount: 3,
        itemBuilder: (context, item, i) {
          return MovieCard(movie: item);
        },
      ),
    );
  }
}
