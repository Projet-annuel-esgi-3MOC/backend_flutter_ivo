import 'package:backend_flutter_ivo/screens/_fab_action.dart';
import 'package:backend_flutter_ivo/screens/button_pusher.dart';
import 'package:backend_flutter_ivo/screens/crud_selecter.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPageIndex = 1;
  final List<Widget> fabs = [];

  void addFab(Widget fab) {
    setState(() {
      fabs.add(fab);
    });
  }

  FABAction? fabAction;

  void changeFabAction(FABAction fun) {
    fabAction = fun;
  }

  @override
  void initState() {
    super.initState();

    addFab(FloatingActionButton(
      onPressed: () => fabAction!.function(fabAction!.parameters),
      child: const Icon(Icons.add),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child: [
            const ButtonPusher(title: 'my title'),
            CrudSelecter(
              fabAction: changeFabAction,
              fabAdd: addFab,
            ),
          ][currentPageIndex]),
          Positioned(
            bottom: 16,
            right: 16,
            child: Row(
              children: [
                for (var fab in fabs)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: fab,
                  ),
              ],
            ),
          ),
        ],
      ),
      /*bottomNavigationBar: NavigationBar(
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
      ),*/
    );
  }
}
