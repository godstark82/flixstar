part of 'tv_bloc.dart';

abstract class TvState extends Equatable {
  final String? html;
  final List<TvModel>? similar;

  const TvState({this.html, this.similar});

  @override
  List<Object?> get props => [html, similar];
}

class TvLoadingState extends TvState {
  const TvLoadingState() : super();
}

class TvLoadedState extends TvState {
  const TvLoadedState({required super.html, required super.similar});
}

class TvErrorState extends TvState {
  const TvErrorState();
}
