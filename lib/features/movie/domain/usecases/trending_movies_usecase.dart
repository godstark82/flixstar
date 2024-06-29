import 'package:flixstar/core/resources/data_state.dart';
import 'package:flixstar/core/usecases/usecase.dart';
import 'package:flixstar/features/movie/data/models/movie_model.dart';
import 'package:flixstar/features/movie/data/repositories/movie_repo_impl.dart';
import 'package:flixstar/injection_container.dart';

class GetTrendingMoviesUseCase extends UseCase<DataState<List<Movie>>, void> {
  GetTrendingMoviesUseCase();

  @override
  Future<DataState<List<Movie>>> call(void params) async {
    final movieRepository = sl<MovieRepositoryImpl>();
    return await movieRepository.getTrendingMovies();
  }
}
