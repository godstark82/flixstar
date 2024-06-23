import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dooflix/data/models/subtitle_config.dart';
import 'package:dooflix/logic/blocs/settings_bloc/settings_event.dart';
import 'package:dooflix/logic/blocs/settings_bloc/settings_state.dart';
import 'package:dooflix/presentation/screens/settings/components/subtitles.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(LoadingSettingsState()) {
    on<LoadSettingsEvent>(_loadSettings);
    on<SaveSettingsEvent>(_saveSettings);
    on<ResetSettingsEvent>(_resetSettings);
  }

  void _loadSettings(
      LoadSettingsEvent event, Emitter<SettingsState> emit) async {
    final defaultSubtitleConfig = CustomSubtitleConfiguration(
      bgColor: Colors.black.withOpacity(0.8),
      textColor: Colors.white,
      fontSize: 16,
    );
    final config = (await Hive.box('settings').get('subtitles') ??
        defaultSubtitleConfig.toJson()) as Map;
    log('$config');
    emit(LoadedSettingsState(
        subtitleConfig: CustomSubtitleConfiguration.fromJson(
            config.cast<String, dynamic>())));
  }

  void _saveSettings(
      SaveSettingsEvent event, Emitter<SettingsState> emit) async {
    log('${event.subtitleConfig.toJson()}');
    await Hive.box('settings').put('subtitles', event.subtitleConfig.toJson());

    emit(LoadedSettingsState(subtitleConfig: event.subtitleConfig));
  }

  void _resetSettings(
      ResetSettingsEvent event, Emitter<SettingsState> emit) async {
    emit(LoadingSettingsState());
    final defaultSubtitleConfig = CustomSubtitleConfiguration(
      bgColor: Colors.black.withOpacity(0.8),
      textColor: Colors.white,
      fontSize: 16,
    );
    await Hive.box('settings').put('subtitles', defaultSubtitleConfig.toJson());
    emit(LoadedSettingsState(
        subtitleConfig: CustomSubtitleConfiguration.fromJson(
            (Hive.box('settings').get('subtitles') as Map)
                .cast<String, dynamic>())));
  }
}
