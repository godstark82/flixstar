
import 'package:bloc/bloc.dart';
import 'package:flixstar/core/const/const.dart';
import 'package:flixstar/features/movie/data/models/movie_model.dart';
import 'package:flixstar/features/movie/domain/usecases/related_movies_usecase.dart';
import 'package:flixstar/features/movie/presentation/bloc/movie_state.dart';
import 'package:equatable/equatable.dart';

part 'movie_event.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetRelatedMoviesUseCase getRelatedMoviesUseCase;

  MovieBloc(this.getRelatedMoviesUseCase) : super(MovieLoadingState()) {
    on<LoadMovieDetailEvent>(_onLoadMovieDetail);
  }

  void _onLoadMovieDetail(
      LoadMovieDetailEvent event, Emitter<MovieState> emit) async {
    emit(MovieLoadingState());
    try {
      // 533535

      final similar = await getRelatedMoviesUseCase.call(event.movie.id!);

      emit(MovieLoadedState(similar: similar.data));
    } catch (e) {
      emit(MovieErrorState(
          'Failed to load movie source after $maxRetries attempts.'));
    }
  }
}
