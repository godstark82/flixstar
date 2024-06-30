import 'package:equatable/equatable.dart';

abstract class MovieState extends Equatable {
  final String? sourceHtml;
  const MovieState({this.sourceHtml});
  @override
  List<Object> get props => [];
}

class MovieLoadingState extends MovieState {
  const MovieLoadingState() : super();
}

class MovieLoadedState extends MovieState {
  const MovieLoadedState({required super.sourceHtml});
}

class MovieErrorState extends MovieState {
  final String msg;

  const MovieErrorState(this.msg) : super();
}
