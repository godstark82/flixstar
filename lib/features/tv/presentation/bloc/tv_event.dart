part of 'tv_bloc.dart';

abstract class TvEvent extends Equatable {
  const TvEvent();

  @override
  List<Object> get props => [];
}

class LoadTvEvent extends TvEvent {
  final TvModel tv;

  const LoadTvEvent({required this.tv});
}
