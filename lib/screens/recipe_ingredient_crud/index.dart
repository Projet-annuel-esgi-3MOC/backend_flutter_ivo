import 'package:backend_flutter_ivo/bo/_i_bo.dart';
import 'package:backend_flutter_ivo/bo/ingredient.dart';
import 'package:backend_flutter_ivo/bo/recipe_ingredient.dart';
import 'package:backend_flutter_ivo/dal/providers/recipe_ingredient_provider.dart';
import 'package:backend_flutter_ivo/screens/_fab_action.dart';
import 'package:backend_flutter_ivo/screens/crud/index.dart';
import 'package:backend_flutter_ivo/screens/recipe_ingredient_crud/edit.dart';
import 'package:flutter/material.dart';

class RecipeIngredientCrud extends StatelessWidget {
  final Function(FABAction) setFAB;
  const RecipeIngredientCrud({required this.setFAB, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Crud<RecipeIngredient, RecipeIngredientProvider>(
      newInstanceBuilder: () => RecipeIngredient(null,
          ingredient: Ingredient(
            '',
            name: '',
          ),
          mesure: ''),
      editWidget: (BO recipeIngredient) => RecipeIngredientEditWidget(
        object: recipeIngredient as RecipeIngredient,
      ),
      setFAB: setFAB,
    );
  }
}
