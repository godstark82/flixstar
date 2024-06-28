import 'package:dooflix/api/gogo_api.dart';
import 'package:dooflix/features/movie/data/models/movie_model.dart';
import 'package:dooflix/features/tv/data/models/tv_model.dart';
import 'package:dooflix/features/anime/data/models/source_model.dart';
import 'package:dooflix/features/anime/presentation/pages/all_episodes.dart';
import 'package:dooflix/features/anime/presentation/pages/anime_details.dart';
import 'package:dooflix/features/movie/presentation/bloc/movie_bloc.dart';
import 'package:dooflix/features/tv/presentation/bloc/tv_bloc.dart';
import 'package:dooflix/features/tv/presentation/pages/tv_page.dart';
import 'package:dooflix/injection_container.dart';

import 'package:dooflix/features/movie/presentation/pages/movie_page.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:jikan_api/jikan_api.dart';

class DNavigator {
  // to movie details
  static void toMovieDetails(Movie movie) {
    Get.to(() => BlocProvider<MovieBloc>(
          create: (context) {
            return sl<MovieBloc>();
          },
          child: MovieDetailsPage(movie: movie),
        ));
  }

  // to TV Details
  static void toTVDetails(TvModel tv) {
    Get.to(() => BlocProvider(
          create: (context) => TvBloc(sl()),
          child: Builder(builder: (context) {
            context.read<TvBloc>().add(LoadTvEvent(tv: tv));
            return TvDetailsPage(tv: tv);
          }),
        ));
  }

  static void toAnimeDetails(Anime anime) {
    Get.to(
      () => AnimeDetailsPage(anime: anime),
    );
  }

  static void toAllEpisodes(Anime anime) {
    Get.to(() => FutureBuilder(
        future: _getAllEpisodes(anime),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
                body: Center(
              child: CircularProgressIndicator(),
            ));
          } else {
            return AllEpisodes(anime: anime, animeSourceList: snapshot.data!);
          }
        }));
  }

  static Future<List<AnimeSource>> _getAllEpisodes(Anime anime) async {
    final GoAnime goAnime = GoAnime(sl());
    final sources =
        await goAnime.getEpisodesLinksOfAnime(anime, count: anime.episodes!);
    return sources;
  }
}
