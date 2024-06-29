import 'package:flixstar/core/resources/data_state.dart';
import 'package:flixstar/core/usecases/usecase.dart';
import 'package:flixstar/features/movie/data/models/movie_model.dart';
import 'package:flixstar/features/movie/data/repositories/movie_repo_impl.dart';
import 'package:flixstar/injection_container.dart';

class GetMovieDetailUseCase extends UseCase<DataState<Movie>, Movie> {
  GetMovieDetailUseCase();

  @override
  Future<DataState<Movie>> call(Movie params) async {
    final movieRepository = sl<MovieRepositoryImpl>();
    return await movieRepository.getMovieDetail(movie: params);
  }
}
