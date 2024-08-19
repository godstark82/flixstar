import 'package:flixstar/core/common/widgets/heading_widget.dart';
import 'package:flixstar/features/movie/presentation/bloc/movie_bloc.dart';
import 'package:flixstar/features/movie/presentation/bloc/movie_state.dart';
import 'package:flixstar/features/movie/presentation/widgets/movie_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

SliverToBoxAdapter buildSimilarMovies(BuildContext context) {
  return SliverToBoxAdapter(
    child: BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        if (state is MovieLoadedState) {
          return Material(
            color: Colors.transparent,
            child: Column(
              children: [
                HeadingWidget(text: 'Similar Content'),
                SizedBox(
                  height: 225,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: state.similar?.length,
                      itemBuilder: (context, index) {
                        return MovieCard(movie: state.similar![index]);
                      }),
                ),
              ],
            ),
          );
        }
        return Center(
            child: LinearProgressIndicator(
          color: Colors.grey.withOpacity(0.1),
        ));
      },
    ),
  );
}
