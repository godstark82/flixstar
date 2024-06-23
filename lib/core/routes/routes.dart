import 'package:dooflix/api/gogo_api.dart';
import 'package:dooflix/data/models/movie_model.dart';
import 'package:dooflix/data/models/tv_details_model.dart';
import 'package:dooflix/data/models/tv_model.dart';
import 'package:dooflix/features/anime/data/models/source_model.dart';
import 'package:dooflix/features/anime/presentation/pages/all_episodes.dart';
import 'package:dooflix/features/anime/presentation/pages/anime_details.dart';
import 'package:dooflix/injection_container.dart';
import 'package:dooflix/logic/cubits/movie_details_cubit/movie_detail_cubit.dart';
import 'package:dooflix/logic/cubits/movie_details_cubit/movie_detail_event.dart';
import 'package:dooflix/logic/cubits/tv_details_cubit/tv_detail_cubit.dart';
import 'package:dooflix/presentation/common/video_player.dart';
import 'package:dooflix/presentation/pages/movie_page.dart';
import 'package:dooflix/presentation/pages/tv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:jikan_api/jikan_api.dart';
import 'package:river_player/river_player.dart';
import 'package:video_player/video_player.dart';

class DNavigator {
  // to movie details
  static void toMovieDetails(Movie movie) {
    Get.to(() => BlocProvider(
          create: (context) {
            return MovieDetailCubit();
          },
          child: Builder(builder: (context) {
            context
                .read<MovieDetailCubit>()
                .add(LoadMovieDetailsEvent(movie.id!));
            return MovieDetailsPage(movie: movie);
          }),
        ));
  }

  // to TV Details
  static void toTVDetails(TvModel tv) {
    Get.to(() => BlocProvider(
          create: (context) => TvDetailCubit(),
          child: TvDetailsPage(tv: tv),
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
    final sources = await goAnime.getEpisodesLinksOfAnime(anime);
    return sources;
  }
}
