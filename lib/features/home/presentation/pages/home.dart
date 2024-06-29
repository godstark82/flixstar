import 'package:flixstar/features/home/presentation/bloc/home_bloc.dart';
import 'package:flixstar/features/home/presentation/pages/anime_homescreen.dart';
import 'package:flixstar/features/home/presentation/pages/discover_screen.dart';
import 'package:flixstar/features/home/presentation/pages/home_screen.dart';
import 'package:flixstar/features/home/presentation/pages/more_screen.dart';
import 'package:flixstar/features/home/presentation/pages/tv_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullscreen_window/fullscreen_window.dart';
import 'package:get/get.dart';
import 'package:keymap/keymap.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    context.read<HomeBloc>().add(LoadHomeDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardWidget(
      // backgroundColor: Colors.white,
      bindings: [
        KeyAction(LogicalKeyboardKey.f11, 'FULLSCREEN', () async {
          final Size deviceSize = await FullScreenWindow.getScreenSize(context);
          if (context.width == deviceSize.width &&
              context.height == deviceSize.height) {
            FullScreenWindow.setFullScreen(false);
          } else {
            FullScreenWindow.setFullScreen(true);
          }
        }),
        KeyAction(LogicalKeyboardKey.arrowLeft, 'Back', () {
          Get.back();
        }, isAltPressed: true),
        KeyAction(LogicalKeyboardKey.keyZ, 'BACK', () {
          Get.back();
        }, isControlPressed: true),
      ],
      child: Scaffold(
          body: Center(child: bottomNavScreen.elementAt(currentIndex)),
          bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey,
              showUnselectedLabels: true,
              selectedLabelStyle: TextStyle().copyWith(color: Colors.grey),
              unselectedLabelStyle: TextStyle().copyWith(color: Colors.white),
              items: bottomNavItems,
              currentIndex: currentIndex,
              onTap: (index) {
                setState(() {
                  currentIndex = index;
                });
              })),
    );
  }
}

int currentIndex = 0;

List<BottomNavigationBarItem> bottomNavItems = const <BottomNavigationBarItem>[
  BottomNavigationBarItem(icon: Icon(Icons.movie), label: 'Movies'),
  BottomNavigationBarItem(icon: Icon(Icons.tv), label: 'TV'),
  BottomNavigationBarItem(
      icon: Image(
        image: AssetImage('assets/icons/avatar.png'),
        height: 25,
        width: 25,
      ),
      label: 'Anime'),
  BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Discover'),
  BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'More'),
];

const List<Widget> bottomNavScreen = <Widget>[
  HomeScreen(),
  TvScreen(),
  AnimeHomescreen(),
  DiscoverScreen(),
  MoreOptionScreen(),
];
