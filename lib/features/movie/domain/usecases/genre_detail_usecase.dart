import 'package:dooflix/core/resources/data_state.dart';
import 'package:dooflix/core/usecases/usecase.dart';
import 'package:dooflix/features/movie/data/models/genre_movie_model.dart';
import 'package:dooflix/features/movie/data/repositories/movie_repo_impl.dart';
import 'package:dooflix/injection_container.dart';

class GenreDetailUsecase
    extends UseCase<DataState<List<GenreMovieModel>>, void> {
  GenreDetailUsecase();

  @override
  Future<DataState<List<GenreMovieModel>>> call(void params) async {
    final movieRepository = sl<MovieRepositoryImpl>();
    return await movieRepository.getAllGenreData();
  }
}
