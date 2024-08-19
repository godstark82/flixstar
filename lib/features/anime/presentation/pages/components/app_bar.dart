import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flixstar/core/common/widgets/details_chip.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jikan_api/jikan_api.dart';

SliverAppBar buildAnimeAppBar(BuildContext context, Anime anime) {
    return SliverAppBar(
      primary: true,

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
                  image: CachedNetworkImageProvider(anime.imageUrl.toString()),
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
                        imageUrl: anime.imageUrl.toString(),
                        height: context.height * 0.25),
                    SizedBox(height: 15),
                    Text(anime.titleEnglish ?? anime.title.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(color: Colors.white)),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      DetailsChip(text: anime.aired.toString().toUpperCase()),
                      SizedBox(width: 15),
                      DetailsChip(
                          text:
                              (DateTime.tryParse(anime.aired.toString())?.year)
                                  .toString()),
                      SizedBox(width: 15),
                      DetailsChip(
                          text: anime.airing == true ? 'Airing' : 'Not Airing'),
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