import 'package:dooflix/api/api.dart';
import 'package:dooflix/data/models/tv_details_model.dart';
import 'package:dooflix/data/models/tv_model.dart';
import 'package:dooflix/data/repositories/tv_repo.dart';
import 'package:dooflix/logic/cubits/tv_details_cubit/tv_detail_event.dart';
import 'package:dooflix/logic/cubits/tv_details_cubit/tv_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvDetailCubit extends Bloc<TvDetailEvent, TvDetailState> {
  TvDetailCubit() : super(LoadingTvDetailState()) {
    on<LoadTvDetailEvent>(fetchTvDetail);
  }

  void fetchTvDetail(
      LoadTvDetailEvent event, Emitter<TvDetailState> emit) async {
    try {
      API api = API();
      emit(LoadingTvDetailState(
          msg: 'Please wait while we fetch Details of TV Series for you'));
      Map response = await api.tmdb.v3.tv.getDetails(event.id).whenComplete(() {
        emit(LoadingTvDetailState(msg: 'Converting Data'));
      });
      Map<String, dynamic> tvResult = Map<String, dynamic>.from(response);

      TvDetails tvSeries = TvDetails.fromJson(tvResult);

      emit(LoadingTvDetailState(msg: 'Done'));
      emit(LoadedTvDetailState(tvSeries));
    } catch (e) {
      emit(ErrorTvDetailState(e.toString()));
      rethrow;
    }
  }
}
