import 'dart:convert';

import 'package:backend_flutter_ivo/bo/_i_bo.dart';
import 'package:backend_flutter_ivo/bo/media_category.dart';

class Media implements BO {
  String? _id;
  String publicName;
  late String payload;
  Set<MediaCategory> categories = {};

  Media(this._id, {required this.publicName});

  String get id => _id ?? '';

  factory Media.fromMap(Map<String, dynamic> json) {
    return Media(json['_id'] ?? '', publicName: json['publicName'] ?? '');
  }

  @override
  String toJson() {
    return jsonEncode({
      '_id': id,
      'title': publicName,
      'payload': publicName,
      'categories': categories,
    });
  }

  @override
  String showSubtitle() {
    return publicName;
  }

  @override
  String showTitle() {
    return '';
  }
}
