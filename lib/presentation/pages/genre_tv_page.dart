import 'package:dooflix/data/models/genre_model.dart';
import 'package:dooflix/data/models/tv_model.dart';
import 'package:dooflix/data/repositories/tv_repo.dart';
import 'package:dooflix/presentation/widgets/tv_card.dart';
import 'package:flutter/material.dart';
import 'package:load_items/load_items.dart';

class GenreTvPage extends StatelessWidget {
  final GenreTvModel genre;
  const GenreTvPage({super.key, required this.genre});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${genre.name} Movies')),
      body: LoadItems<TvModel>(
        type: LoadItemsType.grid,
        itemsLoader: (List<TvModel> currentItems) async {
          int page = currentItems.length ~/ 20 + 1;
          TvRepository repo = TvRepository();
          final newData = await repo.getGenreSeries(genre.id, page: page);
          return newData;
        },
        itemWidth: 150,
        bottomLoadingBuilder: () => Align(
            alignment: Alignment.bottomCenter,
            child: LinearProgressIndicator()),
        gridCrossAxisCount: 3,
        itemBuilder: (context, item, i) {
          return TvCard(tv: item);
        },
      ),
    );
  }
}
