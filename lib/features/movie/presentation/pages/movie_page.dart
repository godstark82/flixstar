// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flixstar/common/url_video_player.dart';
import 'package:flixstar/core/const/const.dart';
import 'package:flixstar/features/history/presentation/bloc/history_bloc.dart';
import 'package:flixstar/features/history/presentation/bloc/history_event.dart';
import 'package:flixstar/features/movie/presentation/bloc/movie_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:flixstar/common/play_button.dart';
import 'package:flixstar/common/video_player.dart';
import 'package:flixstar/features/library/presentation/bloc/library_bloc.dart';
import 'package:flixstar/features/library/presentation/bloc/library_event.dart';
import 'package:flixstar/features/library/presentation/bloc/library_state.dart';
import 'package:flixstar/features/movie/data/models/movie_model.dart';
import 'package:flixstar/features/movie/presentation/bloc/movie_bloc.dart';
import 'package:startapp_sdk/startapp.dart';

class MovieDetailsPage extends StatelessWidget {
  final Movie movie;

  const MovieDetailsPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    context.read<MovieBloc>().add(LoadMovieDetailEvent(movie: movie));
    return CustomScrollView(
      slivers: [
        _buildAppBar(context, movie),
        _buildOverview(movie),
        _buildotherOptions(context, movie),
        if (showAds) _buildBannerAd(),
      ],
    );
  }
}

SliverAppBar _buildAppBar(BuildContext context, Movie movie) {
  return SliverAppBar(
    primary: true,
    bottom: streamMode
        ? PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: BlocBuilder<MovieBloc, MovieState>(
                builder: (context, state) {
                  if (state is MovieLoadingState) {
                    return Center(
                      child: SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator()),
                    );
                  } else if (state is MovieLoadedState) {
                    return PlayButton(
                      icon: Icon(state.sourceHtml != null
                          ? Icons.play_arrow
                          : Icons.info),
                      label: Text(
                          state.sourceHtml != null ? 'Play' : 'Coming Soon..'),
                      onPressed: () async {
                        if (state.sourceHtml != null) {
                          if (!context
                              .read<HistoryBloc>()
                              .state
                              .movies
                              .contains(movie)) {
                            context
                                .read<HistoryBloc>()
                                .add(AddToHistoryEvent(movie: movie));
                          }
                          if (kIsWeb) {
                            Get.to(
                                () => WebVideoPlayer(html: state.sourceHtml!));
                          } else {
                            if (Platform.isWindows) {
                              Get.to(() =>
                                  WebVideoPlayer(html: state.sourceHtml!));
                            }
                            if (Platform.isAndroid) {
                              Get.to(
                                  () => VideoPlayer(html: state.sourceHtml!));
                            }
                          }
                        } else {}
                      },
                    );
                  } else {
                    return Center(
                      child: TextButton(
                          onPressed: () {
                            context
                                .read<MovieBloc>()
                                .add(LoadMovieDetailEvent(movie: movie));
                          },
                          child: Text('Retry')),
                    );
                  }
                },
              ),
            ),
          )
        : PreferredSize(preferredSize: Size.zero, child: SizedBox()),
    forceMaterialTransparency: true,
    // backgroundColor: Colors.black,
    expandedHeight: context.height * 0.5,
    pinned: true,
    flexibleSpace: FlexibleSpaceBar(
      // title: Text(movie.title ?? movie.name.toString()),
      collapseMode: CollapseMode.parallax,
      background: Container(
        // filter: ImageFilter.blur(sigmaX: 12,sigmaY: 12),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: CachedNetworkImageProvider(movie.posterPath.toString()),
                fit: BoxFit.cover)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
              decoration: BoxDecoration(
                  // color: Colors.black.withOpacity(0.2),
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
                  Text(movie.title ?? movie.name.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(color: Colors.white)),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    DetailsChip(
                        text: movie.originalLanguage.toString().toUpperCase()),
                    SizedBox(width: 15),
                    DetailsChip(
                        text: (DateTime.tryParse(movie.releaseDate.toString())
                                ?.year)
                            .toString()),
                    SizedBox(width: 15),
                    DetailsChip(text: movie.adult == true ? '18+' : '13+'),
                  ]),
                  SizedBox(
                    height: 25,
                  )
                ],
              )),
        ),
      ),
    ),
  );
}

SliverToBoxAdapter _buildBannerAd() {
  return SliverToBoxAdapter(
    child: BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        if (state is MovieLoadedState) {
          return state.bannerAd != null
              ? StartAppBanner(state.bannerAd!)
              : SizedBox();
        }
        return SizedBox();
      },
    ),
  );
}

SliverToBoxAdapter _buildOverview(Movie movie) {
  return SliverToBoxAdapter(
      child: Material(
    color: Colors.transparent,
    child: Container(
        padding: const EdgeInsets.all(12.0),
        child: Text(movie.overview.toString(),
            maxLines: 4, overflow: TextOverflow.ellipsis)),
  ));
}

SliverToBoxAdapter _buildotherOptions(BuildContext context, Movie movie) {
  return SliverToBoxAdapter(
    child: SizedBox(
      // height: 500,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlocBuilder<LibraryBloc, LibraryState>(
              builder: (context, libState) {
                if (libState is LoadedLibraryState) {
                  return OtherOptions(
                    iconData: libState.movies.contains(movie)
                        ? Icon(
                            Icons.favorite,
                            color: Colors.pink,
                          )
                        : Icon(
                            Icons.favorite_border,
                          ),
                    text:
                        libState.movies.contains(movie) ? 'Remove' : 'My List',
                    onPressed: () {
                      !libState.movies.contains(movie)
                          ? context
                              .read<LibraryBloc>()
                              .add(AddMovieToLibrary(movie))
                          : context
                              .read<LibraryBloc>()
                              .add(RemoveMovieFromLibrary(movie));
                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
            OtherOptions(iconData: Icon(Icons.movie_outlined), text: 'Trailer'),
            OtherOptions(iconData: Icon(Icons.report_sharp), text: 'Report'),
            OtherOptions(iconData: Icon(Icons.share), text: 'Share')
          ],
        ),
      ),
    ),
  );
}

class DetailsChip extends StatelessWidget {
  final String text;
  const DetailsChip({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 5,
          width: 5,
          decoration: BoxDecoration(
              color: Colors.amber.shade600,
              borderRadius: BorderRadius.circular(50)),
        ),
        SizedBox(width: 5),
        Text(
          text,
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
        )
      ],
    );
  }
}

class OtherOptions extends StatelessWidget {
  final Icon iconData;
  final String text;
  final VoidCallback? onPressed;
  const OtherOptions(
      {super.key, required this.iconData, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                iconData,
                SizedBox(height: 5),
                Text(
                  text,
                  style: TextStyle(color: Colors.grey),
                ),
              ]),
        ),
      ),
    );
  }
}
