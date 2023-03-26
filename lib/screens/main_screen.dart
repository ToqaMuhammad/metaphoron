import 'package:flutter/material.dart';
import 'package:untitled/screens/login_screen.dart';

import 'about_screen.dart';
import 'home_screen.dart';
import 'map_screen.dart';

class MainScreen extends StatefulWidget {
  static String id = 'main';
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.brown[700],
          title: const Text(
            'MetaPhoron',
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 3,
            tabs: [
              const Icon(
                Icons.home_filled,
                color: Colors.white,
              ),
              const Icon(
                Icons.map_outlined,
                color: Colors.white,
              ),
              IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.exit_to_app,
                    color: Colors.white,
                  ),
              ),
              const Icon(
                Icons.info,
                color: Colors.white,
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const HomeScreen(),
            const MapScreen(),
            Container(),
            const AboutScreen(),
          ],
        ),
      ),
    );
  }
}
