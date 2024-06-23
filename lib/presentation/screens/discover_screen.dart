import 'package:dooflix/data/models/network_model.dart';
import 'package:dooflix/logic/blocs/search_bloc/search_bloc.dart';
import 'package:dooflix/logic/cubits/movie_home_cubit/movie_home_cubit.dart';
import 'package:dooflix/presentation/pages/genre_movies_page.dart';
import 'package:dooflix/presentation/pages/genre_tv_page.dart';
import 'package:dooflix/presentation/pages/search_result_page.dart';
import 'package:dooflix/presentation/screens/home_screen.dart';
import 'package:dooflix/presentation/screens/search/search_screen.dart';
import 'package:dooflix/presentation/widgets/heading_widget.dart';
import 'package:dooflix/presentation/widgets/my_snack.dart';
import 'package:dooflix/presentation/widgets/network_card.dart';
import 'package:dooflix/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    tabController?.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: TabBar(controller: tabController, tabs: [
            Tab(text: 'Movies', icon: Icon(Icons.movie)),
            Tab(text: 'Series', icon: Icon(Icons.tv)),
          ]),
          body: TabBarView(controller: tabController, children: [
            CustomScrollView(
              slivers: [
                _buildAppBar(context, searchController.text),
                _buildGenresList(context),
                _buildNetworkList(context),
              ],
            ),
            CustomScrollView(
              slivers: [
                _buildAppBar(context, searchController.text),
                _buildNetworkList(context),
                _buildGenresList(context),
              ],
            )
          ])),
    );
  }

  SliverToBoxAdapter _buildGenresList(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<MovieCubit, MovieState>(
        builder: (context, state) {
          if (state is MovieLoadedState) {
            return Column(
              children: [
                HeadingWidget(text: 'Genres'),
                ResponsiveGridList(
                  listViewBuilderOptions: ListViewBuilderOptions(
                    shrinkWrap: true,
                  ),
                  minItemWidth: 90,
                  horizontalGridMargin: 5,
                  horizontalGridSpacing: 5,
                  verticalGridMargin: 0,
                  verticalGridSpacing: 5,
                  children: state.tvGenres
                      .map((genre) => RawChip(
                            backgroundColor: Colors.grey.shade900,
                            labelStyle: TextStyle(color: Colors.white),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                              side: BorderSide(color: Colors.grey.shade800),
                            ),
                            // labelPadding: EdgeInsets.symmetric(
                            // horizontal: 5, vertical: 5),
                            label: Text(genre.name),
                            onPressed: () {
                              Get.to(() => GenreTvPage(genre: genre));
                            },
                          ))
                      .toList(),
                ),
              ],
            );
          }
          return SizedBox();
        },
      ),
    );
  }

  SliverToBoxAdapter _buildNetworkList(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          SizedBox(height: 10),
          HeadingWidget(text: 'Providers'),
          SizedBox(height: 10),
          ResponsiveGridList(
              listViewBuilderOptions: ListViewBuilderOptions(shrinkWrap: true),
              minItemWidth: 150,
              horizontalGridSpacing: 0,
              horizontalGridMargin: 0,
              children: allNetworks
                  .map((network) => NetworkCard(network: network))
                  .toList()),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  SliverToBoxAdapter _buildAppBar(BuildContext context, String? query) {
    return SliverToBoxAdapter(
        child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: InkWell(
        onTap: (){
          Get.to(()=> SearchScreen());
        },
        child: IgnorePointer(
          child: TextFormField(
            onChanged: (v) {
              query = v;
            },
            onFieldSubmitted: (v) {
              _initiateSearch(context, v);
              searchController.clear();
            },
            decoration: InputDecoration(
                suffix: IconButton(
                    padding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    onPressed: () {
                      _initiateSearch(context, query);
                      searchController.clear();
                    },
                    icon: Icon(
                      Icons.search,
                      size: 20,
                      opticalSize: 0.5,
                    )),
                enabled: true,
                border: OutlineInputBorder(),
                fillColor: Colors.white,
                labelText: 'Search'),
          ),
        ),
      ),
    ));
  }

  void _initiateSearch(BuildContext context, String? query) {
    if (query != null && query.isNotEmpty) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BlocProvider(
                    create: (context) => SearchBloc(),
                    child: SearchResultPage(query: query),
                  )));
    } else {
      MySnackBar.showSnackBar(context, message: 'Please Enter a Query');
    }
  }
}
