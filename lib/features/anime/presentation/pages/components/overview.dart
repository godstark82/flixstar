 import 'package:flutter/material.dart';
import 'package:jikan_api/jikan_api.dart';

SliverToBoxAdapter buildAnimeOverview(Anime anime) {
    return SliverToBoxAdapter(
      child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(anime.titleEnglish.toString(),
              maxLines: 4, overflow: TextOverflow.ellipsis)),
    );
  }