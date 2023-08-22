import 'package:backend_flutter_ivo/bo/_i_bo.dart';
import 'package:backend_flutter_ivo/screens/_fab_action.dart';
import 'package:backend_flutter_ivo/screens/media_category_crud/index.dart';
import 'package:backend_flutter_ivo/screens/media_crud/index.dart';
import 'package:flutter/material.dart';

class CrudSelecter extends StatefulWidget {
  late Function(FABAction) fabAction;

  final List<Widget> cruds = [];

  CrudSelecter({required this.fabAction, Key? key}) : super(key: key);

  @override
  State<CrudSelecter> createState() => _CrudSelecterState();
}

class _CrudSelecterState extends State<CrudSelecter> {
  late Widget _selectedCrud;
  bool isDropDownOpen = false;

  @override
  void initState() {
    super.initState();
    widget.cruds.addAll([
      MediaCategoryCrud(fabAction: widget.fabAction),
      MediaCrud(fabAction: widget.fabAction),
    ]);

    _selectedCrud = widget.cruds.first;
  }

  void toggleDropdown() {
    setState(() {
      isDropDownOpen = !isDropDownOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _selectedCrud,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Column(
        children: [
          FloatingActionButton.extended(
            onPressed: () => setState(() {
              isDropDownOpen = !isDropDownOpen;
            }),
            label: Text(_selectedCrud.runtimeType.toString()),
            icon: const Icon(Icons.list),
          ),
          if (isDropDownOpen)
            DropdownButton<String>(
              value: _selectedCrud.runtimeType.toString(),
              onChanged: (newValue) {
                setState(() {
                  _selectedCrud = widget.cruds
                      .where((element) =>
                          element.runtimeType.toString() ==
                          element.runtimeType.toString())
                      .first;
                  toggleDropdown();
                });
              },
              items: widget.cruds.map((item) {
                return DropdownMenuItem<String>(
                  value: item.runtimeType.toString(),
                  child: Text(item.runtimeType.toString()),
                );
              }).toList(),
            ),
          PopupMenuButton<String>(
            icon: Icon(Icons.arrow_drop_down),
            onSelected: (selectedItem) {
              print('Selected: $selectedItem');
            },
            itemBuilder: (BuildContext context) {
              return widget.cruds.map((Widget item) {
                return PopupMenuItem<String>(
                  value: item.runtimeType.toString(),
                  child: Text(item.runtimeType.toString()),
                );
              }).toList();
            },
          ),
        ],
      ),
    );
  }
}
