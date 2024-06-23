import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dooflix/data/models/genre_model.dart';
import 'package:dooflix/data/models/movie_model.dart';
import 'package:dooflix/logic/blocs/history_bloc.dart/history_bloc.dart';
import 'package:dooflix/logic/blocs/history_bloc.dart/history_state.dart';
import 'package:dooflix/logic/cubits/movie_details_cubit/movie_detail_state.dart';
import 'package:dooflix/logic/cubits/movie_home_cubit/movie_home_cubit.dart';
import 'package:dooflix/logic/cubits/tv_home_cubit/tv_home_states.dart';
import 'package:dooflix/presentation/pages/genre_movies_page.dart';
import 'package:dooflix/presentation/pages/history_page.dart';
import 'package:dooflix/presentation/widgets/carousel_widget.dart';
import 'package:dooflix/presentation/widgets/exit_dialoge.dart';
import 'package:dooflix/presentation/widgets/movie_card.dart';
import 'package:dooflix/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/carousel/gf_carousel.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (v) async {
        await confirmExitDialoge(context);
      },
      child: Scaffold(
        body: BlocBuilder<MovieCubit, MovieState>(
          builder: (context, state) {
            if (state is MovieLoadedState) {
              return CustomScrollView(
                slivers: [
                  sliverCarouselMovieBar(context,
                      movies: state.trendingMovies),
                  SliverToBoxAdapter(
                      child: BlocBuilder<HistoryBloc, HistoryState>(
                    builder: (context, state) {
                      if (state.movies.isNotEmpty) {
                        return MoviesList(
                            movies: state.movies,
                            title: 'History',
                            showTitle: state.movies.isNotEmpty,
                            showChevron: true,
                            onChevronPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HistoryPage()));
                            });
                      }
                      return SizedBox();
                    },
                  )),
                  SliverToBoxAdapter(
                      child: MoviesList(
                          movies: state.popularMovies, title: 'Popular')),
                  SliverList.builder(
                      itemCount: state.genres.length,
                      itemBuilder: (context, index) {
                        return GenreMovieList(genre: state.genres[index]);
                      }),
                  SliverToBoxAdapter(
                      child: MoviesList(
                          movies: state.topRatedMovies, title: 'Top Rated')),
                ],
              );
            } else if (state is MovieLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Center(child: Text('Error while loading movies'));
            }
          },
        ),
      ),
    );
  }
}

class MoviesList extends StatelessWidget {
  final List<Movie> movies;
  final String title;
  final bool showTitle;
  final bool showChevron;
  final VoidCallback? onChevronPressed;
  MoviesList({
    super.key,
    required this.movies,
    this.onChevronPressed,
    required this.title,
    this.showTitle = true,
    this.showChevron = false,
  }) : assert(movies.isNotEmpty);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        if (showTitle)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Container(
                  height: 20,
                  width: 5,
                  decoration: BoxDecoration(
                      color: Colors.amber.shade600,
                      borderRadius: BorderRadius.circular(15)),
                ),
                SizedBox(width: 5),
                Text(title, style: Theme.of(context).textTheme.titleLarge)
              ]),
              if (showChevron)
                IconButton(
                    onPressed: onChevronPressed,
                    icon: Icon(Icons.chevron_right))
            ],
          ),
        if (movies.isNotEmpty)
          SizedBox(
            height: 225,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  return MovieCard(movie: movies[index]);
                }),
          ),
      ],
    );
  }
}

// auto fetch movie list from genre
class GenreMovieList extends StatelessWidget {
  final GenreMovieModel genre;
  const GenreMovieList({super.key, required this.genre});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              Container(
                height: 20,
                width: 5,
                decoration: BoxDecoration(
                    color: Colors.amber.shade600,
                    borderRadius: BorderRadius.circular(15)),
              ),
              SizedBox(width: 5),
              Text(
                genre.name,
                style: Theme.of(context).textTheme.titleLarge,
              )
            ]),
            IconButton(
                onPressed: () => Get.to(() => GenreMoviesPage(genre: genre)),
                icon: Icon(Icons.chevron_right))
          ],
        ),
        SizedBox(
          height: 225,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: genre.movies?.length,
              itemBuilder: (context, index) {
                return MovieCard(movie: genre.movies!.elementAt(index));
              }),
        ),
      ],
    );
  }
}
