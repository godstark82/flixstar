import 'dart:io';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flixstar/common/pages/url_video_player.dart';
import 'package:flixstar/common/pages/video_player.dart';
import 'package:flixstar/common/widgets/details_chip.dart';
import 'package:flixstar/common/widgets/dns_dialogue.dart';
import 'package:flixstar/common/widgets/play_button.dart';
import 'package:flixstar/core/const/const.dart';
import 'package:flixstar/features/history/presentation/bloc/history_bloc.dart';
import 'package:flixstar/features/history/presentation/bloc/history_event.dart';
import 'package:flixstar/features/tv/data/models/tv_model.dart';
import 'package:flixstar/features/tv/presentation/bloc/tv_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

SliverAppBar buildAppBar(BuildContext context, TvModel movie) {
  return SliverAppBar(
      primary: true,
      actions: [
        IconButton(
            onPressed: () {
              showDialog(
                  context: context, builder: (context) => dnsDialogue(context));
            },
            icon: Icon(
              Icons.help,
              color: Colors.white,
            ))
      ],
      bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: streamMode
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child:
                      BlocBuilder<TvBloc, TvState>(builder: (context, state) {
                    if (state is TvLoadingState) {
                      return Center(
                        child: SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator()),
                      );
                    } else if (state is TvLoadedState) {
                      return PlayButton(
                          icon: Icon(state.html != null
                              ? Icons.play_arrow
                              : Icons.info),
                          label: Text(
                              state.html != null ? 'Play' : 'Coming Soon..'),
                          onPressed: () async {
                            if (state.html != null) {
                              if (!context
                                  .read<HistoryBloc>()
                                  .state
                                  .tvs
                                  .contains(movie)) {
                                context
                                    .read<HistoryBloc>()
                                    .add(AddToHistoryEvent(tv: movie));
                              }
                              if (kIsWeb) {
                                Get.to(() => WebVideoPlayer(html: state.html!));
                              } else {
                                if (Platform.isWindows) {
                                  Get.to(
                                      () => WebVideoPlayer(html: state.html!));
                                }
                                if (Platform.isAndroid) {
                                  Get.to(() => VideoPlayer(html: state.html!));
                                }
                              }
                            }
                          });
                    } else if (state is TvErrorState) {
                      return Center(
                        child: PlayButton(
                          icon: Icon(Icons.help),
                          label: Text('Not Available'),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => dnsDialogue(context));
                          },
                        ),
                      );
                    }
                    return SizedBox();
                  }))
              : SizedBox()),
      forceMaterialTransparency: true,
      expandedHeight: context.height * 0.5,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
          collapseMode: CollapseMode.parallax,
          background: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(
                          movie.posterPath.toString()),
                      fit: BoxFit.cover)),
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                  child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                            Colors.black.withOpacity(0.2),
                            Colors.transparent.withOpacity(0.2),
                            Colors.black.withOpacity(0.9),
                          ])),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CachedNetworkImage(
                                imageUrl: movie.posterPath.toString(),
                                height: context.height * 0.25),
                            SizedBox(height: 15),
                            Text(movie.originalName ?? movie.name.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(color: Colors.white)),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  DetailsChip(
                                      text: movie.originalLanguage
                                          .toString()
                                          .toUpperCase()),
                                  SizedBox(width: 15),
                                  DetailsChip(
                                      text: (DateTime.tryParse(
                                                  movie.firstAirDate.toString())
                                              ?.year)
                                          .toString()),
                                  SizedBox(width: 15),
                                  DetailsChip(
                                      text:
                                          movie.adult == true ? '18+' : '13+'),
                                ]),
                            SizedBox(
                              height: 25,
                            )
                          ]))))));
}
