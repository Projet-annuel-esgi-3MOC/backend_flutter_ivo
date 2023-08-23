import 'package:flutter/material.dart';

abstract class OnSaveWidget extends Widget {
  final Function setOnCrudSaveCallback;

  const OnSaveWidget({required this.setOnCrudSaveCallback, Key? key})
      : super(key: key);

  Future<void> onSave(BuildContext context);
  OnSaveWidget make(Function setOnCrudSaveCallback) {
    throw UnimplementedError('Implement make');
  }
}
