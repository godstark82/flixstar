import 'package:cached_network_image/cached_network_image.dart';
import 'package:dooflix/features/history/presentation/bloc/history_bloc.dart';
import 'package:dooflix/features/history/presentation/bloc/history_state.dart';
// ignore: unused_import
import 'package:dooflix/features/movie/data/models/genre_movie_model.dart';
import 'package:dooflix/features/tv/data/models/genre_tv_model.dart';
import 'package:dooflix/features/tv/data/models/tv_model.dart';
import 'package:dooflix/features/home/presentation/bloc/home_bloc.dart';
import 'package:dooflix/features/tv/presentation/pages/tv_page.dart';
import 'package:dooflix/features/home/presentation/widgets/genre_tv_page.dart';
import 'package:dooflix/features/history/presentation/pages/history_page.dart';
import 'package:dooflix/common/carousel_widget.dart';
import 'package:dooflix/common/exit_dialoge.dart';
import 'package:dooflix/features/tv/presentation/widgets/tv_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/carousel/gf_carousel.dart';

class TvScreen extends StatelessWidget {
  const TvScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (v) async {
        await confirmExitDialoge(context);
      },
      child: Scaffold(
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoadedState || state is HomeAnimeLoadingState) {
              return CustomScrollView(
                slivers: [
                  sliverCarouselTvBar(context, tvs: state.topRatedTvs!),
                  SliverToBoxAdapter(
                      child: BlocBuilder<HistoryBloc, HistoryState>(
                    builder: (context, state) {
                      if (state.tvs.isNotEmpty) {
                        return TvsList(
                            tvs: state.tvs,
                            title: 'History',
                            showTitle: state.tvs.isNotEmpty,
                            showChevron: true,
                            onChevronPressed: () {
                              Get.to(() => HistoryPage());
                            });
                      }
                      return SizedBox();
                    },
                  )),
                  SliverList.builder(
                      itemCount: state.tvGenres!.length,
                      itemBuilder: (context, index) {
                        return GenreTvList(genre: state.tvGenres![index]);
                      }),
                ],
              );
            } else if (state is HomeLoadingState) {
              return Center(child: CircularProgressIndicator());
            }
            return Center(child: Text('Error'));
          },
        ),
      ),
    );
  }
}

class TvsList extends StatelessWidget {
  final List<TvModel> tvs;
  final String title;
  final bool showTitle;
  final bool showChevron;
  final VoidCallback? onChevronPressed;
  const TvsList({
    super.key,
    required this.tvs,
    this.onChevronPressed,
    required this.title,
    this.showTitle = true,
    this.showChevron = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        if (showTitle)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Container(
                  height: 20,
                  width: 5,
                  decoration: BoxDecoration(
                      color: Colors.amber.shade600,
                      borderRadius: BorderRadius.circular(15)),
                ),
                SizedBox(width: 5),
                Text(title, style: Theme.of(context).textTheme.titleLarge)
              ]),
              if (showChevron)
                IconButton(
                    onPressed: onChevronPressed,
                    icon: Icon(Icons.chevron_right))
            ],
          ),
        if (tvs.isNotEmpty)
          SizedBox(
            height: 225,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: tvs.length,
                itemBuilder: (context, index) {
                  return TvCard(tv: tvs[index]);
                }),
          ),
      ],
    );
  }
}

// auto fetch movie list from genre
class GenreTvList extends StatelessWidget {
  final GenreTvModel genre;
  const GenreTvList({super.key, required this.genre});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              Container(
                height: 20,
                width: 5,
                decoration: BoxDecoration(
                    color: Colors.amber.shade600,
                    borderRadius: BorderRadius.circular(15)),
              ),
              SizedBox(width: 5),
              Text(
                genre.name,
                style: Theme.of(context).textTheme.titleLarge,
              )
            ]),
            IconButton(
                onPressed: () => Get.to(() => GenreTvPage(genre: genre)),
                icon: Icon(Icons.chevron_right))
          ],
        ),
        SizedBox(
          height: 225,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: genre.movies?.length,
              itemBuilder: (context, index) {
                return TvCard(tv: genre.movies!.elementAt(index));
              }),
        ),
      ],
    );
  }
}

class TvCarousel extends StatelessWidget {
  final List<TvModel> tvs;
  const TvCarousel({super.key, required this.tvs});

  @override
  Widget build(BuildContext context) {
    return GFCarousel(
      autoPlay: true,
      activeIndicator: Colors.white,
      enlargeMainPage: true,
      height: context.height * 0.25,
      aspectRatio: 16 / 9,
      passiveIndicator: Colors.white,
      items: tvs
          .map((e) => InkWell(
                onTap: () {
                  Get.to(() => TvDetailsPage(tv: e));
                },
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(
                              e.backdropPath.toString()),
                          fit: BoxFit.contain)),
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                          Colors.transparent,
                          Colors.transparent,
                          Colors.black.withOpacity(0.1),
                          Colors.black.withOpacity(0.8),
                        ])),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        e.name.toString(),
                        style: Theme.of(context).textTheme.titleLarge,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                ),
              ))
          .toList(),
    );
  }
}
