import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dooflix/features/anime/data/models/anime_genre_model.dart';
import 'package:dooflix/features/anime/domain/usecases/anime_detail_usecase.dart';
import 'package:dooflix/features/anime/domain/usecases/anime_genre.dart';
import 'package:dooflix/features/anime/domain/usecases/genre_animes_usecase.dart';
import 'package:dooflix/features/anime/domain/usecases/popular_anime.dart';
import 'package:dooflix/features/anime/domain/usecases/top_anime_usercase.dart';
import 'package:equatable/equatable.dart';
import 'package:jikan_api/jikan_api.dart';
part 'anime_event.dart';
part 'anime_state.dart';

class AnimeHomeBloc extends Bloc<AnimeHomeEvent, AnimeHomeState> {
  final TopAnimeUseCase topAnimeUseCase;
  final PopularAnimeUseCase popularAnimeUseCase;
  final GenresOfAnimeUseCase genresOfAnimeUseCase;
  final GenreAnimesUsecase genreAnimesUsecase;
  AnimeHomeBloc(this.topAnimeUseCase, this.popularAnimeUseCase,
      this.genresOfAnimeUseCase, this.genreAnimesUsecase)
      : super(AnimeLoading()) {
    on<LoadAnimeHomeData>((event, emit) async {
      try {
        final topAnime = await topAnimeUseCase(1);
        final popularAnime = await popularAnimeUseCase(2);
        final genres = await genresOfAnimeUseCase(GenreType.genres);
        List<AnimeGenreModel> genreAnime = [];
        
        await Future.wait<void>([
          for (int i = 0; i < genres.data!.length; i++)
            genreAnimesUsecase
                .call({'id': genres.data![i].malId, 'page': 1}).then((value) {
              genreAnime.add(AnimeGenreModel(
                  title: genres.data![i].name,
                  id: genres.data![i].malId,
                  animes: List.from(value.data!.toList())));
            })
        ]);
       
       
        log('${genres.data}');
        emit(AnimeLoaded(
            genres: genres.data,
            genreAnime: genreAnime,
            popularAnime: popularAnime.data,
            topAnime: topAnime.data));
      } catch (e) {
        emit(AnimeError(e.toString()));
      }
    });
  }
}
