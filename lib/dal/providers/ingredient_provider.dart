import 'package:backend_flutter_ivo/bo/ingredient.dart';
import 'package:backend_flutter_ivo/dal/generic_dao.dart';
import 'package:backend_flutter_ivo/dal/providers/_crud_provider.dart';

class IngredientProvider extends CrudProvider<Ingredient> {
  IngredientProvider()
      : super(
          accesser_: Access<Ingredient>(
            collectionName: 'ingredient',
            instanceCreator: (s) => Ingredient.fromMap(s),
          ),
        );
}
