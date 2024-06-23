import 'package:dooflix/data/models/tv_details_model.dart';
import 'package:dooflix/logic/blocs/episodes_bloc/episodes_bloc.dart';
import 'package:dooflix/logic/blocs/episodes_bloc/episodes_state.dart';
import 'package:dooflix/presentation/widgets/episode_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EpisodesOfSeasonPage extends StatelessWidget {
  final int tvId;
  final Seasons season;
  const EpisodesOfSeasonPage(
      {super.key, required this.season, required this.tvId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('S${season.seasonNumber}: ${season.name}')),
      body: BlocBuilder<EpisodesBloc, EpisodeStates>(
        builder: (context, state) {
          if (state is LoadedEpisodeState) {
            return ListView.builder(
                itemCount: state.episodes.length,
                itemBuilder: (context, index) {
                  return EpisodeCard(
                    url: (state.episodes[index].playingSource?.url).toString(),
                      episode: state.episodes[index], tvId: tvId);
                });
          } else if (state is LoadingEpisodeState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ErrorEpisodeState) {
            return Center(child: Text(state.message));
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
