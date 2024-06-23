import 'dart:developer';

import 'package:dooflix/api/api.dart';
import 'package:dooflix/api/player_api.dart';
import 'package:dooflix/data/models/genre_model.dart';
import 'package:dooflix/data/models/tv_details_model.dart';
import 'package:dooflix/data/models/tv_model.dart';
import 'package:hive/hive.dart';

class TvRepository {
  API api = API();

  Future<List<TvModel>> fetchPopularTvs() async {
    try {
      Map response = await api.tmdb.v3.tv.getPopular(
        language: 'EN',
      );
      List<Map<String, dynamic>> results =
          (response['results'] as List<dynamic>)
              .map((result) => Map<String, dynamic>.from(result))
              .toList();
      List<TvModel> popularMovies =
          results.map((map) => TvModel.fromJson(map)).toList();
      return popularMovies;
    } catch (ex) {
      log(ex.toString(), error: ex);
      rethrow;
    }
  }

  Future<List<TvModel>> fetchTopRatedTvs() async {
    try {
      Map response = await api.tmdb.v3.tv.getTopRated(language: 'HI');
      List<Map<String, dynamic>> results =
          (response['results'] as List<dynamic>)
              .map((result) => Map<String, dynamic>.from(result))
              .toList();
      List<TvModel> tredingMovies =
          results.map((map) => TvModel.fromJson(map)).toList();
      return tredingMovies;
    } catch (ex) {
      log(ex.toString(), error: ex);
      rethrow;
    }
  }

  /// Search a Specific TV with TMDB id
  Future<TvDetails> fetchTvById(
    int id,
  ) async {
    try {
      Map response = await api.tmdb.v3.tv.getDetails(id);
      Map<String, dynamic> tvResult = Map<String, dynamic>.from(response);
      TvDetails tvSeries = TvDetails.fromJson(tvResult);
      for (var i = 0; i < tvSeries.seasons!.length; i++) {
        tvSeries.seasons![i].episodes = await findSeasonEpisodes(
          tvId: id,
          seasonCount: tvSeries.seasons![i].seasonNumber!,
        );
      }
      return tvSeries;
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }

  Future<List<TvEpisode>> findSeasonEpisodes({
    required int tvId,
    required int seasonCount,
  }) async {
    final stopwatch1 = Stopwatch();
    final stopwatch2 = Stopwatch();
    stopwatch1.start();
    final response = await api.tmdb.v3.tvSeasons.getDetails(tvId, seasonCount);
    List<Map<String, dynamic>> episodesMap = (response['episodes'] as List)
        .map((e) => Map<String, dynamic>.from(e))
        .toList();

    List<TvEpisode> episodes =
        episodesMap.map((e) => TvEpisode.fromJson(e)).toList();

    log('Episodes Fetched in ${stopwatch1.elapsed}ms');

//! To Parallel Run the episodes fetching Command
    stopwatch2.start();
    final futures = episodes
        .map((ep) async => ep.playingSource = await PlayerApi().videoUrl(tvId,
            season: seasonCount, episode: episodes.indexOf(ep) + 1))
        .toList();
    await Future.wait(futures);

    log('Links of the episodes fetched in ${stopwatch2.elapsed}ms');
    return episodes
        .where((episode) => episode.playingSource?.url != 'NULL')
        .toList();
  }


  /// fetch Related TV by TMDB ID
  Future<List<TvModel>> fetchRelatedTvs(int id) async {
    try {
      Map response = await api.tmdb.v3.tv.getSimilar(id, language: 'in-HI');
      List<Map<String, dynamic>> results =
          (response['results'] as List<dynamic>)
              .map((result) => Map<String, dynamic>.from(result))
              .toList();
      List<TvModel> relatedMovies =
          results.map((map) => TvModel.fromJson(map)).toList();

      return relatedMovies;
    } catch (ex) {
      rethrow;
    }
  }

  Future<List<GenreTvModel>> getGenres() async {
    final response = await api.tmdb.v3.genres.getTvlist(language: 'in-HI');
    List<Map<String, dynamic>> genres = (response['genres'] as List<dynamic>)
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
    List<GenreTvModel> genreModels =
        genres.map((e) => GenreTvModel.fromJson(e)).toList();

    for (var i = 0; i < genreModels.length; i++) {
      genreModels[i].movies = await getGenreSeries(genreModels[i].id);
    }
    return genreModels;
  }

  Future<List<TvModel>> getGenreSeries(int id, {int page = 1}) async {
    final movieResponse = await api.tmdb.v3.discover.getTvShows(
        withGenres: id.toString(),
        page: page,
        watchRegion: 'IN',
        withOrginalLanguage: 'hi');
    List<Map<String, dynamic>> results = (movieResponse['results'] as List)
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
    List<TvModel> movies = results.map((e) => TvModel.fromJson(e)).toList();
    return movies;
  }

  Future<List<TvModel>> getNetworkTvs(String name, {int page = 1}) async {
    // final response = await api.tmdb.v3.networks.
    final response = await api.tmdb.v3.discover.getTvShows(
      withWatchProviders: name,
      watchRegion: 'IN',
      page: page,
      withOrginalLanguage: 'hi',
    );
    final results = (response['results'] as List)
        .map((result) => Map<String, dynamic>.from(result))
        .toList();
    List<TvModel> movies = results.map((map) => TvModel.fromJson(map)).toList();
    return movies;
  }

  // end of repo
}
