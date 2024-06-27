// ignore_for_file: unused_import

import 'package:dio/dio.dart';
import 'package:dooflix/core/utils/constants.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:html/parser.dart';

class API {
  final Dio _dio = Dio();
  final TMDB _tmdb = TMDB(
      ApiKeys(
        '215542e83456ec4a845de3e52c518405',
        'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyMTU1NDJlODM0NTZlYzRhODQ1ZGUzZTUyYzUxODQwNSIsInN1YiI6IjY2NDdhMWRiYWJlNzU2M2IxNTkyMTJlMiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.TKEx70NdqugVE2Uz5FhSr9zgZte6C4dnVfahY5kNu3Q',
      ),
      // interceptors: Interceptors()..add(PrettyDioLogger()),
      defaultLanguage: 'en-US');
  TMDB get tmdb => _tmdb;

  API();

  Future<String> getMovieSource(int id) async {
    String movieUrl = '$vidSrcBaseUrl/embed/movie/$id';
    final response = await _dio.get(movieUrl);
    final html = parse(response.data);
    return html.outerHtml;
  }

  Future<String> getTvSource(int id) async {
    String tvUrl = '$vidSrcBaseUrl/embed/tv/$id';
    final response = await _dio.get(tvUrl);
    final html = parse(response.data);
    return html.outerHtml;
  }
}
