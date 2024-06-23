import 'package:dooflix/logic/blocs/history_bloc.dart/history_bloc.dart';
import 'package:dooflix/logic/blocs/history_bloc.dart/history_event.dart';
import 'package:dooflix/logic/blocs/history_bloc.dart/history_state.dart';
import 'package:dooflix/presentation/widgets/movie_card.dart';
import 'package:dooflix/presentation/widgets/tv_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    tabController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('History'),
          actions: [
            IconButton(
              onPressed: () {
                context.read<HistoryBloc>().add(DeleteAllHistory());
              },
              icon: Icon(Icons.delete),
              tooltip: 'Delete History',
            )
          ],
          bottom: TabBar(
              tabs: [Tab(text: 'Movies'), Tab(text: 'TVs')],
              controller: tabController),
        ),
        body: BlocBuilder<HistoryBloc, HistoryState>(builder: (context, state) {
          return TabBarView(controller: tabController, children: [
            ResponsiveGridList(
              minItemWidth: 120,
              minItemsPerRow: 3,
              
              children: state.movies.map((m) => MovieCard(movie: m)).toList(),
            ),
            ResponsiveGridList(
              minItemWidth: 120,
              minItemsPerRow: 3,
              children: state.tvs.map((m) => TvCard(tv: m)).toList(),
            )
          ]);
        }));
  }
}
