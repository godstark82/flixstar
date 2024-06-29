import 'package:equatable/equatable.dart';
import 'package:startapp_sdk/startapp.dart';

abstract class MovieState extends Equatable {
  final String? sourceHtml;
  final StartAppBannerAd? bannerAd;
  const MovieState({this.sourceHtml, this.bannerAd});

  @override
  List<Object> get props => [];
}

class MovieLoadingState extends MovieState {
  const MovieLoadingState() : super();
}

class MovieLoadedState extends MovieState {
  const MovieLoadedState(
      {required super.sourceHtml, super.bannerAd});
}

class MovieErrorState extends MovieState {
  final String msg;

  const MovieErrorState(this.msg) : super();
}
