import 'package:flutter/material.dart';

class FABAction {
  final void Function(List<dynamic>) function;
  final List<dynamic> parameters;

  FABAction({required this.function, required this.parameters});
}

abstract class HasFab {
  List<Widget> myFabs();
}
