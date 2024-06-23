import 'package:dooflix/data/models/subtitle_config.dart';
import 'package:dooflix/presentation/screens/settings/components/subtitles.dart';

abstract class SettingsState {}

class LoadedSettingsState extends SettingsState {
  final CustomSubtitleConfiguration subtitleConfig;
  LoadedSettingsState({required this.subtitleConfig});
}

class LoadingSettingsState extends SettingsState {}

class ErrorSettingsState extends SettingsState {}
