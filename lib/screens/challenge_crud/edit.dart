import 'package:backend_flutter_ivo/bo/_i_firebaseable.dart';
import 'package:backend_flutter_ivo/bo/challenge.dart';
import 'package:backend_flutter_ivo/bo/recipe.dart';
import 'package:backend_flutter_ivo/dal/providers/challenge_provider.dart';
import 'package:backend_flutter_ivo/screens/crud/edit.dart';
import 'package:backend_flutter_ivo/widgets/recipe_dropdown.dart';
import 'package:flutter/material.dart';

class ChallengeEditWidget extends StatefulWidget {
  final Challenge object;

  const ChallengeEditWidget({required this.object, Key? key}) : super(key: key);

  @override
  State<ChallengeEditWidget> createState() => _ChallengeEditWidgetState();
}

class _ChallengeEditWidgetState extends State<ChallengeEditWidget> {
  late TextEditingController _maxParticipantsController;
  late Recipe _recipe;

  @override
  void initState() {
    super.initState();

    _recipe = widget.object.recipe;
    _maxParticipantsController =
        TextEditingController(text: widget.object.maxParticipants.toString());
  }

  void setRecipe(Recipe recipe) {
    _recipe = recipe;
  }

  Future<void> _updateObjectFromForm(Firebaseable ingredient) async {
    // Form is valid, process data
    (ingredient as Challenge).maxParticipants =
        int.tryParse(_maxParticipantsController.text) ?? 0;
    ingredient.recipe = _recipe;
  }

  @override
  Widget build(BuildContext context) {
    return CrudEdit<Challenge, ChallengeProvider>(
      object: widget.object,
      fields: [
        TextFormField(
          controller: _maxParticipantsController,
          decoration: const InputDecoration(
            labelText: 'Max participants',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 16.0),
        RecipeDropDown(
          setRecipe: setRecipe,
          getInitialRecipe: () => widget.object.recipe,
        ),
      ],
      onSave: (Firebaseable i) => _updateObjectFromForm(i),
    );
  }
}
