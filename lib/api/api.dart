// ignore_for_file: unused_import

import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flixstar/core/const/constants.dart';
import 'package:flixstar/injection_container.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:html/parser.dart';

class API {
  final TMDB _tmdb = TMDB(
      ApiKeys(dotenv.get('APIKEY'), dotenv.get('ACCESS_TOKEN')),
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
