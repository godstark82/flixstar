import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dooflix/data/models/tv_details_model.dart';
import 'package:dooflix/data/models/tv_model.dart';
import 'package:dooflix/logic/blocs/history_bloc.dart/history_bloc.dart';
import 'package:dooflix/logic/blocs/history_bloc.dart/history_event.dart';
import 'package:dooflix/logic/blocs/library_bloc/library_bloc.dart';
import 'package:dooflix/logic/blocs/library_bloc/library_event.dart';
import 'package:dooflix/logic/blocs/library_bloc/library_state.dart';
import 'package:dooflix/logic/blocs/video_player_bloc/video_player_bloc.dart';
import 'package:dooflix/logic/cubits/tv_details_cubit/tv_detail_cubit.dart';
import 'package:dooflix/logic/cubits/tv_details_cubit/tv_detail_event.dart';
import 'package:dooflix/logic/cubits/tv_details_cubit/tv_detail_state.dart';
import 'package:dooflix/presentation/common/video_player.dart';
import 'package:dooflix/presentation/pages/movie_page.dart';
import 'package:dooflix/presentation/widgets/episode_card.dart';
import 'package:dooflix/presentation/widgets/heading_widget.dart';
import 'package:dooflix/presentation/widgets/my_snack.dart';
import 'package:dooflix/presentation/widgets/season_card.dart';
import 'package:dooflix/presentation/widgets/tv_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

// int selectedSeason = 1;

class TvDetailsPage extends StatelessWidget {
  final TvModel tv;
  const TvDetailsPage({super.key, required this.tv});

  @override
  Widget build(BuildContext context) {
    context.read<TvDetailCubit>().add(LoadTvDetailEvent(tv.id!));
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<TvDetailCubit, TvDetailState>(
        builder: (context, state) {
          if (state is LoadedTvDetailState) {
            return CustomScrollView(
              slivers: [
                buildSliverAppBar(context: context, tv: state.tv),
                buildOverviewSection(context: context, tv: state.tv),
                SliverToBoxAdapter(child: SeasonSection(state: state)),
              ],
            );
          } else if (state is LoadingTvDetailState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 10),
                Center(child: Text(state.msg)),
              ],
            );
          } else {
            return Center(child: Text('Some Error Occurred'));
          }
        },
      ),
    );
  }

  SliverList buildOverviewSection(
      {required BuildContext context, required TvDetails tv}) {
    return SliverList(
      delegate: SliverChildListDelegate([
        Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(tv.overview.toString(),
                maxLines: 5, overflow: TextOverflow.ellipsis)),
        // Other Row Widgets
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BlocBuilder<LibraryBloc, LibraryState>(
                builder: (context, state) {
                  bool isAdded =
                      state.tvs.indexWhere((detail) => detail.id == tv.id) !=
                          -1;
                  return OtherOptions(
                    iconData: Icon(
                      isAdded ? Icons.favorite : Icons.favorite_border,
                      color: Colors.pink,
                    ),
                    text: isAdded ? 'Remove' : 'My List',
                    onPressed: () {
                      if (isAdded) {
                        context.read<LibraryBloc>().add(RemoveTvFromLibrary(
                            state.tvs
                                .firstWhere((element) => element.id == tv.id)));
                        MySnackBar.showredSnackBar(context,
                            message: 'Removed from My List');
                      } else {
                        context
                            .read<LibraryBloc>()
                            .add(AddTvToLibrary(TvModel.fromTvDetails(tv)));
                        MySnackBar.showgreenSnackBar(context,
                            message: 'Added to My List');
                      }
                    },
                  );
                },
              ),
              OtherOptions(
                iconData: Icon(Icons.movie_outlined),
                text: 'Trailer',
                onPressed: () {},
              ),
              OtherOptions(
                iconData: Icon(Icons.report_sharp),
                text: 'Report',
                onPressed: () {},
              ),
              OtherOptions(
                iconData: Icon(Icons.share),
                text: 'Share',
                onPressed: () {},
              )
            ],
          ),
        ),
      ]),
    );
  }

  SliverAppBar buildSliverAppBar(
      {required BuildContext context, required TvDetails tv}) {
    return SliverAppBar(
        primary: true,
        forceMaterialTransparency: true,
        expandedHeight: context.height * 0.40,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.parallax,
            background: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(
                            tv.posterPath.toString()),
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
                                  imageUrl: tv.posterPath.toString(),
                                  height: context.height * 0.25),
                              SizedBox(height: 15),
                              Text(tv.name.toString(),
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
                                                    tv.firstAirDate ?? '2024')
                                                ?.year)
                                            .toString()),
                                    SizedBox(width: 15),
                                    DetailsChip(
                                        text: tv.adult == true ? '18+' : '13+'),
                                  ]),
                            ]))))));
  }
}

class SeasonSection extends StatefulWidget {
  final LoadedTvDetailState state;

  const SeasonSection({super.key, required this.state});

  @override
  State<SeasonSection> createState() => _SeasonSectionState();
}

class _SeasonSectionState extends State<SeasonSection> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      HeadingWidget(text: 'Seasons'),
      SizedBox(
        height: context.height * 0.3,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.state.tv.seasons!.length,
            itemBuilder: (context, index) {
              return SeasonCard(
                tvId: widget.state.tv.id!,
                season: widget.state.tv.seasons![index],
              );
            }),
      )
    ]);
  }
}
