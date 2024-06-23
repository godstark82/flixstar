abstract class MovieDetailEvent {
  const MovieDetailEvent();
}

class LoadMovieDetailsEvent extends MovieDetailEvent {
  int id;

  LoadMovieDetailsEvent(this.id);
}
