import 'package:flixstar/core/resources/data_state.dart';
import 'package:flixstar/core/usecases/usecase.dart';
import 'package:flixstar/features/movie/data/models/movie_model.dart';
import 'package:flixstar/features/movie/domain/repositories/movie_repository.dart';
import 'package:flixstar/injection_container.dart';

class GetMovieDetailUseCase extends UseCase<DataState<Movie>, Movie> {
  GetMovieDetailUseCase();

  @override
  Future<DataState<Movie>> call(Movie params) async {
    final movieRepository = sl<MovieRepository>();
    return await movieRepository.getMovieDetail(movie: params);
  }
}
