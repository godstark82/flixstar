import 'package:cached_network_image/cached_network_image.dart';
import 'package:flixstar/features/search/presentation/pages/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/carousel/gf_carousel.dart';
import 'package:jikan_api/jikan_api.dart';

SliverLayoutBuilder customAnimeCarousel(BuildContext context,
    {required BuiltList<Anime> anime}) {
  return SliverLayoutBuilder(builder: (context, constraints) {
    final expandedHeight = context.height * 0.35;
    return SliverAppBar(
      primary: true,
      actions: [
        IconButton(
            onPressed: () {
              Get.to(() => SearchScreen());
            },
            icon: Icon(Icons.search))
      ],
      title: Text(
        'FlixStar',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, shadows: [
          Shadow(
            color: Colors.black,
            blurRadius: 16
            
          ),
        ]),
      ),
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
          items: anime
              .map(
                (anim) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(
                            anim.imageUrl.toString()),
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
                              Text(anim.titleEnglish ?? anim.title.toString(),
                                  style: Theme.of(context).textTheme.titleLarge,
                                  overflow: TextOverflow.fade),
                              SizedBox(height: 10),
                              Text(anim.broadcast.toString(),
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
              )
              .toList()),
    );
  });
}
