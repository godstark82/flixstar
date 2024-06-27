import 'package:dooflix/core/resources/data_state.dart';
import 'package:dooflix/core/usecases/usecase.dart';
import 'package:dooflix/features/movie/data/models/movie_model.dart';
import 'package:dooflix/features/movie/data/repositories/movie_repo_impl.dart';
import 'package:dooflix/injection_container.dart';

class GetMovieDetailUseCase extends UseCase<DataState<Movie>, Movie> {
  GetMovieDetailUseCase();

  @override
  Future<DataState<Movie>> call(Movie params) async {
    final movieRepository = sl<MovieRepositoryImpl>();
    return await movieRepository.getMovieDetail(movie: params);
  }
}
