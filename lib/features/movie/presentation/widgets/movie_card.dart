// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flixstar/features/history/presentation/bloc/history_bloc.dart';
import 'package:flixstar/features/history/presentation/bloc/history_event.dart';
import 'package:flixstar/features/history/presentation/bloc/history_state.dart';
import 'package:flixstar/features/library/presentation/bloc/library_bloc.dart';
import 'package:flixstar/features/library/presentation/bloc/library_event.dart';
import 'package:flixstar/features/library/presentation/bloc/library_state.dart';
import 'package:flixstar/features/movie/data/models/movie_model.dart';


import 'package:flixstar/core/utils/my_snack.dart';
import 'package:flixstar/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        DNavigator.toMovieDetails(movie);
      },
      onLongPress: () async {
        showModalBottomSheet(
            isDismissible: true,
            context: context,
            builder: (context) => BottomSheet(
                onClosing: () {},
                builder: (context) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('More Options',
                              style: Theme.of(context).textTheme.titleLarge),
                        ),
                        BlocBuilder<LibraryBloc, LibraryState>(
                          builder: (context, state) {
                            return ListTile(
                              leading: state.movies.contains(movie)
                                  ? Icon(Icons.favorite,
                                      color: Colors.pinkAccent)
                                  : Icon(
                                      Icons.favorite_border_outlined,
                                      color: Colors.pink,
                                    ),
                              title: Text(state.movies.contains(movie)
                                  ? 'Remove from My List'
                                  : 'Add to My List'),
                              onTap: () {
                                if (!state.movies.contains(movie)) {
                                  context
                                      .read<LibraryBloc>()
                                      .add(AddMovieToLibrary(movie));
                                  Navigator.pop(context);
                                  MySnackBar.showgreenSnackBar(context,
                                      message: 'Movie Added to My List');
                                } else {
                                  context
                                      .read<LibraryBloc>()
                                      .add(RemoveMovieFromLibrary(movie));
                                  Navigator.pop(context);
                                  MySnackBar.showgreenSnackBar(context,
                                      message: 'Movie Removed from My List');
                                }
                              },
                            );
                          },
                        ),
                        // SizedBox(height: 12),
                        BlocBuilder<HistoryBloc, HistoryState>(
                          builder: (context, state) {
                            if (state.movies.contains(movie)) {
                              return ListTile(
                                title: Text('Remove from History'),
                                leading: Icon(Icons.delete, color: Colors.red),
                                onTap: () {
                                  context
                                      .read<HistoryBloc>()
                                      .add(DeleteFromHistory(movie: movie));
                                },
                              );
                            } else {
                              return SizedBox();
                            }
                          },
                        ),
                      ],
                    )));
      },
      child: Stack(children: [
        Container(
          margin: EdgeInsets.all(10),
          height: 200,
          width: 140,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: CachedNetworkImageProvider(movie.posterPath.toString()),
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
                  '${(movie.title ?? movie.name.toString()).toUpperCase()} ',
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(color: Colors.white, fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  DateTime.tryParse(movie.releaseDate.toString()) != null
                      ? DateTime.tryParse(movie.releaseDate.toString())!
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
