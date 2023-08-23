import 'package:backend_flutter_ivo/screens/_fab_action.dart';
import 'package:backend_flutter_ivo/screens/media_category_crud/index.dart';
import 'package:backend_flutter_ivo/screens/media_crud/index.dart';
import 'package:flutter/material.dart';

class CrudSelecter extends StatefulWidget {
  final Function(FABAction) fabAction;
  final Function(Widget) fabAdd;

  final List<Widget> cruds = [];

  CrudSelecter({required this.fabAction, required this.fabAdd, Key? key})
      : super(key: key);

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

    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   widget.fabAdd(
    //     const ExpandableFabButton(
    //       options: ['One', 'Two', 'Three'],
    //     ),
    //   );
    // });
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
        ],
      ),
    );
  }
}
