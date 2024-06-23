// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:developer';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dooflix/core/utils/toast.dart';
import 'package:dooflix/data/models/movie_model.dart';
import 'package:dooflix/logic/blocs/history_bloc.dart/history_bloc.dart';
import 'package:dooflix/logic/blocs/history_bloc.dart/history_event.dart';
import 'package:dooflix/logic/blocs/library_bloc/library_bloc.dart';
import 'package:dooflix/logic/blocs/library_bloc/library_event.dart';
import 'package:dooflix/logic/blocs/library_bloc/library_state.dart';
import 'package:dooflix/logic/blocs/video_player_bloc/video_player_bloc.dart';
import 'package:dooflix/logic/cubits/movie_details_cubit/movie_detail_cubit.dart';
import 'package:dooflix/logic/cubits/movie_details_cubit/movie_detail_event.dart';
import 'package:dooflix/logic/cubits/movie_details_cubit/movie_detail_state.dart';
import 'package:dooflix/presentation/common/video_player.dart';
import 'package:dooflix/presentation/widgets/heading_widget.dart';
import 'package:dooflix/presentation/widgets/movie_card.dart';
import 'package:dooflix/presentation/widgets/play_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class MovieDetailsPage extends StatelessWidget {
  final Movie movie;

  const MovieDetailsPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        _buildAppBar(context, movie),
        _buildOverview(movie),
        _buildotherOptions(context, movie),
      ],
    );
  }
}

SliverAppBar _buildAppBar(BuildContext context, Movie movie) {
  return SliverAppBar(
    primary: true,
    bottom: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: BlocBuilder<MovieDetailCubit, MovieDetailState>(
              builder: (context, state) {
                if (state is LoadingMovieDetailState) {
                  return Center(
                    child: SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator()),
                  );
                } else if (state is LoadedMovieDetailState) {
                  return PlayButton(
                    icon: Icon(state.source?.url != null
                        ? Icons.play_arrow
                        : Icons.info),
                    label: Text(
                        state.source?.url != null ? 'Play' : 'Coming Soon..'),
                    onPressed: () async {
                      if (state.source?.url != null) {
                        if (!context
                            .read<HistoryBloc>()
                            .state
                            .movies
                            .contains(movie)) {
                          context
                              .read<HistoryBloc>()
                              .add(AddToHistoryEvent(movie: movie));
                        }
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => BlocProvider(
                                      create: (context) => VideoPlayerBloc(),
                                      child: VideoPlayerScreen(
                                        id: movie.id!,
                                        url: state.source!.url!,
                                      ),
                                    )));
                      } else {
                        Utils.toast('Coming Soon...');
                      }
                    },
                  );
                } else {
                  return Center(
                    child: Text('Error'),
                  );
                }
              },
            ))),
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
