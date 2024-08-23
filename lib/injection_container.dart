import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flixstar/api/api.dart';
import 'package:flixstar/api/gogo_api.dart';
import 'package:flixstar/core/common/func/check_update.dart';
import 'package:flixstar/core/common/func/fetch_firebase_data.dart';
import 'package:flixstar/features/anime/data/repositories/anime_repo_impl.dart';
import 'package:flixstar/features/anime/domain/repositories/anime_repository.dart';
import 'package:flixstar/features/anime/domain/usecases/all_genre_data_usecase.dart';
import 'package:flixstar/features/anime/domain/usecases/anime_detail_usecase.dart';
import 'package:flixstar/features/anime/domain/usecases/top_anime_usercase.dart';
import 'package:flixstar/features/history/data/repositories/history_repo_impl.dart';
import 'package:flixstar/features/history/domain/repositories/history_repo.dart';
import 'package:flixstar/features/history/presentation/bloc/history_bloc.dart';
import 'package:flixstar/features/home/presentation/bloc/home_bloc.dart';
import 'package:flixstar/features/library/presentation/bloc/library_bloc.dart';
import 'package:flixstar/features/movie/data/repositories/movie_repo_impl.dart';
import 'package:flixstar/features/movie/domain/repositories/movie_repository.dart';
import 'package:flixstar/features/movie/domain/usecases/genre_detail_usecase.dart';
import 'package:flixstar/features/movie/domain/usecases/movie_detail_usercase.dart';
import 'package:flixstar/features/movie/domain/usecases/popular_movies_usecase.dart';
import 'package:flixstar/features/movie/domain/usecases/related_movies_usecase.dart';
import 'package:flixstar/features/movie/domain/usecases/top_rated_movie_usecase.dart';
import 'package:flixstar/features/movie/domain/usecases/trending_movies_usecase.dart';
import 'package:flixstar/features/movie/presentation/bloc/movie_bloc.dart';
import 'package:flixstar/features/search/presentation/bloc/search_bloc.dart';
import 'package:flixstar/features/tv/data/repositories/tv_repo_impl.dart';
import 'package:flixstar/features/tv/domain/repositories/tv_repository.dart';
import 'package:flixstar/features/tv/domain/usecases/genres_data_usecase.dart';
import 'package:flixstar/features/tv/domain/usecases/related_tv_usecase.dart';
import 'package:flixstar/features/tv/domain/usecases/top_rated_usecase.dart';
import 'package:flixstar/features/tv/domain/usecases/tv_detail_usecase.dart';
import 'package:flixstar/features/tv/presentation/bloc/tv_bloc.dart';
import 'package:flixstar/firebase_options.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jikan_api/jikan_api.dart';

final sl = GetIt.instance;
final analytics = FirebaseAnalytics.instance;

Future<void> initialiseDependencies() async {
  await dependencies();
  if (!kIsWeb) {
    if (!Platform.isWindows) {
      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);
      await fetchFirebaseData();
    }
  }

  

  await checkForNewUpdate();
  await Hive.initFlutter();
  await Future.wait([
    Hive.openBox('library'),
    Hive.openBox('settings'),
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  ]);
}

Future<void> dependencies() async {
  // core
  sl.registerSingleton<Dio>(Dio());

  // api
  sl.registerSingleton<API>(API());
  sl.registerSingleton<Jikan>(Jikan());
  sl.registerSingleton<GoAnime>(GoAnime(sl()));

  // repo
  sl.registerLazySingleton<AnimeRepository>(() => AnimeRepoImpl(sl()));
  sl.registerLazySingleton<MovieRepository>(() => MovieRepositoryImpl(sl()));
  sl.registerLazySingleton<HistoryRepository>(() => HistoryRepoImpl());
  sl.registerLazySingleton<TvRepository>(() => TvRepoImpl());

  // usecases
  sl.registerLazySingleton(() => GetRelatedTvUseCase());
  sl.registerLazySingleton(() => GetRelatedMoviesUseCase());
  sl.registerLazySingleton(() => GetMovieDetailUseCase());
  sl.registerLazySingleton(() => GetAnimeGenresDataUseCase());
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
  sl.registerFactory<HomeBloc>(
      () => HomeBloc(sl(), sl(), sl(), sl(), sl(), sl(), sl()));
  sl.registerFactory<MovieBloc>(() => MovieBloc(sl(), sl()));
  sl.registerFactory<TvBloc>(
      () => TvBloc(sl<GetTvDetailsUseCase>(), sl<GetRelatedTvUseCase>()));
  sl.registerFactory<LibraryBloc>(() => LibraryBloc());
  sl.registerFactory<HistoryBloc>(() => HistoryBloc(sl()));
  sl.registerFactory<SearchBloc>(() => SearchBloc());
}
