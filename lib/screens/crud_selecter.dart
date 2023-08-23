import 'package:backend_flutter_ivo/screens/_fab_action.dart';
import 'package:backend_flutter_ivo/screens/media_category_crud/index.dart';
import 'package:backend_flutter_ivo/screens/media_crud/index.dart';
import 'package:flutter/material.dart';

class CrudSelecter extends StatefulWidget {
  final List<Widget> cruds = [];

  CrudSelecter({Key? key}) : super(key: key);

  @override
  State<CrudSelecter> createState() => _CrudSelecterState();
}

class _CrudSelecterState extends State<CrudSelecter> {
  late Widget _selectedCrud;
  bool isDropDownOpen = false;

  late FABAction fabAction;

  void changeFabAction(FABAction fun) {
    fabAction = (fun);
  }

  @override
  void initState() {
    fabAction = FABAction(function: (_) => print('no fab'), parameters: []);
    super.initState();
    widget.cruds.addAll(
      [
        MediaCategoryCrud(setFab: changeFabAction),
        MediaCrud(setFAB: changeFabAction),
      ],
    );

    _selectedCrud = widget.cruds.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: _selectedCrud),
          Positioned(
            bottom: 16,
            left: 16,
            child: DropdownButton<String>(
              value: _selectedCrud.runtimeType.toString(),
              onChanged: (newValue) {
                setState(() {
                  _selectedCrud = widget.cruds
                      .where((element) =>
                          element.runtimeType.toString() == newValue)
                      .first;
                });
                print('Crud changed $newValue');
              },
              items: widget.cruds.map((item) {
                return DropdownMenuItem<String>(
                  value: item.runtimeType.toString(),
                  child: Text(item.runtimeType.toString()),
                );
              }).toList(),
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: () => fabAction.function(fabAction.parameters),
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
