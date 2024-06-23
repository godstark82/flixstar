import 'package:dooflix/features/anime/presentation/bloc/anime_bloc.dart';
import 'package:dooflix/features/anime/presentation/widgets/anime_card.dart';
import 'package:dooflix/features/anime/presentation/widgets/anime_carousel.dart';
import 'package:dooflix/features/anime/presentation/widgets/anime_list.dart';
import 'package:dooflix/features/anime/presentation/widgets/genre_list.dart';
import 'package:dooflix/presentation/widgets/heading_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnimeHomescreen extends StatelessWidget {
  const AnimeHomescreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AnimeHomeBloc>().add(LoadAnimeHomeData());
    return Scaffold(
      body:
          BlocBuilder<AnimeHomeBloc, AnimeHomeState>(builder: (context, state) {
        if (state is AnimeLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is AnimeError) {
          return Center(child: Text(state.message));
        } else {
          return CustomScrollView(
            slivers: [
              customAnimeCarousel(context, anime: state.popularAnime!),
              SliverToBoxAdapter(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: AnimeList(movies: state.topAnime!, title: 'Top Animes'),
              )),
              SliverList.builder(
                itemCount: state.genreAnime!.length,
                itemBuilder: (context, index){
                return GenreAnimeList(genre: state.genreAnime!.elementAt(index));
              })
            ],
          );
        }
      }),
    );
  }
}
