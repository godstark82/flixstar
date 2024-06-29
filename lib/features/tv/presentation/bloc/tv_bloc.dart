import 'package:bloc/bloc.dart';
import 'package:flixstar/features/tv/data/models/tv_model.dart';
import 'package:flixstar/features/tv/domain/usecases/tv_detail_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flixstar/injection_container.dart';
import 'package:startapp_sdk/startapp.dart';

part 'tv_event.dart';
part 'tv_state.dart';

class TvBloc extends Bloc<TvEvent, TvState> {
  final GetTvDetailsUseCase getTvDetailsUseCase;
  TvBloc(this.getTvDetailsUseCase) : super(TvLoadingState()) {
    on<LoadTvEvent>(
      (event, emit) async {
        emit(TvLoadingState());
        try {
          StartAppBannerAd? bannerAd;

          final startAppSdk = sl<StartAppSdk>();
          final html = (await getTvDetailsUseCase.call(event.tv)).data!;

          try {
            bannerAd = await startAppSdk.loadBannerAd(
              StartAppBannerType.BANNER,
            );
          } catch (e) {
            //
          }
          emit(TvLoadedState(html: html.source!, bannerAd: bannerAd));
        } catch (e) {
          emit(TvErrorState());
        }
      },
    );
  }
}
