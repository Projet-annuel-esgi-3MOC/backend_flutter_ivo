import 'package:backend_flutter_ivo/bo/ingredient.dart';
import 'package:backend_flutter_ivo/bo/media.dart';
import 'package:backend_flutter_ivo/dal/providers/ingredient_provider.dart';
import 'package:backend_flutter_ivo/screens/crud/edit.dart';
import 'package:backend_flutter_ivo/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IngredientEditWidget extends StatefulWidget {
  final Ingredient object;

  const IngredientEditWidget({required this.object, Key? key})
      : super(key: key);

  @override
  State<IngredientEditWidget> createState() => _MediaEditWidgetState();
}

class _MediaEditWidgetState extends State<IngredientEditWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: widget.object.name);
  }

  Future<void> _submitForm(BuildContext context, Ingredient ingredient) async {
    if (_formKey.currentState == null) {
      showSnackbar(context, 'formKey is null');
      return;
    }

    if (_formKey.currentState!.validate()) {
      // Form is valid, process data
      String? textValue = _nameController.text;

      ingredient.name = textValue;
      if (ingredient.id.isEmpty) {
        await Provider.of<IngredientProvider>(context, listen: false)
            .add(ingredient);
      } else {
        await Provider.of<IngredientProvider>(context, listen: false)
            .update(ingredient);
      }

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: CrudEdit<Media>(
        fields: [
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Title',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
        ],
        onSave: () => _submitForm(context, widget.object),
      ),
    );
  }
}
