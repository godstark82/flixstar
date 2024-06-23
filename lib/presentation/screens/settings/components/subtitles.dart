// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dooflix/logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:dooflix/logic/blocs/settings_bloc/settings_event.dart';
import 'package:dooflix/logic/blocs/settings_bloc/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';

import 'package:dooflix/presentation/widgets/heading_2.dart';
import 'package:hive/hive.dart';

class SubtitleSettings extends StatelessWidget {
  const SubtitleSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Subtitles'),
          actions: [
            IconButton(
              onPressed: () {
                context.read<SettingsBloc>().add(ResetSettingsEvent());
              },
              icon: Icon(Icons.restore_outlined),
              tooltip: 'Reset',
            )
          ],
        ),
        body: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            if (state is LoadedSettingsState) {
              return ListView(
                children: [
                  SizedBox(
                      height: context.height * 0.3,
                      child: Stack(children: [
                        Center(
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://www.journal-topics.com/wp-content/uploads/2019/10/joker.jpg',
                            // fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                    color: state.subtitleConfig.bgColor,
                                    child: Text('This is a example of Subtitle',
                                        style: TextStyle(
                                            fontSize:
                                                state.subtitleConfig.fontSize,
                                            color: state
                                                .subtitleConfig.textColor)))))
                      ])),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Heading2(text: 'Font Size'),
                  ),
                  Slider(
                    min: 8,
                    max: 25,
                    value: state.subtitleConfig.fontSize.toDouble(),
                    thumbColor: Colors.orange,
                    activeColor: Colors.orange,
                    onChanged: (newValue) async {
                      context.read<SettingsBloc>().add(SaveSettingsEvent(state
                          .subtitleConfig
                          .copyWith(fontSize: newValue.toDouble())));
                    },
                  ),
                  Card(
                    child: ListTile(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ColorPicker(
                                          pickerColor:
                                              state.subtitleConfig.textColor,
                                          onColorChanged: (newColor) async {
                                            context.read<SettingsBloc>().add(
                                                SaveSettingsEvent(state
                                                    .subtitleConfig
                                                    .copyWith(
                                                        textColor: newColor)));
                                          })
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text('OK'))
                                  ],
                                ));
                      },
                      title: Text('Text Color'),
                      trailing: Container(
                        height: 30,
                        width: 50,
                        color: state.subtitleConfig.textColor,
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ColorPicker(
                                          pickerColor:
                                              state.subtitleConfig.bgColor,
                                          onColorChanged: (newColor) async {
                                            context.read<SettingsBloc>().add(
                                                SaveSettingsEvent(state
                                                    .subtitleConfig
                                                    .copyWith(
                                                        bgColor: newColor)));
                                          })
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text('OK'))
                                  ],
                                ));
                      },
                      title: Text('Background Color'),
                      trailing: Container(
                        height: 30,
                        width: 50,
                        color: state.subtitleConfig.bgColor,
                      ),
                    ),
                  )
                ],
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ));
  }
}
