import 'package:e_commerce/pages/home/main_food_page.dart';
import 'package:e_commerce/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _seletedindex = 0;
  List pages = [
    MainFoodPage(),
    Container(child: Center(child: Text('Next page'))),
    Container(child: Center(child: Text('About page'))),
    Container(child: Center(child: Text('profile Page'))),
  ];
  void onTapNav(int index) {
    setState(() {
      _seletedindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_seletedindex],
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: AppColors.mainColor,
          unselectedItemColor: Colors.amberAccent,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: _seletedindex,
          onTap: onTapNav,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: 'home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.book_online), label: 'about'),
            BottomNavigationBarItem(
                icon: Icon(Icons.pregnant_woman_outlined), label: 'profile'),
            BottomNavigationBarItem(
                icon: Icon(Icons.search_outlined), label: 'Search'),
          ]),
    );
  }
}
