import 'package:backend_flutter_ivo/bo/media_category.dart';
import 'package:backend_flutter_ivo/dal/generic_dao.dart';
import 'package:backend_flutter_ivo/dal/providers/_crud_provider.dart';

class MediaCategoryProvider extends CrudProvider<MediaCategory> {
  MediaCategoryProvider()
      : super(
          accesser_: Access<MediaCategory>(
            collectionName: 'media-category',
            instanceCreator: (s) => MediaCategory.fromMap(s),
          ),
        );
}
