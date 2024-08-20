
import 'package:bloc/bloc.dart';
import 'package:flixstar/features/movie/data/models/movie_model.dart';
import 'package:flixstar/features/search/data/repositories/seach_repo_impl.dart';
import 'package:flixstar/features/anime/data/repositories/anime_repo_impl.dart';
import 'package:flixstar/features/tv/data/models/tv_model.dart';
import 'package:flixstar/injection_container.dart';
import 'package:equatable/equatable.dart';
import 'package:jikan_api/jikan_api.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(InitialState()) {
    on<InitiateSearchEvent>(_initiateSearch);
  }

  void _initiateSearch(
      InitiateSearchEvent event, Emitter<SearchState> emit) async {
    emit(LoadingSearchState());
    SeachRepoImpl repo = SeachRepoImpl();
    AnimeRepoImpl animeRepo = AnimeRepoImpl(sl());
    List<Movie> movies = (await repo.searchMovie(event.query)).data ?? [];
    List<TvModel> tvs = (await repo.searchTv(event.query)).data ?? [];
    BuiltList<Anime> animes =
        (await animeRepo.searchAnime(query: event.query)).data ?? BuiltList([]);
    emit(LoadedSearchState(movies, fetchedTv: tvs, fetchedAnimes: animes));
  }
}
