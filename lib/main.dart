import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dooflix/api/api.dart';
import 'package:dooflix/api/player_api.dart';
import 'package:dooflix/data/repositories/movie_repo.dart';
import 'package:dooflix/data/repositories/tv_repo.dart';
import 'package:dooflix/features/anime/presentation/bloc/anime_bloc.dart';
import 'package:dooflix/injection_container.dart';
import 'package:dooflix/logic/blocs/episodes_bloc/episodes_bloc.dart';
import 'package:dooflix/logic/blocs/history_bloc.dart/history_bloc.dart';
import 'package:dooflix/logic/blocs/library_bloc/library_bloc.dart';
import 'package:dooflix/logic/blocs/search_bloc/search_bloc.dart';
import 'package:dooflix/logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:dooflix/logic/blocs/video_player_bloc/video_player_bloc.dart';
import 'package:dooflix/logic/cubits/movie_details_cubit/movie_detail_cubit.dart';
import 'package:dooflix/logic/cubits/movie_home_cubit/movie_home_cubit.dart';
import 'package:dooflix/core/routes/routes.dart';
import 'package:dooflix/core/utils/theme_data.dart';
import 'package:dooflix/logic/cubits/provider_cubit.dart/provider_cubit.dart';
import 'package:dooflix/logic/cubits/tv_details_cubit/tv_detail_cubit.dart';
import 'package:dooflix/logic/cubits/tv_home_cubit/tv_home_cubit.dart';
import 'package:dooflix/presentation/screens/home.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  await Hive.initFlutter();
  await Hive.openBox('library');
  await Hive.openBox('settings');
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  runApp(const App());
}




class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => MovieCubit()),

          BlocProvider(create: (context) => ProviderCubit()),
          BlocProvider(create: (context) => TvHomeCubit()),

          BlocProvider(create: (context) => LibraryBloc()), // Library Bloc
          BlocProvider(create: (context) => HistoryBloc()),
          BlocProvider(
              create: (context) => VideoPlayerBloc()), // VideoPlayer Bloc
          BlocProvider(create: (context) => EpisodesBloc()), // Episode Bloc
          BlocProvider(create: (context) => SettingsBloc()), // Settings Bloc
          BlocProvider(create: (context) => SearchBloc()), // Search Bloc
          BlocProvider(create: (context) => HistoryBloc()), // History Bloc

          BlocProvider(
              create: (context) => AnimeHomeBloc(sl(), sl(), sl(), sl())),
        ],
        child: GetMaterialApp(
          title: 'Dooflix',
          debugShowCheckedModeBanner: false,
          theme: theme,
          home: Home(),
        ));
  }
}
