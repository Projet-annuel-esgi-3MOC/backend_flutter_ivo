import 'package:backend_flutter_ivo/bo/_i_bo.dart';
import 'package:backend_flutter_ivo/bo/_i_firebaseable.dart';
import 'package:backend_flutter_ivo/bo/recipe_step.dart';
import 'package:backend_flutter_ivo/dal/providers/recipe_step_provider.dart';
import 'package:backend_flutter_ivo/screens/_fab_action.dart';
import 'package:backend_flutter_ivo/screens/crud/edit.dart';
import 'package:backend_flutter_ivo/screens/crud/index.dart';
import 'package:flutter/material.dart';

class RecipeStepCrud extends StatelessWidget {
  final Function(FABAction) setFAB;
  const RecipeStepCrud({required this.setFAB, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Crud<RecipeStep, RecipeStepProvider>(
      newInstanceBuilder: () => RecipeStep.placeholder(),
      editWidget: (BO recipeStep) => RecipeStepEditWidget(
        object: recipeStep as RecipeStep,
      ),
      setFAB: setFAB,
    );
  }
}

class RecipeStepEditWidget extends StatefulWidget {
  final RecipeStep object;

  const RecipeStepEditWidget({required this.object, Key? key})
      : super(key: key);

  @override
  State<RecipeStepEditWidget> createState() => _IngredientEditWidgetState();
}

class _IngredientEditWidgetState extends State<RecipeStepEditWidget> {
  late TextEditingController _contentController;
  late TextEditingController _orderController;
  late TextEditingController _durationController;

  @override
  void initState() {
    super.initState();

    _contentController = TextEditingController(text: widget.object.content);
    _orderController =
        TextEditingController(text: widget.object.order.toString());
    _durationController =
        TextEditingController(text: widget.object.duration.toString());
  }

  Future<void> _updateObjectFromForm(Firebaseable recipeStep) async {
    // Form is valid, process data
    String? textValue = _contentController.text;
    (recipeStep as RecipeStep).content = textValue;
    recipeStep.order = int.tryParse(_orderController.text) ?? -1;
    recipeStep.duration = int.tryParse(_durationController.text) ?? -1;
  }

  @override
  Widget build(BuildContext context) {
    return CrudEdit<RecipeStep, RecipeStepProvider>(
      object: widget.object,
      fields: [
        TextFormField(
          controller: _contentController,
          decoration: const InputDecoration(
            labelText: 'Content',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          controller: _orderController,
          decoration: const InputDecoration(
            labelText: 'Order',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          controller: _durationController,
          decoration: const InputDecoration(
            labelText: 'Duration (minutes)',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16.0),
      ],
      onSave: (Firebaseable i) => _updateObjectFromForm(i),
    );
  }
}
