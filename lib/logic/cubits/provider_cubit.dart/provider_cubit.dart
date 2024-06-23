import 'dart:developer';

import 'package:dooflix/data/models/movie_model.dart';
import 'package:dooflix/data/models/network_model.dart';
import 'package:dooflix/data/models/tv_model.dart';
import 'package:dooflix/data/repositories/movie_repo.dart';
import 'package:dooflix/data/repositories/tv_repo.dart';
import 'package:dooflix/logic/cubits/provider_cubit.dart/provider_event.dart';
import 'package:dooflix/logic/cubits/provider_cubit.dart/provider_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProviderCubit extends Bloc<ProviderEvent,ProviderState> {
  ProviderCubit() : super(LoadingProviderState()) {
    // _loadProviderMovies();
    on<LoadProviderMovies>(_loadProviderMovies);
  }

  void _loadProviderMovies(LoadProviderMovies event, Emitter<ProviderState> emit) async {
    List<Movie> movies = [];
    List<TvModel> tvs = [];

    movies = await MovieRepository().getNetworkMovies(event.network.name);
   
    tvs = await TvRepository().getNetworkTvs(event.network.name);
    
    emit(LoadedProviderState(movies: movies, tvs: tvs));
  }
}
