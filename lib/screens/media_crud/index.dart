import 'package:backend_flutter_ivo/bo/_i_bo.dart';
import 'package:backend_flutter_ivo/bo/media.dart';
import 'package:backend_flutter_ivo/dal/providers/media_provider.dart';
import 'package:backend_flutter_ivo/screens/_fab_action.dart';
import 'package:backend_flutter_ivo/screens/crud/index.dart';
import 'package:backend_flutter_ivo/screens/media_crud/edit.dart';
import 'package:flutter/material.dart';

class MediaCrud extends StatelessWidget {
  final Function(FABAction) setFAB;
  const MediaCrud({required this.setFAB, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Crud<Media, MediaProvider>(
      newInstanceBuilder: () => Media.placeholder(),
      editWidget: (BO media) => MediaEditWidget(
        object: media as Media,
      ),
      setFAB: setFAB,
    );
  }
}
