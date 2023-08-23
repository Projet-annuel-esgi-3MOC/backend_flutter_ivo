import 'dart:convert';

import 'package:backend_flutter_ivo/bo/_i_bo.dart';
import 'package:backend_flutter_ivo/bo/media_category.dart';

class Media implements BO {
  String? _id;
  String filename;
  late String base64payload;
  String mimeType;
  Set<MediaCategory> categories = {};

  Media(this._id, {required this.filename, required this.mimeType});

  @override
  String get id => _id ?? '';

  factory Media.fromMap(Map<String, dynamic> json) {
    return Media(
      json['_id'] ?? '',
      filename: json['filename'] ?? '',
      mimeType: json['mimeType'] ?? '',
    );
  }

  @override
  String toJson() {
    return jsonEncode({
      '_id': id,
      'filename': filename,
      'mimeType': mimeType,
      'base64payload': base64payload,
      'mediaCategories': categories,
    });
  }

  @override
  String toCreateJson() {
    print(
      'toCreatejson $filename $mimeType ${base64payload.substring(0, 50)}... $categories',
    );
    return jsonEncode({
      'filename': filename,
      'mimeType': mimeType,
      'base64payload': base64payload,
      'mediaCategories': categories.toList(),
    });
  }

  @override
  String showSubtitle() {
    return '';
  }

  @override
  String showTitle() {
    return filename;
  }
}
