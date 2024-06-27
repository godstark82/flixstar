import 'package:dooflix/features/history/presentation/bloc/history_bloc.dart';
import 'package:dooflix/features/home/presentation/bloc/home_bloc.dart';
import 'package:dooflix/features/library/presentation/bloc/library_bloc.dart';
import 'package:dooflix/features/search/presentation/bloc/search_bloc.dart';
import 'package:dooflix/injection_container.dart';
import 'package:dooflix/core/utils/theme_data.dart';
import 'package:dooflix/features/home/presentation/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  await Hive.initFlutter();
  await Hive.openBox('library');
  await Hive.openBox('settings');
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<HomeBloc>(create: (context) => sl<HomeBloc>()),
          BlocProvider(create: (context) => LibraryBloc()), // Library Bloc
          BlocProvider(create: (context) => HistoryBloc(sl())), // Episode Bloc
          BlocProvider(create: (context) => SearchBloc()), // History Bloc
        ],
        child: GetMaterialApp(
          title: 'Dooflix',
          debugShowCheckedModeBanner: false,
          theme: theme,
          home: Home(),
        ));
  }
}
