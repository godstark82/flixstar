import 'package:dio/dio.dart';
import 'package:dooflix/api/gogo_api.dart';
import 'package:dooflix/core/usecases/usecase.dart';
import 'package:dooflix/features/anime/data/repositories/anime_repo_impl.dart';
import 'package:dooflix/features/anime/domain/repositories/anime_repository.dart';
import 'package:dooflix/features/anime/domain/usecases/anime_detail_usecase.dart';
import 'package:dooflix/features/anime/domain/usecases/anime_genre.dart';
import 'package:dooflix/features/anime/domain/usecases/genre_animes_usecase.dart';
import 'package:dooflix/features/anime/domain/usecases/popular_anime.dart';
import 'package:dooflix/features/anime/domain/usecases/top_anime_usercase.dart';
import 'package:dooflix/features/anime/presentation/bloc/anime_bloc.dart';
import 'package:dooflix/logic/cubits/movie_details_cubit/movie_detail_cubit.dart';
import 'package:dooflix/logic/cubits/tv_details_cubit/tv_detail_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:jikan_api/jikan_api.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerSingleton(Dio());
  // api
  sl.registerSingleton<Jikan>(Jikan());
  sl.registerSingleton<GoAnime>(GoAnime(sl()));

  // repo
  sl.registerLazySingleton<AnimeRepository>(() => AnimeRepoImpl(sl()));

  // usecases
  sl.registerLazySingleton<GetAnimeDetailUseCase>(
      () => GetAnimeDetailUseCase(sl()));
  sl.registerLazySingleton<TopAnimeUseCase>(() => TopAnimeUseCase(sl()));
  sl.registerLazySingleton<PopularAnimeUseCase>(
      () => PopularAnimeUseCase(sl()));
  sl.registerLazySingleton<GenresOfAnimeUseCase>(
      () => GenresOfAnimeUseCase(sl()));
  sl.registerLazySingleton<GenreAnimesUsecase>(() => GenreAnimesUsecase(sl()));

  // blocs
  sl.registerFactory(() => MovieDetailCubit());
  sl.registerFactory(() => TvDetailCubit());
  sl.registerFactory(() => AnimeHomeBloc(sl(), sl(), sl(), sl()));
}
