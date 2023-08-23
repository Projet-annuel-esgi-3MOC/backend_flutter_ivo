import 'package:backend_flutter_ivo/bo/_i_firebaseable.dart';
import 'package:flutter/material.dart';

class CrudEdit<T extends Firebaseable> extends StatefulWidget {
  final List<Widget> fields;
  final Future<void> Function() onSave;

  const CrudEdit({
    required this.fields,
    required this.onSave,
    Key? key,
  }) : super(key: key);

  @override
  State<CrudEdit> createState() => _CrudEditState();
}

class _CrudEditState extends State<CrudEdit> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          ...widget.fields,
          ElevatedButton(
            onPressed: () async {
              // Update the item with the new values

              await widget.onSave();
              // Call your update method here

              //Navigator.pop(context);
            },
            child: const Text('Save Changes'),
          ),
        ],
      ),
    );
  }
}
