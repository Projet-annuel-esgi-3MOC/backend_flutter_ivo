import 'package:backend_flutter_ivo/bo/recipe.dart';
import 'package:backend_flutter_ivo/dal/generic_dao.dart';
import 'package:backend_flutter_ivo/dal/providers/_crud_provider.dart';

class RecipeProvider extends CrudProvider<Recipe> {
  RecipeProvider()
      : super(
          accesser_: Access<Recipe>(
            collectionName: 'recipe',
            instanceCreator: (s) => Recipe.fromMap(s),
          ),
        );
}
