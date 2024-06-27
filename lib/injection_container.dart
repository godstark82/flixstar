import 'package:dio/dio.dart';
import 'package:dooflix/api/api.dart';
import 'package:dooflix/api/gogo_api.dart';

import 'package:dooflix/features/anime/data/repositories/anime_repo_impl.dart';
import 'package:dooflix/features/anime/domain/usecases/all_genre_data_usecase.dart';
import 'package:dooflix/features/anime/domain/usecases/anime_detail_usecase.dart';
import 'package:dooflix/features/anime/domain/usecases/top_anime_usercase.dart';
import 'package:dooflix/features/history/data/repositories/history_repo_impl.dart';
import 'package:dooflix/features/home/presentation/bloc/home_bloc.dart';
import 'package:dooflix/features/movie/data/repositories/movie_repo_impl.dart';
import 'package:dooflix/features/movie/domain/usecases/genre_detail_usecase.dart';
import 'package:dooflix/features/movie/domain/usecases/movie_detail_usercase.dart';
import 'package:dooflix/features/movie/domain/usecases/popular_movies_usecase.dart';
import 'package:dooflix/features/movie/domain/usecases/top_rated_movie_usecase.dart';
import 'package:dooflix/features/movie/domain/usecases/trending_movies_usecase.dart';
import 'package:dooflix/features/movie/presentation/bloc/movie_bloc.dart';
import 'package:dooflix/features/tv/data/repositories/tv_repo_impl.dart';
import 'package:dooflix/features/tv/domain/usecases/genres_data_usecase.dart';
import 'package:dooflix/features/tv/domain/usecases/top_rated_usecase.dart';
import 'package:dooflix/features/tv/domain/usecases/tv_detail_usecase.dart';
import 'package:dooflix/features/tv/presentation/bloc/tv_bloc.dart';

import 'package:get_it/get_it.dart';
import 'package:jikan_api/jikan_api.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerSingleton(Dio());
  // api
  sl.registerSingleton<API>(API());
  sl.registerSingleton<Jikan>(Jikan());
  sl.registerSingleton<GoAnime>(GoAnime(sl()));

  // repo
  sl.registerLazySingleton(() => AnimeRepoImpl(sl()));
  sl.registerLazySingleton(() => MovieRepositoryImpl(sl()));
  sl.registerLazySingleton(() => HistoryRepoImpl());
  sl.registerLazySingleton(() => TvRepoImpl());

  // usecases
  sl.registerLazySingleton(() => GetMovieDetailUseCase());
  sl.registerLazySingleton(() => GetAnimeGenresDataUseCase(sl()));
  sl.registerLazySingleton(() => GetTrendingMoviesUseCase());
  sl.registerLazySingleton(() => GenreDetailUsecase());
  sl.registerLazySingleton(() => GetPopularMoviesUseCase());
  sl.registerLazySingleton(() => GetTopRatedMoviesUseCase());
  sl.registerLazySingleton(() => GetTopRatedTvsUseCase());
  sl.registerLazySingleton(() => GetAllTvGenresUseCase());
  sl.registerLazySingleton(() => GetTvDetailsUseCase());
  sl.registerLazySingleton(() => GetAnimeDetailUseCase());
  sl.registerLazySingleton(() => TopAnimeUseCase());

  // blocs
  sl.registerFactory(() => HomeBloc(sl(), sl(), sl(), sl(), sl(), sl(), sl()));
  sl.registerFactory(() => MovieBloc(sl()));
  sl.registerFactory(() => TvBloc(sl()));
}
