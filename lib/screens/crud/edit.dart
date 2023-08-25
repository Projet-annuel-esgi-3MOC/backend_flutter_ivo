import 'package:backend_flutter_ivo/bo/_i_firebaseable.dart';
import 'package:backend_flutter_ivo/dal/providers/_i_provider.dart';
import 'package:backend_flutter_ivo/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CrudEdit<T extends Firebaseable, P extends Iprovider>
    extends StatefulWidget {
  final List<Widget> fields;
  final Future<void> Function(T) onSave;
  final T object;

  const CrudEdit({
    required this.fields,
    required this.onSave,
    required this.object,
    Key? key,
  }) : super(key: key);

  @override
  State<CrudEdit> createState() => _CrudEditState<T, P>();
}

class _CrudEditState<T extends Firebaseable, P extends Iprovider>
    extends State<CrudEdit> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _submitForm(BuildContext context, T object) async {
    if (_formKey.currentState == null) {
      print('\nNull key');
      showSnackbar(context, 'formKey is null');
      return;
    }

    if (_formKey.currentState!.validate()) {
      print('\nValid form ${object.toJson()}');

      // Form is valid, process data
      await widget.onSave(object);

      print('\nValid form ${object.toJson()}');

      if (object.id.isEmpty) {
        await Provider.of<P>(context, listen: false).add(object);
      } else {
        await Provider.of<P>(context, listen: false).update(object);
      }
    } else {
      print('\nInvalid form');

      showSnackbar(context, 'Invalid form');
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ...widget.fields,
              ElevatedButton(
                onPressed: () async {
                  // Update the item with the new values

                  await _submitForm(context, widget.object as T);
                  // Call your update method here

                  //Navigator.pop(context);
                },
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ));
  }
}
