part of 'search_bloc.dart';

sealed class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class InitialEvent extends SearchEvent{}

class InitiateSearchEvent extends SearchEvent {
  final String query;
  const InitiateSearchEvent(this.query);
}
