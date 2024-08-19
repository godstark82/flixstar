import 'package:flixstar/core/common/widgets/heading_widget.dart';
import 'package:flixstar/features/tv/presentation/bloc/tv_bloc.dart';
import 'package:flixstar/features/tv/presentation/widgets/tv_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

SliverToBoxAdapter buildSimilarTvs(BuildContext context) {
  return SliverToBoxAdapter(
    child: BlocBuilder<TvBloc, TvState>(
      builder: (context, state) {
        if (state is TvLoadedState) {
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
                        return TvCard(tv: state.similar![index]);
                      }),
                ),
              ],
            ),
          );
        }
        return Center(child: LinearProgressIndicator(color: Colors.grey.withOpacity(0.1),));
      },
    ),
  );
}
