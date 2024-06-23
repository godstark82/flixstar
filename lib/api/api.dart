// ignore_for_file: unused_import

import 'package:dio/dio.dart';
import 'package:tmdb_api/tmdb_api.dart';

class API {
  final Dio _dio = Dio();
  final TMDB _tmdb = TMDB(
    ApiKeys(
      '215542e83456ec4a845de3e52c518405',
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyMTU1NDJlODM0NTZlYzRhODQ1ZGUzZTUyYzUxODQwNSIsInN1YiI6IjY2NDdhMWRiYWJlNzU2M2IxNTkyMTJlMiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.TKEx70NdqugVE2Uz5FhSr9zgZte6C4dnVfahY5kNu3Q',
    ),
    // interceptors: Interceptors()..add(PrettyDioLogger()),
    defaultLanguage: 'en-US'
  );
  TMDB get tmdb => _tmdb;


  API(){
    _dio.options.baseUrl='';
  }
}
