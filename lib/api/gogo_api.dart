// ignore_for_file: prefer_collection_literals, unnecessary_new

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flixstar/features/anime/data/models/anime_details_model.dart';
import 'package:flixstar/features/anime/data/models/source_model.dart';
import 'package:jikan_api/jikan_api.dart';

const goAnimeBaseUrl =
    'https://api-consumet-org-brown.vercel.app/anime/gogoanime';

class GoAnime {
  final Dio dio;
  GoAnime(this.dio) {
    // dio.interceptors.add(PrettyDioLogger(requestBody: false));
  }

  Future<List<AnimeSource>> getEpisodesLinksOfAnime(Anime anime,
      {required int count}) async {
    // int count = page * 20;
    int i = 0;
    List<AnimeSource> animeSources = [];
    await Future.wait<void>([
      for (i = 1; i <= count; i++)
        _getLinksOfEpisode(anime, episode: i).then((v) {
          animeSources.add(v);
        })
    ]);
    animeSources.sort((a, b) =>
        int.parse(a.episodeId!.replaceAll(RegExp('[^0-9]'), '')).compareTo(
            int.parse(b.episodeId!.replaceAll(RegExp('[^0-9]'), ''))));
    return animeSources;
  }

  Future<AnimeSource> _getLinksOfEpisode(Anime anime, {int? episode}) async {
    try {
      print(anime.episodes);
      //?
      final searchResult = await _searchAnime(
          (anime.titleEnglish ?? anime.title).toLowerCase(), 1);
      final animeDetails = await _getAnimeInfo(searchResult.first.id ?? '');
      final link = await _getStreamingLink(
          animeDetails.episodes?[(episode ?? 1) - 1].id ?? '');
      return link;
    } catch (e) {
      //
      print(e);
      rethrow;
    }
  }

  Future<List<AnimeSearchModel>> _searchAnime(String query, int page) async {
    try {
      final url = '$goAnimeBaseUrl/$query?page=$page';
      final response = await dio.get(url);

      final results = (response.data['results'] as List)
          .map((result) => Map<String, dynamic>.from(result))
          .toList()
          .map((item) => AnimeSearchModel.fromJson(item))
          .toList();

      return results;
    } catch (e) {
      rethrow;
    }
  }

  Future<AnimeSource> _getStreamingLink(String episodeId) async {
    try {
      final url = '$goAnimeBaseUrl/watch/$episodeId';
      final response = await dio.get(url);
      AnimeSource? source = AnimeSource();
      final fetchedData =
          ((response.data as Map<String, dynamic>)['sources'] as List)
              .map((mapData) => Map<String, dynamic>.from(mapData))
              .toList();
      source.isM3u8 = fetchedData[0]['isM3u8'];
      source.episodeId = episodeId;

      for (int i = 0; i < fetchedData.length; i++) {
        switch ('${fetchedData[i]['quality']}') {
          case '360p':
            {
              source.url360p = fetchedData[i]['url'];
            }
            break;
          case '480p':
            {
              source.url480p = fetchedData[i]['url'];
            }
            break;
          case '720p':
            {
              source.url720p = fetchedData[i]['url'];
            }
            break;
          case '1080p':
            {
              source.url1080p = fetchedData[i]['url'];
            }
            break;
          default:
            {
              source.url720p = fetchedData[i]['url'];
            }
            break;
        }
      }
      log('${source.episodeId}');
      return source;
      // .toList();
      // return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<AnimeDetailsModel> _getAnimeInfo(String id) async {
    try {
      final url = '$goAnimeBaseUrl/info/$id';
      final response = await dio.get(url);
      final data = response.data as Map<String, dynamic>;
      final anime = AnimeDetailsModel.fromJson(data);
      return anime;
    } catch (e) {
      rethrow;
    }
  }
}

class AnimeSearchModel {
  String? id;
  String? title;
  String? url;
  String? image;
  String? releaseDate;
  String? subOrDub;

  AnimeSearchModel(
      {this.id,
      this.title,
      this.url,
      this.image,
      this.releaseDate,
      this.subOrDub});

  AnimeSearchModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    url = json['url'];
    image = json['image'];
    releaseDate = json['releaseDate'];
    subOrDub = json['subOrDub'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['url'] = url;
    data['image'] = image;
    data['releaseDate'] = releaseDate;
    data['subOrDub'] = subOrDub;
    return data;
  }
}

enum Server { vidcloud, streamsb, vidstreaming, streamtape }
