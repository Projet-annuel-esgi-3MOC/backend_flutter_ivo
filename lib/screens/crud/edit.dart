import 'package:backend_flutter_ivo/bo/_i_bo.dart';
import 'package:backend_flutter_ivo/dal/providers/_crud_provider.dart';
import 'package:backend_flutter_ivo/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CrudEdit<T extends BO, P extends CrudProvider<T>> extends StatefulWidget {
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

class _CrudEditState<T extends BO, P extends CrudProvider<T>>
    extends State<CrudEdit> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _submitForm(BuildContext context, T object) async {
    final provider = Provider.of<P>(context, listen: false);

    if (_formKey.currentState == null) {
      showSnackbar(context, 'formKey is null');
      return;
    }

    if (_formKey.currentState!.validate()) {
      // Form is valid, process data
      await widget.onSave(object);

      if (object.id.isEmpty) {
        await provider.add(object);
      } else {
        await provider.update(object);
      }
    } else {
      showSnackbar(context, 'Invalid form');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ...widget.fields,
              ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  await _submitForm(context, widget.object as T);
                },
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
