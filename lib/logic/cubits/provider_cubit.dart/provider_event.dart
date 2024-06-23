import 'package:dooflix/data/models/network_model.dart';

abstract class ProviderEvent {

}

class LoadProviderMovies extends ProviderEvent {
  NetworkModel network;
  LoadProviderMovies(this.network);
}

