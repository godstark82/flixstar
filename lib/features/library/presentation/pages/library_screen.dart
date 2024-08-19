
import 'package:flixstar/core/common/widgets/heading_widget.dart';
import 'package:flixstar/features/library/presentation/bloc/library_bloc.dart';
import 'package:flixstar/features/library/presentation/bloc/library_state.dart';
import 'package:flixstar/features/movie/presentation/widgets/movie_card.dart';
import 'package:flixstar/features/tv/presentation/widgets/tv_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Library'),
      ),
      body: BlocBuilder<LibraryBloc, LibraryState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10),
                HeadingWidget(text: 'Movies'),
                SizedBox(
                  height: 230,
                  child: state.movies.isEmpty
                      ? Center(
                          child: Text('No Movies added in library'),
                        )
                      : ListView.builder(
                        scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: state.movies.length,
                          itemBuilder: (context, index) =>
                              MovieCard(movie: state.movies[index])),
                ),
                SizedBox(height: 10),
                HeadingWidget(text: 'Series'),
                SizedBox(
                  height: 230,
                  child: state.tvs.isEmpty
                      ? Center(child: Text('No Series added in library'))
                      : ListView.builder(
                        scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: state.tvs.length,
                          itemBuilder: (context, index) =>
                              TvCard(tv: state.tvs[index])),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
