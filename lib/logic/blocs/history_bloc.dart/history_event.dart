import 'package:dooflix/data/models/movie_model.dart';
import 'package:dooflix/data/models/tv_model.dart';

abstract class HistoryEvent {
  const HistoryEvent();
}

class AddToHistoryEvent extends HistoryEvent {
  final Movie? movie;
  final TvModel? tv;
  const AddToHistoryEvent({this.movie, this.tv});
}

class LoadHistoryEvent extends HistoryEvent {}

class DeleteAllHistory extends HistoryEvent{}

class DeleteFromHistory extends HistoryEvent {
  final Movie? movie;
  final TvModel? tv;
  const DeleteFromHistory({this.movie, this.tv});
}
 