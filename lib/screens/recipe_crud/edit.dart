import 'package:backend_flutter_ivo/bo/_i_firebaseable.dart';
import 'package:backend_flutter_ivo/bo/media.dart';
import 'package:backend_flutter_ivo/bo/recipe.dart';
import 'package:backend_flutter_ivo/bo/recipe_ingredient.dart';
import 'package:backend_flutter_ivo/dal/providers/recipe_ingredient_provider.dart';
import 'package:backend_flutter_ivo/dal/providers/recipe_provider.dart';
import 'package:backend_flutter_ivo/screens/crud/edit.dart';
import 'package:backend_flutter_ivo/widgets/media_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';

class RecipeEditWidget extends StatefulWidget {
  final Recipe object;

  const RecipeEditWidget({required this.object, Key? key}) : super(key: key);

  @override
  State<RecipeEditWidget> createState() => _RecipeEditWidgetState();
}

class _RecipeEditWidgetState extends State<RecipeEditWidget> {
  late TextEditingController _nameController;
  late TextEditingController _difficultyController;
  late List<RecipeIngredient> _ingredientDropdownOptions;
  late List<RecipeIngredient> _selectedRecipeIngredients;
  late Media _image;

  Future<void> populateIngredientList() async {
    final RecipeIngredientProvider ingredientsProvider =
        context.watch<RecipeIngredientProvider>();

    List<RecipeIngredient> ingredientDropdownOptions_ =
        await ingredientsProvider.getAll();

    setState(() {
      _ingredientDropdownOptions = ingredientDropdownOptions_;

      _selectedRecipeIngredients = [];
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedRecipeIngredients = [];
    _ingredientDropdownOptions = [];

    _nameController = TextEditingController(text: widget.object.name);
    _difficultyController =
        TextEditingController(text: widget.object.difficulty);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    populateIngredientList(); // Move the async operation here
  }

  Future<void> _updateObjectFromForm(Firebaseable recipeIngredient) async {
    // Form is valid, process data
    (recipeIngredient as Recipe).name = _nameController.text;
    recipeIngredient.difficulty = _difficultyController.text;
    recipeIngredient.recipeIngredients = _selectedRecipeIngredients;
    recipeIngredient.image = _image;
  }

  void setImage(Media media) {
    _image = media;
  }

  List<MultiSelectItem<Object?>> _msiItems(
      List<RecipeIngredient> ingredientDropdownOptions) {
    return ingredientDropdownOptions
        .map((recipeIngredient) => MultiSelectItem<RecipeIngredient>(
            recipeIngredient,
            '${recipeIngredient.mesure} of ${recipeIngredient.ingredient.name}'))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return CrudEdit<Recipe, RecipeProvider>(
      object: widget.object,
      fields: [
        TextFormField(
          controller: _nameController,
          decoration: const InputDecoration(
            labelText: 'Name',
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
        MultiSelectDialogField(
          items: _msiItems(_ingredientDropdownOptions),
          title: const Text("Ingredients"),
          selectedColor: Colors.blue,
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: const BorderRadius.all(Radius.circular(40)),
            border: Border.all(
              color: Colors.blue,
              width: 2,
            ),
          ),
          buttonIcon: const Icon(
            Icons.soup_kitchen,
            color: Colors.blue,
          ),
          buttonText: Text(
            "Ingredients",
            style: TextStyle(
              color: Colors.blue[800],
              fontSize: 16,
            ),
          ),
          onConfirm: (results) {
            //_selectedAnimals = results;
          },
        ),
        const SizedBox(height: 16.0),
        MediaDropDown(
          setMedia: setImage,
          getInitialMedia: () => widget.object.image,
        ),
      ],
      onSave: (Firebaseable i) => _updateObjectFromForm(i),
    );
  }
}
