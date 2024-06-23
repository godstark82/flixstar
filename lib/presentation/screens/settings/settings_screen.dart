import 'package:dooflix/logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:dooflix/logic/blocs/settings_bloc/settings_state.dart';
import 'package:dooflix/presentation/screens/settings/components/quality.dart';
import 'package:dooflix/presentation/screens/settings/components/subtitles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings'), centerTitle: true),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          return ListView(
            children: [
              Card(
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SubtitleSettings()));
                  },
                  leading: Icon(Icons.subtitles_outlined),
                  title: Text('Subtitle Settings'),
                  subtitle: Text('Configure subtitles'),
                ),
              ),
              //  Card(
              //   child: ListTile(
              //     onTap: () {
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => QualitySettingScreen()));
              //     },
              //     leading: Icon(Icons.image),
              //     title: Text('Quality Settings'),
              //     subtitle: Text('Quality of images'),
              //   ),
              // ),
            ],
          );
        },
      ),
    );
  }
}
