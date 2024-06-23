// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MediaSource {
  final String? url;
  final List<SubtitleModel>? subtitles;
  const MediaSource({required this.url, required this.subtitles});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'url': url,
      'subtitles': subtitles?.map((x) => x.toMap()).toList(),
    };
  }

  factory MediaSource.fromMap(Map<String, dynamic> map) {
    return MediaSource(
      url: map['source'] as String?,
      subtitles: (map['subtitles'] != null)
          ? List<SubtitleModel>.from(
              (map['subtitles'] as List).map<SubtitleModel>(
                (x) => SubtitleModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
      // subtitles: List<SubtitleModel>.from((map['subtitles'] as List).map<SubtitleModel>((x) => SubtitleModel.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory MediaSource.fromJson(String source) =>
      MediaSource.fromMap(json.decode(source) as Map<String, dynamic>);
}

class SubtitleModel {
  final String name;
  final String url;
  const SubtitleModel({required this.name, required this.url});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'url': url,
    };
  }

  factory SubtitleModel.fromMap(Map<String, dynamic> map) {
    return SubtitleModel(
      name: map['label'] as String,
      url: map['file'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SubtitleModel.fromJson(String source) =>
      SubtitleModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
