import 'package:flutter/material.dart';

abstract class ListTileable {
  String showTitle();
  String showSubtitle();
  Widget tileTitle();
  Widget tileSubtitle();
}
