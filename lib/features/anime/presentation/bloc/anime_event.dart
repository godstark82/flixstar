part of 'anime_bloc.dart';

abstract class AnimeHomeEvent extends Equatable {
  const AnimeHomeEvent();

  @override
  List<Object> get props => [];
}

 class LoadAnimeHomeData extends AnimeHomeEvent{}
