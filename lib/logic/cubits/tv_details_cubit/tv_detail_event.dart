import 'package:dooflix/data/models/tv_details_model.dart';
import 'package:get/get_connect/http/src/request/request.dart';

abstract class TvDetailEvent {
  const TvDetailEvent();
}

class LoadTvDetailEvent extends TvDetailEvent {
  final int id;

  const LoadTvDetailEvent(this.id);
}
