import 'package:dooflix/data/models/subtitle_config.dart';
import 'package:dooflix/presentation/screens/settings/components/subtitles.dart';

abstract class SettingsEvent {}

class LoadSettingsEvent extends SettingsEvent {}

class SaveSettingsEvent extends SettingsEvent {
  final CustomSubtitleConfiguration subtitleConfig;
  SaveSettingsEvent(this.subtitleConfig);
}


class ResetSettingsEvent extends SettingsEvent {}

