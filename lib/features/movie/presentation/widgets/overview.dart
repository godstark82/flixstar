import 'package:flixstar/features/movie/data/models/movie_model.dart';
import 'package:flutter/material.dart';

SliverToBoxAdapter buildOverview(Movie movie) {
  return SliverToBoxAdapter(
      child: Material(
    color: Colors.transparent,
    child: Container(
        padding: const EdgeInsets.all(12.0),
        child: Text(movie.overview.toString(),
            maxLines: 4, overflow: TextOverflow.ellipsis)),
  ));
}
