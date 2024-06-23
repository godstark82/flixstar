// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dooflix/data/models/movie_model.dart';
import 'package:dooflix/features/anime/presentation/pages/anime_details.dart';
import 'package:dooflix/logic/blocs/history_bloc.dart/history_bloc.dart';
import 'package:dooflix/logic/blocs/history_bloc.dart/history_event.dart';
import 'package:dooflix/logic/blocs/history_bloc.dart/history_state.dart';
import 'package:dooflix/logic/blocs/library_bloc/library_bloc.dart';
import 'package:dooflix/logic/blocs/library_bloc/library_event.dart';
import 'package:dooflix/logic/blocs/library_bloc/library_state.dart';
import 'package:dooflix/logic/cubits/movie_details_cubit/movie_detail_cubit.dart';
import 'package:dooflix/logic/cubits/movie_details_cubit/movie_detail_event.dart';
import 'package:dooflix/logic/cubits/tv_details_cubit/tv_detail_event.dart';
import 'package:dooflix/presentation/pages/movie_page.dart';
import 'package:dooflix/presentation/widgets/my_snack.dart';
import 'package:dooflix/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:jikan_api/jikan_api.dart';

class AnimeCard extends StatelessWidget {
  final Anime anime;
  const AnimeCard({super.key, required this.anime});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        DNavigator.toAnimeDetails(anime);
      },
      child: Stack(children: [
        Container(
          margin: EdgeInsets.all(10),
          height: 200,
          width: 140,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: CachedNetworkImageProvider(anime.imageUrl.toString()),
            fit: BoxFit.fill,
          )),
        ),
        Container(
          margin: EdgeInsets.all(10),
          height: 200,
          width: 140,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black87.withOpacity(0.0),
                  Colors.black12.withOpacity(0.1),
                  Colors.black12.withOpacity(0.2),
                  Colors.black87.withOpacity(0.5),
                  Colors.black87.withOpacity(0.8),
                  Colors.black87.withOpacity(1)
                ]),
          ),
        ),
        Container(
          margin: EdgeInsets.all(10),
          height: 200,
          width: 140,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '${(anime.titleEnglish ?? anime.title).toUpperCase()} ',
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(color: Colors.white, fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  DateTime.tryParse(anime.aired.toString()) != null
                      ? DateTime.tryParse(anime.aired.toString())!
                          .year
                          .toString()
                      : '',
                  maxLines: 1,
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.orange),
                ),
                SizedBox(height: 10)
              ],
            ),
          ),
        )
      ]),
    );
  }
}
