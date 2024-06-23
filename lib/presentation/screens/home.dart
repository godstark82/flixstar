import 'package:cached_network_image/cached_network_image.dart';
import 'package:dooflix/features/anime/presentation/pages/anime_homescreen.dart';
import 'package:dooflix/presentation/screens/discover_screen.dart';
import 'package:dooflix/presentation/screens/home_screen.dart';
import 'package:dooflix/presentation/screens/library_screen.dart';
import 'package:dooflix/presentation/screens/more_screen.dart';
import 'package:dooflix/presentation/screens/tv_screen.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            }));
  }
}

int currentIndex = 0;

List<BottomNavigationBarItem> bottomNavItems = const <BottomNavigationBarItem>[
  BottomNavigationBarItem(icon: Icon(Icons.movie), label: 'Movies'),
  BottomNavigationBarItem(
      icon: Icon(Icons.tv),
      label: 'TV'),
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
