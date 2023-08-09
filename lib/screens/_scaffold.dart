import 'package:backend_flutter_ivo/screens/button_pusher.dart';
import 'package:backend_flutter_ivo/screens/media_type_crud/index.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: [
        const ButtonPusher(title: 'my title'),
        const MediaTypeCrud(),
      ][currentPageIndex],
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Accueil'),
          NavigationDestination(
            icon: Icon(Icons.favorite_outline),
            selectedIcon: Icon(Icons.favorite),
            label: 'Favoris',
          ),
        ],
        selectedIndex: currentPageIndex,
        animationDuration: const Duration(milliseconds: 200),
        onDestinationSelected: (index) async {

          setState(() {
            currentPageIndex = index;
          });
        },
      ),
    );
  }
}
