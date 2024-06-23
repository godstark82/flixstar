import 'package:dooflix/data/models/tv_details_model.dart';
import 'package:dooflix/core/utils/constants.dart';
import 'package:dooflix/logic/blocs/episodes_bloc/episodes_bloc.dart';
import 'package:dooflix/logic/blocs/episodes_bloc/episodes_event.dart';
import 'package:dooflix/presentation/pages/episodes_in_season_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class SeasonCard extends StatelessWidget {
  final int tvId;
  final Seasons season;
  const SeasonCard({super.key, required this.season, required this.tvId});

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: InkWell(
        onTap: () {
          context
              .read<EpisodesBloc>()
              .add(OpenSeasonEpisodesEvent(seasonId: season.seasonNumber!, tvId: tvId));
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EpisodesOfSeasonPage(
                        season: season,
                        tvId: tvId,
                      )));
        },
        child: Container(
          margin: EdgeInsets.all(12),
          height: context.height * 0.175,
          width: context.width * 0.5,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    season.posterPath.toString().endsWith('null')
                        ? Constants.backdroPlaceholder
                        : season.posterPath.toString()),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Colors.transparent,
                  Colors.transparent,
                  Colors.black.withOpacity(0.5),
                  Colors.black.withOpacity(0.7)
                ])),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 0),
                Center(
                  child: Icon(Icons.play_circle),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'S${season.seasonNumber}: ${season.name}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
