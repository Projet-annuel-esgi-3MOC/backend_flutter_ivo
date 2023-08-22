import 'dart:convert';

import 'package:backend_flutter_ivo/bo/media.dart';
import 'package:backend_flutter_ivo/dal/generic_dao.dart';

final mediaAccess = Access<Media>(
  collectionName: 'media',
  instanceCreator: (s) => Media.fromMap(jsonDecode(s)),
  // I didnt find how to have an instance created without reflection
  // (dart:mirror) which seems to be unadvised to be used on flutter
  // because of poor performance, so I embed the creator as a callback
);
