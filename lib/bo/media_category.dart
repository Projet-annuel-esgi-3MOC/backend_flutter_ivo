import 'dart:convert';

import 'package:flutter/material.dart';

class MediaCategory {
  String? _id;
  String title;
  String subtitle;

  MediaCategory(this._id, this.title, this.subtitle);

  String get id => _id ?? '';

  factory MediaCategory.fromMap(Map<String, dynamic> json) {
    return MediaCategory(
        json['_id'] ?? '', json['title'] ?? '', json['subtitle'] ?? '');
  }

  String toJson() {
    return jsonEncode({
      '_id': id,
      'title': title,
      'subtitle': subtitle,
    });
  }
}
