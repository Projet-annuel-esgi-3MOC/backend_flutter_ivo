import 'package:backend_flutter_ivo/bo/_i_firebaseable.dart';
import 'package:backend_flutter_ivo/bo/ingredient.dart';
import 'package:backend_flutter_ivo/bo/recipe_ingredient.dart';
import 'package:backend_flutter_ivo/dal/providers/ingredient_provider.dart';
import 'package:backend_flutter_ivo/dal/providers/recipe_ingredient_provider.dart';
import 'package:backend_flutter_ivo/screens/crud/edit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipeIngredientEditWidget extends StatefulWidget {
  final RecipeIngredient object;

  const RecipeIngredientEditWidget({required this.object, Key? key})
      : super(key: key);

  @override
  State<RecipeIngredientEditWidget> createState() =>
      _RecipeIngredientEditWidgetState();
}

class _RecipeIngredientEditWidgetState
    extends State<RecipeIngredientEditWidget> {
  late TextEditingController _measureController;
  late List<Ingredient>
      _ingredientDropdownOptions; // Future for fetching options
  late Ingredient _selectedIngredient;

  Future<void> populateIngredientList() async {
    final IngredientProvider ingredientsProvider =
        context.watch<IngredientProvider>();

    List<Ingredient> ingredientDropdownOptions_ =
        await ingredientsProvider.getAll();

    setState(() {
      _ingredientDropdownOptions = ingredientDropdownOptions_;

      _selectedIngredient = _ingredientDropdownOptions.first;
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedIngredient = Ingredient('', name: '');
    _ingredientDropdownOptions = [_selectedIngredient];

    _measureController = TextEditingController(text: widget.object.mesure);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    populateIngredientList(); // Move the async operation here
  }

  void _updateObjectFromForm(Firebaseable ingredient) {
    // Form is valid, process data
    String? textValue = _measureController.text;
    (ingredient as RecipeIngredient).mesure = textValue;
  }

  @override
  Widget build(BuildContext context) {
    return CrudEdit<RecipeIngredient, RecipeIngredientProvider>(
      object: widget.object,
      fields: [
        DropdownButton<Ingredient>(
          value: _selectedIngredient,
          onChanged: (newValue) {
            setState(() {
              _selectedIngredient = newValue!;
            });
          },
          items: _ingredientDropdownOptions.map((item) {
            return DropdownMenuItem<Ingredient>(
              value: item,
              child: Text(item.name),
            );
          }).toList(),
        ),
        TextFormField(
          controller: _measureController,
          decoration: const InputDecoration(
            labelText: 'Measure',
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
      onSave: (Firebaseable i) => _updateObjectFromForm(i),
    );
  }
}
