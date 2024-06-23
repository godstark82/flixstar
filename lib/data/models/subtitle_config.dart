import 'package:flutter/material.dart';

class CustomSubtitleConfiguration {
  final double fontSize;
  final Color textColor;
  final Color bgColor;

  const CustomSubtitleConfiguration(
      {required this.bgColor, required this.fontSize, required this.textColor});

  CustomSubtitleConfiguration copyWith({
    double? fontSize,
    Color? textColor,
    Color? bgColor,
  }) {
    return CustomSubtitleConfiguration(
      fontSize: fontSize ?? this.fontSize,
      textColor: textColor ?? this.textColor,
      bgColor: bgColor ?? this.bgColor,
    );
  }

  factory CustomSubtitleConfiguration.fromJson(Map<String, dynamic> json) {
    return CustomSubtitleConfiguration(
        bgColor: Color.fromRGBO(
          json['bgColor']['r'],
          json['bgColor']['g'],
          json['bgColor']['b'],
          json['bgColor']['o'],
        ),
        fontSize: json['fontSize'],
        textColor: Color.fromRGBO(
          json['textColor']['r'],
          json['textColor']['g'],
          json['textColor']['b'],
          json['textColor']['o'],
        ));
  }

  Map<String, dynamic> toJson() {
    return {
      'fontSize': fontSize,
      'textColor': {
        'r': textColor.red,
        'g': textColor.green,
        'b': textColor.blue,
        'o': textColor.opacity,
      },
      'bgColor': {
        'r': bgColor.red,
        'g': bgColor.green,
        'b': bgColor.blue,
        'o': bgColor.opacity,
      },
    };
  }
}
