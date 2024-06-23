// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AnimeSource {
  String? url360p;
  String? url480p;
  String? url720p;
  String? url1080p;
  bool? isM3u8;
  String? episodeId;

  AnimeSource({
    this.isM3u8,
    this.episodeId,
    this.url1080p,
    this.url360p,
    this.url480p,
    this.url720p,
  });

  factory AnimeSource.fromJson(Map<String, dynamic> json) {
    return AnimeSource(
      url360p: json['url360p'],
      episodeId: json['episodeId'],
      url480p: json['url480p'],
      url720p: json['url720p'],
      url1080p: json['url1080p'],
      isM3u8: json['isM3u8'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'url360p': url360p,
      'url480p': url480p,
      'url720p': url720p,
      'url1080p': url1080p,
      'isM3u8': isM3u8,
      'episodeId': episodeId,
    };
  }

  factory AnimeSource.fromMap(Map<String, dynamic> map) {
    return AnimeSource(
      url360p: map['url360p'] != null ? map['url360p'] as String : null,
      url480p: map['url480p'] != null ? map['url480p'] as String : null,
      url720p: map['url720p'] != null ? map['url720p'] as String : null,
      url1080p: map['url1080p'] != null ? map['url1080p'] as String : null,
      isM3u8: map['isM3u8'] != null ? map['isM3u8'] as bool : null,
      episodeId: map['episodeId'] != null ? map['episodeId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());
}
