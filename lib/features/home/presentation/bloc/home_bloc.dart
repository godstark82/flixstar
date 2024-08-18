import 'package:bloc/bloc.dart';
import 'package:flixstar/core/resources/data_state.dart';
import 'package:flixstar/features/anime/data/models/anime_genre_model.dart';
import 'package:flixstar/features/anime/domain/usecases/all_genre_data_usecase.dart';
import 'package:flixstar/features/anime/domain/usecases/top_anime_usercase.dart';
import 'package:flixstar/features/movie/data/models/genre_movie_model.dart';
import 'package:flixstar/features/tv/data/models/genre_tv_model.dart';
import 'package:flixstar/features/movie/data/models/movie_model.dart';
import 'package:flixstar/features/movie/domain/usecases/genre_detail_usecase.dart';
import 'package:flixstar/features/movie/domain/usecases/popular_movies_usecase.dart';
import 'package:flixstar/features/movie/domain/usecases/trending_movies_usecase.dart';
import 'package:flixstar/features/tv/data/models/tv_model.dart';
import 'package:flixstar/features/tv/domain/usecases/genres_data_usecase.dart';
import 'package:flixstar/features/tv/domain/usecases/top_rated_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:jikan_api/jikan_api.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  // Movies
  final GetTrendingMoviesUseCase _getTrendingMoviesUseCase;
  final GetPopularMoviesUseCase _getPopularMoviesUseCase;
  final GenreDetailUsecase _genreDetailUsecase;

  // TVs
  final GetTopRatedTvsUseCase _getTopRatedTvsUseCase;
  final GetAllTvGenresUseCase _getAllTvGenresUseCase;

  // Anime
  final TopAnimeUseCase topAnimeUseCase;
  final GetAnimeGenresDataUseCase getAnimeGenresDataUseCase;

  HomeBloc(
    this._genreDetailUsecase,
    this._getPopularMoviesUseCase,
    this._getTrendingMoviesUseCase,
    this._getAllTvGenresUseCase,
    this._getTopRatedTvsUseCase,
    this.getAnimeGenresDataUseCase,
    this.topAnimeUseCase,
  ) : super(HomeLoadingState()) {
    on<LoadHomeDataEvent>((event, emit) async {
      Stopwatch stopwatch = Stopwatch()..start();

      try {
        print('Fetching Data');

        // Perform all async operations concurrently
        final results = await Future.wait<DataState<dynamic>>([
          _getTrendingMoviesUseCase({}),
          _getPopularMoviesUseCase({}),
          _genreDetailUsecase({}),
          _getTopRatedTvsUseCase({}),
          _getAllTvGenresUseCase({}),
        ]);

        print(
            'Movies and TV data fetched in ${stopwatch.elapsed.inMilliseconds}ms');
        final trendingMovies = results[0].data;
        final popularMovies = results[1].data;
        final movieGenreDetails = results[2].data;
        final topRatedTvs = results[3].data;
        final tvGenreDetails = results[4].data;

        // emit the State
        emit(HomeAnimeLoadingState(
          trendingMovie: trendingMovies,
          popularMovie: popularMovies,
          movieGenres: movieGenreDetails,
          topRatedTvs: topRatedTvs,
          tvGenres: tvGenreDetails,
        ));

        // Fetch Anime data concurrently with finer granularity
        final animeResults = await Future.wait<DataState<dynamic>>([
          topAnimeUseCase.call(1),
          getAnimeGenresDataUseCase.call(null),
        ]);

        print('Anime data fetched in ${stopwatch.elapsed.inMilliseconds}ms');

        final topAnime = animeResults[0].data;
        final genresData = animeResults[1].data;

        emit(HomeLoadedState(
          popularMovie: popularMovies,
          topRatedTvs: topRatedTvs,
          tvGenres: tvGenreDetails,
          trendingMovie: trendingMovies,
          movieGenres: movieGenreDetails,
          animeGenreData: genresData,
          topAnime: topAnime,
        ));
      } catch (e) {
        // emit(HomeErrorState(e.toString()));
      }
    });
  }
}
