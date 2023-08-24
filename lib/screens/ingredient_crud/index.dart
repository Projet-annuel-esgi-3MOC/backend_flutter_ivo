import 'package:backend_flutter_ivo/bo/_i_bo.dart';
import 'package:backend_flutter_ivo/bo/ingredient.dart';
import 'package:backend_flutter_ivo/dal/providers/ingredient_provider.dart';
import 'package:backend_flutter_ivo/screens/_fab_action.dart';
import 'package:backend_flutter_ivo/screens/crud/index.dart';
import 'package:backend_flutter_ivo/screens/ingredient_crud/edit.dart';
import 'package:flutter/material.dart';

class IngredientCrud extends StatelessWidget {
  final Function(FABAction) setFAB;
  const IngredientCrud({required this.setFAB, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Crud<Ingredient, IngredientProvider>(
      newInstanceBuilder: () => Ingredient.placeholder(),
      editWidget: (BO ingredient) => IngredientEditWidget(
        object: ingredient as Ingredient,
      ),
      setFAB: setFAB,
    );
  }
}
