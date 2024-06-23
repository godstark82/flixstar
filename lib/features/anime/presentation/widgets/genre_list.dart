// auto fetch movie list from genre
import 'package:dooflix/features/anime/data/models/anime_genre_model.dart';
import 'package:dooflix/features/anime/presentation/widgets/anime_card.dart';
import 'package:dooflix/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';

class GenreAnimeList extends StatelessWidget {
  final AnimeGenreModel genre;
  const GenreAnimeList({super.key, required this.genre});

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
                genre.title,
                style: Theme.of(context).textTheme.titleLarge,
              )
            ]),
            IconButton(
                onPressed: () {},
                // onPressed: () => Get.to(() => GenreMovieList(genre: genre)),
                icon: Icon(Icons.chevron_right))
          ],
        ),
        SizedBox(
          height: 225,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: genre.animes.length,
              itemBuilder: (context, index) {
                return AnimeCard(anime: genre.animes.elementAt(index));
              }),
        ),
      ],
    );
  }
}
