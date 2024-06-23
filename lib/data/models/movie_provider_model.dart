// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dooflix/api/api.dart';
import 'package:dooflix/core/utils/constants.dart';

// ignore_for_file: non_constant_identifier_names

class MovieProvider {
  final String provider_name;
  final int provider_id;
  final String logo_path;

  MovieProvider(
      {required this.logo_path,
      required this.provider_id,
      required this.provider_name});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'provider_name': provider_name,
      'provider_id': provider_id,
      'logo_path': logo_path,
    };
  }

  factory MovieProvider.fromMap(Map<String, dynamic> map) {
    API api = API();
    String img = api.tmdb.images.getUrl(map['logo_path']) ??
        Constants.backdroPlaceholder;
    return MovieProvider(
      provider_name: map['provider_name'] as String,
      provider_id: map['provider_id'] as int,
      logo_path: img,
    );
  }

  String toJson() => json.encode(toMap());

  factory MovieProvider.fromJson(String source) =>
      MovieProvider.fromMap(json.decode(source) as Map<String, dynamic>);
}
