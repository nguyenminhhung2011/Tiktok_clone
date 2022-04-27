import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/constains.dart';
import 'package:tiktok_clone/controls/auth_controls.dart';

import '../../widgets/icon_desgin.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String s = "";
  int _page = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: (_page != 2)
              ? Color.fromARGB(255, 136, 199, 250)
              : Colors.transparent,
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
        child: NavigationBar(
          backgroundColor: backgroundColor,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          height: 60,
          selectedIndex: _page,
          onDestinationSelected: (int newIndex) {
            setState(() {
              _page = newIndex;
            });
          },
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.home),
              selectedIcon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.search),
              selectedIcon: Icon(Icons.search),
              label: 'Search',
            ),
            NavigationDestination(
              icon: IconDesgin(),
              selectedIcon: IconDesgin(),
              label: 'Post',
            ),
            NavigationDestination(
              icon: Icon(Icons.message),
              selectedIcon: Icon(Icons.message),
              label: 'Notification',
            ),
            NavigationDestination(
              icon: Icon(Icons.person),
              selectedIcon: Icon(Icons.person),
              label: 'Profile',
            )
          ],
        ),
      ),
      body: Center(
        child: InkWell(
          onTap: () async {
            await FirebaseAuth.instance.signOut();
          },
          child: Text("lock out"),
        ),
      ),
    );
  }
}
