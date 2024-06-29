import 'package:flixstar/features/anime/presentation/widgets/anime_carousel.dart';
import 'package:flixstar/features/anime/presentation/widgets/anime_list.dart';
import 'package:flixstar/features/anime/presentation/widgets/genre_list.dart';
import 'package:flixstar/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnimeHomescreen extends StatelessWidget {
  const AnimeHomescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        if (state is HomeLoadingState || state is HomeAnimeLoadingState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is HomeLoadedState) {
          return CustomScrollView(
            slivers: [
              customAnimeCarousel(context, anime: state.topAnime!),
              SliverToBoxAdapter(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: AnimeList(movies: state.topAnime!, title: 'Top Animes'),
              )),
              SliverList.builder(
                  itemCount: state.animeGenreData!.length,
                  itemBuilder: (context, index) {
                    return GenreAnimeList(
                        genre: state.animeGenreData!.elementAt(index));
                  })
            ],
          );
        }
        return Center(
          child: Text('ERROR'),
        );
      }),
    );
  }
}
