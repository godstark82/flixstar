import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:dooflix/data/models/source_model.dart';

class PlayerApi {
  final String baseUrl = 'https://vidsrc-drab.vercel.app';

  Future<MediaSource?> videoUrl(int id, {int? episode, int? season}) async {
    Response<Map<String, dynamic>> response;
    Dio dio = Dio();
    try {
    if (episode != null && season != null) {
      final url = '$baseUrl/$id?s=$season&e=$episode';
      log(url);
      response = await dio.get(url);
    } else {
      final url = '$baseUrl/$id';
      log(url);
      response = await dio.get(url);
    }
    // log(response.data.toString());
    Map<String, dynamic>? body = response.data;
    // log(body.toString());
    MediaSource source = MediaSource.fromMap(body ?? {});

    return source;
    } catch (e) {
      log(e.toString());
    log('Video Not Found');
    return await null;
    }
  }
}
