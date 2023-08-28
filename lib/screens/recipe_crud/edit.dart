import 'package:backend_flutter_ivo/bo/_i_firebaseable.dart';
import 'package:backend_flutter_ivo/bo/media.dart';
import 'package:backend_flutter_ivo/bo/recipe.dart';
import 'package:backend_flutter_ivo/bo/recipe_ingredient.dart';
import 'package:backend_flutter_ivo/bo/recipe_step.dart';
import 'package:backend_flutter_ivo/dal/providers/recipe_ingredient_provider.dart';
import 'package:backend_flutter_ivo/dal/providers/recipe_provider.dart';
import 'package:backend_flutter_ivo/dal/providers/recipe_step_provider.dart';
import 'package:backend_flutter_ivo/screens/crud/edit.dart';
import 'package:backend_flutter_ivo/widgets/media_dropdown.dart';
import 'package:backend_flutter_ivo/widgets/multiselect_widget.dart';
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
  late TextEditingController _descriptionController;
  late TextEditingController _timeToCookController;
  late TextEditingController _timeToPrepareController;
  late List<RecipeIngredient> _ingredientDropdownOptions;
  late List<RecipeIngredient> _selectedRecipeIngredients;
  late List<RecipeStep> _selectedRecipeSteps;
  late Media _image;

  Future<void> populateIngredientList() async {
    final RecipeIngredientProvider ingredientsProvider =
        context.watch<RecipeIngredientProvider>();

    List<RecipeIngredient> ingredientDropdownOptions_ =
        await ingredientsProvider.getAll();

    setState(() {
      _ingredientDropdownOptions = ingredientDropdownOptions_;
    });
  }

  void setRecipeSteps(List<RecipeStep> steps) {
    print('onSave $steps');
    _selectedRecipeSteps = steps;
  }

  @override
  void initState() {
    super.initState();
    _selectedRecipeIngredients = widget.object.recipeIngredients;
    _ingredientDropdownOptions = [];

    _selectedRecipeSteps = widget.object.recipeSteps;

    _image = widget.object.image;
    _timeToCookController =
        TextEditingController(text: widget.object.timeToCook);
    _timeToPrepareController =
        TextEditingController(text: widget.object.timeToPrepare);
    _descriptionController =
        TextEditingController(text: widget.object.description);

    _nameController = TextEditingController(text: widget.object.name);
    _difficultyController =
        TextEditingController(text: widget.object.difficulty);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    populateIngredientList(); // Move the async operation here
  }

  Future<void> _updateObjectFromForm(Firebaseable recipe) async {
    // Form is valid, process data
    (recipe as Recipe).name = _nameController.text;
    print('\nFOOO ${recipe.toJson()}');

    recipe.difficulty = _difficultyController.text;
    recipe.recipeIngredients = _selectedRecipeIngredients;
    recipe.recipeSteps = _selectedRecipeSteps;
    recipe.image = _image;
    recipe.description = _descriptionController.text;
    recipe.timeToCook = _timeToCookController.text;
    recipe.timeToPrepare = _timeToPrepareController.text;
    print('\nFOOOoo ${recipe.toJson()}');
  }

  void setImage(Media media) {
    _image = media;
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
        TextFormField(
          controller: _descriptionController,
          maxLines: null,
          decoration: const InputDecoration(
            labelText: 'Description',
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
        TextFormField(
          controller: _difficultyController,
          decoration: const InputDecoration(
            labelText: 'Difficulty',
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
        TextFormField(
          controller: _timeToCookController,
          decoration: const InputDecoration(
            labelText: 'Time to cook',
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
        TextFormField(
          controller: _timeToPrepareController,
          decoration: const InputDecoration(
            labelText: 'Time to prepare',
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
        MultiSelectDialogField<RecipeIngredient>(
          items: _ingredientDropdownOptions
              .map(
                (recipeIngredient) => MultiSelectItem<RecipeIngredient>(
                  recipeIngredient,
                  '${recipeIngredient.mesure} of ${recipeIngredient.ingredient.name}',
                ),
              )
              .toList(),
          initialValue: widget.object.recipeIngredients,
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
            _selectedRecipeIngredients = results;
          },
          //onSelectionChanged: (p0) => 0,
        ),
        const SizedBox(height: 16.0),
        MultiselectRecipeStep<RecipeStep, RecipeStepProvider>(
          elements: _selectedRecipeSteps,
          onSave: setRecipeSteps,
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
