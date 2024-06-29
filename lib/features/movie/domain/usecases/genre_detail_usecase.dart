import 'package:flixstar/core/resources/data_state.dart';
import 'package:flixstar/core/usecases/usecase.dart';
import 'package:flixstar/features/movie/data/models/genre_movie_model.dart';
import 'package:flixstar/features/movie/data/repositories/movie_repo_impl.dart';
import 'package:flixstar/injection_container.dart';

class GenreDetailUsecase
    extends UseCase<DataState<List<GenreMovieModel>>, void> {
  GenreDetailUsecase();

  @override
  Future<DataState<List<GenreMovieModel>>> call(void params) async {
    final movieRepository = sl<MovieRepositoryImpl>();
    return await movieRepository.getAllGenreData();
  }
}
