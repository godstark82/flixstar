import 'package:dooflix/features/movie/data/models/genre_movie_model.dart';
import 'package:dooflix/features/movie/data/models/movie_model.dart';
import 'package:dooflix/features/movie/data/repositories/movie_repo_impl.dart';
import 'package:dooflix/features/movie/presentation/widgets/movie_card.dart';
import 'package:dooflix/injection_container.dart';
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
          // ignore: unused_local_variable
          int page = currentItems.length ~/ 20 + 1;
          MovieRepositoryImpl movieRepositoryImpl = MovieRepositoryImpl(sl());
          final newData = await movieRepositoryImpl.getGenres(id: genre.id, page: page);
          // final newData = await repo.getGenreMovies(genre.id, page: page);
          return newData.data ?? [];
        },
        itemWidth: 120,
        bottomLoadingBuilder: () => Align(
            alignment: Alignment.bottomCenter,
            child: LinearProgressIndicator()),
        gridChildAspectRatio: 10 / 16,
        gridCrossAxisCount: 3,
        itemBuilder: (context, item, i) {
          return MovieCard(movie: item);
        },
      ),
    );
  }
}
