import 'package:flixstar/features/anime/presentation/widgets/anime_card.dart';
import 'package:flutter/material.dart';
import 'package:jikan_api/jikan_api.dart';

class AnimeList extends StatelessWidget {
  final BuiltList<Anime> movies;
  final String title;
  final bool showTitle;
  final bool showChevron;
  final VoidCallback? onChevronPressed;
  AnimeList({
    super.key,
    required this.movies,
    this.onChevronPressed,
    required this.title,
    this.showTitle = true,
    this.showChevron = false,
  }) : assert(movies.isNotEmpty);

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
        if (movies.isNotEmpty)
          SizedBox(
            height: 225,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  return AnimeCard(anime: movies[index]);
                }),
          ),
      ],
    );
  }
}
