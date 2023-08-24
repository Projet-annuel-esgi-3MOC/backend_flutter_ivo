import 'package:backend_flutter_ivo/bo/_i_bo.dart';
import 'package:backend_flutter_ivo/bo/media.dart';
import 'package:backend_flutter_ivo/bo/recipe.dart';
import 'package:backend_flutter_ivo/dal/providers/recipe_provider.dart';
import 'package:backend_flutter_ivo/screens/_fab_action.dart';
import 'package:backend_flutter_ivo/screens/crud/index.dart';
import 'package:backend_flutter_ivo/screens/recipe_crud/edit.dart';
import 'package:flutter/material.dart';

class RecipeCrud extends StatelessWidget {
  final Function(FABAction) setFAB;
  const RecipeCrud({required this.setFAB, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Crud<Recipe, RecipeProvider>(
      newInstanceBuilder: () => Recipe.placeholder(),
      editWidget: (BO recipe) => RecipeEditWidget(
        object: recipe as Recipe,
      ),
      setFAB: setFAB,
    );
  }
}
