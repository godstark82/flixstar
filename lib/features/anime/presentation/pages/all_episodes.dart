import 'package:dooflix/features/anime/data/models/source_model.dart';
import 'package:dooflix/features/anime/presentation/widgets/anime_episode_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jikan_api/jikan_api.dart';

class AllEpisodes extends StatefulWidget {
  final Anime anime;
  final List<AnimeSource> animeSourceList;

  const AllEpisodes(
      {super.key, required this.anime, required this.animeSourceList});

  @override
  State<AllEpisodes> createState() => _AllEpisodesState();
}

class _AllEpisodesState extends State<AllEpisodes> {
  List<AnimeSource> animeSources = [];

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    animeSources = widget.animeSourceList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              Text('${widget.anime.title} Episodes (${widget.anime.episodes})'),
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                child: TextFormField(
                  decoration: InputDecoration(
                      label: Text('Search'),
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        splashRadius: 0.1,
                        icon: Icon(Icons.cancel_outlined),
                        onPressed: () {
                          animeSources = widget.animeSourceList;
                          setState(() {});
                        },
                      )),
                  onChanged: (value) {
                    animeSources = animeSources
                        .where((source) => source.episodeId!.contains(value))
                        .toList();
                    if (value == '') {
                      animeSources = widget.animeSourceList;
                    }
                    setState(() {});
                  },
                ),
              )),
        ),
        body: ListView.builder(
            itemCount: animeSources.length,
            itemBuilder: (context, index) {
              return AnimeEpisodeCard(
                  anime: widget.anime,
                  source: animeSources[index],
                  index: index);
            }));
  }
}
