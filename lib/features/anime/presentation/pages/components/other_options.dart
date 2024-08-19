 import 'package:flixstar/core/common/widgets/other_options.dart';
import 'package:flutter/material.dart';
import 'package:jikan_api/jikan_api.dart';

SliverToBoxAdapter buildAnimeOtherOptions(BuildContext context, Anime anime) {
    return SliverToBoxAdapter(
      child: SizedBox(
        // height: 500,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OtherOptions(
                  iconData: Icon(Icons.movie_outlined), text: 'Trailer'),
              OtherOptions(iconData: Icon(Icons.report_sharp), text: 'Report'),
              OtherOptions(iconData: Icon(Icons.share), text: 'Share')
            ],
          ),
        ),
      ),
    );
  }