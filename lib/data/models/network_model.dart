import 'package:dooflix/api/api.dart';
import 'package:dooflix/core/utils/constants.dart';

class NetworkModel {
  final int id;
  final String name;
  final String logoPath;

  NetworkModel({required this.id, required this.name, required this.logoPath});

  factory NetworkModel.fromJson(Map<String, dynamic> json) {
    return NetworkModel(
      id: json['id'],
      name: json['name'],
      logoPath: API().tmdb.images.getUrl(json['logo_path']) ??
          Constants.backdroPlaceholder,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['logo_path'] = logoPath;
    return data;
  }
}

List<NetworkModel> allNetworks = [
  NetworkModel(
      id: 213,
      name: 'Netflix',
      logoPath: API().tmdb.images.getUrl('/wwemzKWzjKYJFfCeiB57q3r4Bcm.png') ??
          Constants.backdroPlaceholder),
  NetworkModel(
      id: 1024,
      name: 'Amazon Prime',
      logoPath: API().tmdb.images.getUrl('/ifhbNuuVnlwYy5oXA5VIb2YR8AZ.png') ??
          Constants.backdroPlaceholder),
  NetworkModel(
      id: 1024,
      name: 'Disney+ Hotstar',
      logoPath: API().tmdb.images.getUrl('/eBa3TplonEHlR6S2wjJ616KnwIh.png') ??
          Constants.backdroPlaceholder),
];
