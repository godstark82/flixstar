import 'package:flixstar/features/history/presentation/bloc/history_bloc.dart';
import 'package:flixstar/features/history/presentation/bloc/history_state.dart';
import 'package:flixstar/features/movie/data/models/genre_movie_model.dart';
import 'package:flixstar/features/movie/data/models/movie_model.dart';
import 'package:flixstar/features/home/presentation/bloc/home_bloc.dart';
import 'package:flixstar/features/home/presentation/widgets/genre_movies_page.dart';
import 'package:flixstar/features/history/presentation/pages/history_page.dart';
import 'package:flixstar/common/carousel_widget.dart';
import 'package:flixstar/common/exit_dialoge.dart';
import 'package:flixstar/features/movie/presentation/widgets/movie_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:startapp_sdk/startapp.dart';

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
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoadedState || state is HomeAnimeLoadingState) {
              return CustomScrollView(
                slivers: [
                  sliverCarouselMovieBar(context, movies: state.trendingMovie!),
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
                          movies: state.popularMovie!, title: 'Popular')),
                  SliverList.builder(
                      itemCount: state.movieGenres!.length,
                      itemBuilder: (context, index) {
                        return GenreMovieList(genre: state.movieGenres![index]);
                      }),
                  SliverToBoxAdapter(
                    child: StartAppBanner(state.bannerAd!),
                  )
                ],
              );
            } else if (state is HomeLoadingState) {
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
