import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flixstar/features/library/presentation/bloc/library_bloc.dart';
import 'package:flixstar/features/library/presentation/bloc/library_event.dart';
import 'package:flixstar/features/library/presentation/bloc/library_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:flixstar/core/common/widgets/details_chip.dart';
import 'package:flixstar/core/common/widgets/dns_dialogue.dart';
import 'package:flixstar/core/common/widgets/play_button.dart';
import 'package:flixstar/core/const/const.dart';
import 'package:flixstar/features/history/presentation/bloc/history_bloc.dart';
import 'package:flixstar/features/history/presentation/bloc/history_event.dart';
import 'package:flixstar/features/tv/data/models/tv_model.dart';
import 'package:flixstar/features/tv/presentation/bloc/tv_bloc.dart';

SliverAppBar buildAppBar(BuildContext context, TvModel tv) {
  return SliverAppBar(
      primary: true,
      actions: [
        BlocBuilder<LibraryBloc, LibraryState>(
          builder: (context, libState) {
            if (libState is LoadedLibraryState) {
              return IconButton(
                icon: libState.tvs.contains(tv)
                    ? Icon(
                        Icons.favorite,
                        color: Colors.pink,
                      )
                    : Icon(
                        Icons.favorite_border,
                      ),
                onPressed: () {
                  !libState.tvs.contains(tv)
                      ? context.read<LibraryBloc>().add(AddTvToLibrary(tv))
                      : context
                          .read<LibraryBloc>()
                          .add(RemoveTvFromLibrary(tv));
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
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
                          icon: Icon(Icons.play_arrow),
                          label: Text('Play'),
                          onPressed: () async {
                            if (!context
                                .read<HistoryBloc>()
                                .state
                                .tvs
                                .contains(tv)) {
                              context
                                  .read<HistoryBloc>()
                                  .add(AddToHistoryEvent(tv: tv));
                            }
                            //! Navigate to Video Player

                            // Get.to(() => TvPlayer(id: state.tv!.id!));
                            Get.toNamed('/watch/tv/${tv.id}',
                                parameters: {'tid': tv.id.toString()});
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
                      image:
                          CachedNetworkImageProvider(tv.posterPath.toString()),
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
                                imageUrl: tv.posterPath.toString(),
                                height: context.height * 0.25),
                            SizedBox(height: 15),
                            Text(tv.originalName ?? tv.name ?? 'N/A',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(color: Colors.white)),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  DetailsChip(
                                      text: tv.originalLanguage
                                          .toString()
                                          .toUpperCase()),
                                  SizedBox(width: 15),
                                  DetailsChip(
                                      text: (DateTime.tryParse(
                                                  tv.firstAirDate.toString())
                                              ?.year)
                                          .toString()),
                                  SizedBox(width: 15),
                                  DetailsChip(
                                      text: tv.adult == true ? '18+' : '13+'),
                                ]),
                            SizedBox(
                              height: 25,
                            )
                          ]))))));
}
