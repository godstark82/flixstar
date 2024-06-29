part of 'tv_bloc.dart';

abstract class TvState extends Equatable {
  final String? html;
  final StartAppBannerAd? bannerAd;

  const TvState({this.html, this.bannerAd});

  @override
  List<Object?> get props => [html];
}

class TvLoadingState extends TvState {
  const TvLoadingState() : super();
}

class TvLoadedState extends TvState {
  const TvLoadedState({required super.html, super.bannerAd});
}

class TvErrorState extends TvState {
  const TvErrorState();
}
