import 'dart:convert';

import 'package:backend_flutter_ivo/bo/_i_bo.dart';
import 'package:flutter/material.dart';

class MediaCategory implements BO {
  String? _id;
  String name;

  MediaCategory(
    this._id,
    this.name,
  );

  @override
  String get id => _id ?? '';

  factory MediaCategory.fromMap(Map<String, dynamic> json) {
    return MediaCategory(json['_id'] ?? '', json['name'] ?? '');
  }

  factory MediaCategory.placeholder() {
    return MediaCategory('', '');
  }

  @override
  String toJson() {
    return jsonEncode({
      '_id': id,
      'name': name,
    });
  }

  @override
  String toCreateJson() {
    return jsonEncode({
      'name': name,
    });
  }

  @override
  String showSubtitle() {
    return name;
  }

  @override
  String showTitle() {
    return '';
  }

  @override
  Widget tileSubtitle() {
    return Text(showSubtitle());
  }

  @override
  Widget tileTitle() {
    return Text(showTitle());
  }
}
