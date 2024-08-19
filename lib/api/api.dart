// ignore_for_file: unused_import

import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flixstar/core/const/constants.dart';
import 'package:flixstar/injection_container.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:html/parser.dart';

class API {
  final TMDB _tmdb = TMDB(
      ApiKeys(
        '215542e83456ec4a845de3e52c518405',
        'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyMTU1NDJlODM0NTZlYzRhODQ1ZGUzZTUyYzUxODQwNSIsInN1YiI6IjY2NDdhMWRiYWJlNzU2M2IxNTkyMTJlMiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.TKEx70NdqugVE2Uz5FhSr9zgZte6C4dnVfahY5kNu3Q',
      ),
      // interceptors: Interceptors()..add(PrettyDioLogger()),
      defaultLanguage: 'en-US');
  TMDB get tmdb => _tmdb;

  Future<String> getMovieSource(int id) async {
    String movieUrl = '$vidSrcBaseUrl/embed/movie/$id';
    log('Getting Movie Source from url $movieUrl');
    return movieUrl;
  }

  Future<String> getTvSource(int id) async {
    String tvUrl = '$vidSrcBaseUrl/embed/tv/$id';
    return tvUrl;
  }
}