import 'package:backend_flutter_ivo/bo/_i_firebaseable.dart';
import 'package:backend_flutter_ivo/bo/ingredient.dart';
import 'package:backend_flutter_ivo/bo/media.dart';
import 'package:backend_flutter_ivo/dal/providers/ingredient_provider.dart';
import 'package:backend_flutter_ivo/screens/crud/edit.dart';
import 'package:backend_flutter_ivo/widgets/media_dropdown.dart';
import 'package:flutter/material.dart';

class IngredientEditWidget extends StatefulWidget {
  final Ingredient object;

  const IngredientEditWidget({required this.object, Key? key})
      : super(key: key);

  @override
  State<IngredientEditWidget> createState() => _IngredientEditWidgetState();
}

class _IngredientEditWidgetState extends State<IngredientEditWidget> {
  late TextEditingController _nameController;
  late Media _image;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: widget.object.name);
  }

  void setImage(Media media) {
    _image = media;
  }

  Future<void> _updateObjectFromForm(Firebaseable ingredient) async {
    // Form is valid, process data
    String? textValue = _nameController.text;
    (ingredient as Ingredient).name = textValue;
    ingredient.image = _image;
  }

  @override
  Widget build(BuildContext context) {
    return CrudEdit<Ingredient, IngredientProvider>(
      object: widget.object,
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
        MediaDropDown(
          setMedia: setImage,
        ),
      ],
      onSave: (Firebaseable i) => _updateObjectFromForm(i),
    );
  }
}
