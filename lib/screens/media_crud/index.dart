import 'package:backend_flutter_ivo/bo/media.dart';
import 'package:backend_flutter_ivo/dal/_abst_dao.dart';
import 'package:backend_flutter_ivo/dal/generic_dao.dart';
import 'package:backend_flutter_ivo/screens/crud/index.dart';
import 'package:backend_flutter_ivo/screens/media_crud/edit.dart';
import 'package:flutter/material.dart';

class MediaIndexCrud extends StatelessWidget {
  const MediaIndexCrud({super.key});

  @override
  Widget build(BuildContext context) {
    return Crud(
      newInstanceBuilder: () => Media(null, publicName: ''),
      accessor: Access<Media>(
        instanceCreator: (p0) => Media(null, publicName: ''),
        collectionName: 'media',
      ),
      editWidget: MediaEditWidget(),
    );
  }
}
