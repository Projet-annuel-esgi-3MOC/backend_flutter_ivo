import 'package:backend_flutter_ivo/bo/recipe_step.dart';
import 'package:backend_flutter_ivo/dal/generic_dao.dart';
import 'package:backend_flutter_ivo/dal/providers/_crud_provider.dart';

class RecipeStepProvider extends CrudProvider<RecipeStep> {
  RecipeStepProvider()
      : super(
          accesser_: Access<RecipeStep>(
            collectionName: 'recipe-step',
            instanceCreator: (s) => RecipeStep.fromMap(s),
          ),
        );
}
