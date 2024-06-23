import 'dart:developer';

import 'package:dooflix/data/models/tv_details_model.dart';
import 'package:dooflix/data/repositories/tv_repo.dart';
import 'package:dooflix/logic/blocs/episodes_bloc/episodes_event.dart';
import 'package:dooflix/logic/blocs/episodes_bloc/episodes_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EpisodesBloc extends Bloc<EpisodesEvent, EpisodeStates> {
  EpisodesBloc() : super(LoadedEpisodeState(episodes: [])) {
    on<OpenSeasonEpisodesEvent>(_openSeasonEpisodes);
  }

  void _openSeasonEpisodes(
      OpenSeasonEpisodesEvent event, Emitter<EpisodeStates> emit) async {
    try {
      emit(LoadingEpisodeState());
      final TvRepository repo = TvRepository();
      List<TvEpisode> episodes = await repo.findSeasonEpisodes(
          tvId: event.tvId, seasonCount: event.seasonId);
      log(episodes.toString());
      emit(LoadedEpisodeState(episodes: episodes));
    } catch (e) {
      emit(ErrorEpisodeState(message: e.toString()));
      print(e.toString());
      rethrow;
    }
  }
}
