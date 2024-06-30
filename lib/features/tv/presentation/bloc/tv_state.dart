part of 'tv_bloc.dart';

abstract class TvState extends Equatable {
  final String? html;

  const TvState({this.html});

  @override
  List<Object?> get props => [html];
}

class TvLoadingState extends TvState {
  const TvLoadingState() : super();
}

class TvLoadedState extends TvState {
  const TvLoadedState({required super.html});
}

class TvErrorState extends TvState {
  const TvErrorState();
}
