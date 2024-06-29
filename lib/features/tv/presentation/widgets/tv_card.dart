// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flixstar/core/routes/routes.dart';
import 'package:flixstar/features/library/presentation/bloc/library_bloc.dart';
import 'package:flixstar/features/library/presentation/bloc/library_event.dart';
import 'package:flixstar/features/library/presentation/bloc/library_state.dart';
import 'package:flixstar/features/tv/data/models/tv_model.dart';
import 'package:flixstar/core/utils/my_snack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvCard extends StatelessWidget {
  final TvModel tv;
  const TvCard({super.key, required this.tv});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        DNavigator.toTVDetails(tv);
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
                              leading: state.tvs.contains(tv)
                                  ? Icon(Icons.favorite,
                                      color: Colors.pinkAccent)
                                  : Icon(
                                      Icons.favorite_border_outlined,
                                      color: Colors.pink,
                                    ),
                              title: Text(state.tvs.contains(tv)
                                  ? 'Remove from My List'
                                  : 'Add to My List'),
                              onTap: () {
                                if (!state.tvs.contains(tv)) {
                                  context
                                      .read<LibraryBloc>()
                                      .add(AddTvToLibrary(tv));
                                  Navigator.pop(context);
                                  MySnackBar.showgreenSnackBar(context,
                                      message: 'Movie Added to My List');
                                } else {
                                  context
                                      .read<LibraryBloc>()
                                      .add(RemoveTvFromLibrary(tv));
                                  Navigator.pop(context);
                                  MySnackBar.showgreenSnackBar(context,
                                      message: 'Movie Removed from My List');
                                }
                              },
                            );
                          },
                        )
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
            image: CachedNetworkImageProvider(tv.posterPath.toString()),
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
                  '${(tv.name.toString()).toUpperCase()} ',
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(color: Colors.white, fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  DateTime.tryParse(tv.firstAirDate.toString()) != null
                      ? DateTime.tryParse(tv.firstAirDate.toString())!
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
