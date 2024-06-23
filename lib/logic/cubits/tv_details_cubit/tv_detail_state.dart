import 'package:dooflix/data/models/tv_details_model.dart';
import 'package:dooflix/data/models/tv_model.dart';
import 'package:equatable/equatable.dart';

abstract class TvDetailState extends Equatable {
  const TvDetailState();
  @override
  List<Object?> get props => [];
}

class LoadingTvDetailState extends TvDetailState {
  final String msg;

  const LoadingTvDetailState({this.msg = 'Loading...'});
}

class LoadedTvDetailState extends TvDetailState {
  final TvDetails tv;
  const LoadedTvDetailState(this.tv);
}

class ErrorTvDetailState extends TvDetailState {
  final String message;
  const ErrorTvDetailState(this.message);
}
