import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flixstar/common/pages/update_screen.dart';
import 'package:flixstar/core/const/const.dart';
import 'package:flixstar/core/utils/theme_data.dart';
import 'package:flixstar/features/history/presentation/bloc/history_bloc.dart';
import 'package:flixstar/features/home/presentation/bloc/home_bloc.dart';
import 'package:flixstar/features/home/presentation/pages/home.dart';
import 'package:flixstar/features/library/presentation/bloc/library_bloc.dart';
import 'package:flixstar/features/movie/presentation/bloc/movie_bloc.dart';
import 'package:flixstar/features/search/presentation/bloc/search_bloc.dart';
import 'package:flixstar/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialiseDependencies();
  await MobileAds.instance.initialize().then((InitializationStatus status) {});
  runApp(isUpdateAvailable ? UpdateWarningScreen() : App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<HomeBloc>(create: (context) => sl<HomeBloc>()),
          BlocProvider<MovieBloc>(create: (context) => sl<MovieBloc>()),
          BlocProvider<LibraryBloc>(
              create: (context) => sl<LibraryBloc>()), // Library Bloc
          BlocProvider<HistoryBloc>(
              create: (context) => sl<HistoryBloc>()), // Episode Bloc
          BlocProvider<SearchBloc>(
              create: (context) => sl<SearchBloc>()), // History Bloc
        ],
        child: GetMaterialApp(
          title: 'FlixStar',
          debugShowCheckedModeBanner: false,
          theme: theme,
          home: Home(),
        ));
  }
}
