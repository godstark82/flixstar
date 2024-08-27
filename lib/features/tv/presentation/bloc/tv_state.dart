part of 'tv_bloc.dart';

abstract class TvState extends Equatable {
  final List<TvModel>? similar;

  const TvState({this.similar});

  @override
  List<Object?> get props => [ similar];
}

class TvLoadingState extends TvState {
  const TvLoadingState() : super();
}

class TvLoadedState extends TvState {
  const TvLoadedState({required super.similar});
}

class TvErrorState extends TvState {
  const TvErrorState();
}
