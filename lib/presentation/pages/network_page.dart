import 'dart:developer';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dooflix/data/models/movie_model.dart';
import 'package:dooflix/data/models/network_model.dart';
import 'package:dooflix/data/repositories/movie_repo.dart';
import 'package:dooflix/logic/cubits/provider_cubit.dart/provider_cubit.dart';
import 'package:dooflix/logic/cubits/provider_cubit.dart/provider_state.dart';
import 'package:dooflix/main.dart';
import 'package:dooflix/presentation/pages/movie_page.dart';
import 'package:dooflix/presentation/widgets/movie_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:load_items/load_items.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class NetworkItemsPage extends StatelessWidget {
  final NetworkModel network;
  const NetworkItemsPage({super.key, required this.network});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(network.name),
      ),
      body: PopScope(
        canPop: true,
        onPopInvoked: (didPop) {
          context.read<ProviderCubit>().close();
        },
        child: BlocBuilder<ProviderCubit, ProviderState>(
          builder: (context, state) {
            if (state is LoadedProviderState) {
              return LoadItems<Movie>(
                  type: LoadItemsType.grid,
                  physics: BouncingScrollPhysics(),
                  gridCrossAxisCount: 3,
                  gridChildAspectRatio: 10/16,

                  bottomLoadingBuilder: () => Align(
                      alignment: Alignment.bottomCenter,
                      child: LinearProgressIndicator()),
                  itemBuilder: (context, item, i) {
                    return MovieCard(movie: item);
                  },
                  itemsLoader: (currentItems) {
                    int page = currentItems.length ~/ 20 + 1;
                    MovieRepository repo = MovieRepository();
                    final newData =
                        repo.getNetworkMovies(network.name, page: page);
                    return newData;
                  });
            } else if (state is ErrorProviderState) {
              return Center(child: Text(state.message));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  // ignore: unused_element
  SliverAppBar _buildAppBar(BuildContext context, NetworkModel network) {
    return SliverAppBar(
        primary: true,
        forceMaterialTransparency: true,
        expandedHeight: context.height * 0.40,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.parallax,
            background: Container(
                // padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(
                            network.logoPath.toString()),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.srgbToLinearGamma())),
                child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                    child: Container(
                        decoration: BoxDecoration(
                            // color: Colors.black.withOpacity(0.2),
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                              Colors.black.withOpacity(0.2),
                              Colors.transparent.withOpacity(0.2),
                              Colors.black.withOpacity(0.9),
                            ])),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CachedNetworkImage(
                                  imageUrl: network.logoPath.toString(),
                                  height: context.height * 0.25),
                              SizedBox(height: 15),
                              Text(network.name.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(color: Colors.white)),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    DetailsChip(
                                        text: network.id
                                            .toString()
                                            .toUpperCase()),
                                  ]),
                            ]))))));
  }
}
