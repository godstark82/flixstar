import 'package:flixstar/features/anime/presentation/widgets/anime_card.dart';
import 'package:flixstar/features/movie/presentation/widgets/movie_card.dart';
import 'package:flixstar/features/search/presentation/bloc/search_bloc.dart';
import 'package:flixstar/features/tv/presentation/widgets/tv_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class SearchResultPage extends StatefulWidget {
  final String query;
  const SearchResultPage({super.key, required this.query});

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    context.read<SearchBloc>().add(InitiateSearchEvent(widget.query));
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Results from ${widget.query}'),
          bottom: TabBar(controller: tabController, tabs: const [
            Padding(padding: EdgeInsets.all(8.0), child: Text('Movies')),
            Padding(padding: EdgeInsets.all(8.0), child: Text('Series')),
            Padding(padding: EdgeInsets.all(8.0), child: Text('Anime')),
          ])),
      body: TabBarView(controller: tabController, children: [
        //! Bloc for movies
        //!
        //!
        BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            if (state is LoadingSearchState) {
              print(state.runtimeType);
              return Center(child: CircularProgressIndicator());
            }
            if (state is LoadedSearchState) {
              print(state.runtimeType);
              return CustomScrollView(slivers: [
                SliverToBoxAdapter(child: SizedBox(height: 12)),
                SliverToBoxAdapter(
                  child: Row(
                    children: [
                      SizedBox(width: 12),
                      Container(
                        height: 25,
                        width: 5,
                        decoration: BoxDecoration(
                            color: Colors.amber.shade600,
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Movie Results',
                        style: Theme.of(context).textTheme.titleLarge,
                      )
                    ],
                  ),
                ),
                ResponsiveSliverGridList(
                    minItemWidth: 120,
                    minItemsPerRow: 3,
                    horizontalGridMargin: 0,
                    horizontalGridSpacing: 0,
                    verticalGridMargin: 0,
                    verticalGridSpacing: 0,
                    children: state.fetchedMovies
                        .map((e) => MovieCard(movie: e))
                        .toList()),
              ]);
            }
            if (state is ErrorSearchState) {
              return Center(child: Text('Error'));
            }

            return Center(
              child: Text('Search results will appear here'),
            );
          },
        ),

        //?
        //!
        //*
        //! Bloc for series
        BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            if (state is LoadingSearchState) {
              print(state.runtimeType);
              return Center(child: CircularProgressIndicator());
            }
            if (state is LoadedSearchState) {
              print(state.runtimeType);
              return CustomScrollView(slivers: [
                SliverToBoxAdapter(child: SizedBox(height: 12)),
                SliverToBoxAdapter(
                  child: Row(
                    children: [
                      SizedBox(width: 12),
                      Container(
                        height: 25,
                        width: 5,
                        decoration: BoxDecoration(
                            color: Colors.amber.shade600,
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      SizedBox(width: 5),
                      Text(
                        ' Tv Results',
                        style: Theme.of(context).textTheme.titleLarge,
                      )
                    ],
                  ),
                ),
                ResponsiveSliverGridList(
                     minItemWidth: 120,
                    minItemsPerRow: 3,
                    horizontalGridMargin: 0,
                    horizontalGridSpacing: 0,
                    verticalGridMargin: 0,
                    verticalGridSpacing: 0,
                    children:
                        state.fetchedTv.map((e) => TvCard(tv: e)).toList()),
              ]);
            }
            if (state is ErrorSearchState) {
              return Center(child: Text('Error'));
            }

            return Center(
              child: Text('Search results will appear here'),
            );
          },
        ),
        //! Bloc for movies
        //!
        //!
        BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            if (state is LoadingSearchState) {
              print(state.runtimeType);
              return Center(child: CircularProgressIndicator());
            }
            if (state is LoadedSearchState) {
              print(state.runtimeType);
              return CustomScrollView(slivers: [
                SliverToBoxAdapter(child: SizedBox(height: 12)),
                SliverToBoxAdapter(
                  child: Row(
                    children: [
                      SizedBox(width: 12),
                      Container(
                        height: 25,
                        width: 5,
                        decoration: BoxDecoration(
                            color: Colors.amber.shade600,
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Anime Results',
                        style: Theme.of(context).textTheme.titleLarge,
                      )
                    ],
                  ),
                ),
                ResponsiveSliverGridList(
                    minItemWidth: 120,
                    minItemsPerRow: 3,
                    horizontalGridMargin: 0,
                    horizontalGridSpacing: 0,
                    verticalGridMargin: 0,
                    verticalGridSpacing: 0,
                    children: state.fetchedAnimes
                        .map((e) => AnimeCard(anime: e))
                        .toList()),
              ]);
            }
            if (state is ErrorSearchState) {
              return Center(child: Text('Error'));
            }

            return Center(
              child: Text('Search results will appear here'),
            );
          },
        ),
      ]),
    );
  }
}
