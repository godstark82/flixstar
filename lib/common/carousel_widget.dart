import 'package:cached_network_image/cached_network_image.dart';
import 'package:dooflix/core/routes/routes.dart';
import 'package:dooflix/features/movie/data/models/movie_model.dart';
import 'package:dooflix/features/search/presentation/bloc/search_bloc.dart';
import 'package:dooflix/features/tv/data/models/tv_model.dart';

import 'package:dooflix/features/search/presentation/pages/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/carousel/gf_carousel.dart';

SliverLayoutBuilder sliverCarouselMovieBar(BuildContext context,
    {required List<Movie> movies}) {
  return SliverLayoutBuilder(builder: (context, constraints) {
    final expandedHeight = context.height * 0.35;
    return SliverAppBar(
      primary: true,
      leadingWidth: 20,
    
      actions: [
        IconButton(
            onPressed: () {
              Get.to(() => SearchScreen());
            },
            icon: Icon(Icons.search))
      ],
      title: Text('FlixVibes',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              shadows: [Shadow(color: Colors.black, blurRadius: 16)])),
      forceMaterialTransparency: true,
      expandedHeight: expandedHeight,
      flexibleSpace: GFCarousel(
          aspectRatio: 16 / 9,
          height: context.height * 0.4,
          viewportFraction: 1.0,
          autoPlay: true,
          activeIndicator: Colors.blue,
          passiveIndicator: Colors.grey,
          hasPagination: true,
          items: movies
              .map(
                (movie) => InkWell(
                  onTap: () {
                    DNavigator.toMovieDetails(movie);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(
                              movie.backdropPath.toString()),
                          fit: BoxFit.cover),
                    ),
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                Colors.transparent.withOpacity(0.01),
                                Colors.transparent.withOpacity(0.1),
                                Colors.transparent.withOpacity(0.2),
                                Colors.black.withOpacity(0.4),
                                Colors.black.withOpacity(0.6),
                                Colors.black.withOpacity(0.9)
                              ])),
                        ),
                        SizedBox(
                          height: context.height * 0.35,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.info,
                                  size: 34,
                                ),
                                SizedBox(height: 10),
                                Text(movie.title ?? movie.name.toString(),
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                    overflow: TextOverflow.fade),
                                SizedBox(height: 10),
                                Text(movie.overview.toString(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(color: Colors.grey))
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
              .toList()),
    );
  });
}

SliverLayoutBuilder sliverCarouselTvBar(BuildContext context,
    {required List<TvModel> tvs}) {
  return SliverLayoutBuilder(builder: (context, constraints) {
    final expandedHeight = context.height * 0.35;
    return SliverAppBar(
      primary: true,
      leadingWidth: 20,
     
      actions: [
        IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BlocProvider(
                            create: (context) => SearchBloc(),
                            child: SearchScreen(),
                          )));
            },
            icon: Icon(Icons.search))
      ],
      title: Text('FlixVibes',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              shadows: [Shadow(color: Colors.black, blurRadius: 16)])),
      forceMaterialTransparency: true,
      expandedHeight: expandedHeight,
      flexibleSpace: GFCarousel(
          aspectRatio: 16 / 9,
          height: context.height * 0.4,
          viewportFraction: 1.0,
          autoPlay: true,
          activeIndicator: Colors.blue,
          passiveIndicator: Colors.grey,
          hasPagination: true,
          items: tvs
              .map(
                (movie) => InkWell(
                  onTap: () {
                    DNavigator.toTVDetails(movie);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(
                              movie.backdropPath.toString()),
                          fit: BoxFit.cover),
                    ),
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                Colors.transparent.withOpacity(0.01),
                                Colors.transparent.withOpacity(0.1),
                                Colors.transparent.withOpacity(0.2),
                                Colors.black.withOpacity(0.4),
                                Colors.black.withOpacity(0.6),
                                Colors.black.withOpacity(0.9)
                              ])),
                        ),
                        SizedBox(
                          height: context.height * 0.35,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.info,
                                  size: 34,
                                ),
                                SizedBox(height: 10),
                                Text(movie.name ?? movie.name.toString(),
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                    overflow: TextOverflow.fade),
                                SizedBox(height: 10),
                                Text(movie.overview.toString(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(color: Colors.grey))
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
              .toList()),
    );
  });
}
