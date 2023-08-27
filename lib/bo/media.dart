import 'dart:convert';

import 'package:backend_flutter_ivo/bo/_i_bo.dart';
import 'package:backend_flutter_ivo/bo/media_category.dart';
import 'package:flutter/material.dart';

class Media implements BO {
  String? _id;
  String filename;
  String base64payload;
  String mimeType;
  Set<MediaCategory> categories = {};
  String accessUrl;

  Media(
    this._id, {
    required this.filename,
    required this.mimeType,
    required this.accessUrl,
    required this.base64payload,
  });

  @override
  String get id => _id ?? '';

  factory Media.fromMap(Map<String, dynamic> json) {
    return Media(
      json['_id'] ?? '',
      filename: json['filename'] ?? '',
      mimeType: json['mimeType'] ?? '',
      accessUrl: json['accessUrl'] ?? '',
      base64payload: '',
    );
  }

  factory Media.placeholder() {
    return Media(
      '',
      filename: '',
      mimeType: '',
      accessUrl: '',
      base64payload: '',
    );
  }

  // @override
  // String toJson() {
  //   return jsonEncode({
  //     '_id': id,
  //     'filename': filename,
  //     'mimeType': mimeType,
  //     'base64payload': base64payload,
  //     'mediaCategories': categories.toList(),
  //     'accessUrl': accessUrl,
  //   });
  // }

  // @override
  // String toCreateJson() {
  //   return jsonEncode({
  //     'filename': filename,
  //     'mimeType': mimeType,
  //     'base64payload': base64payload,
  //     'mediaCategories': categories.toList(),
  //   });
  // }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'filename': filename,
      'mimeType': mimeType,
      'base64payload': base64payload,
      'mediaCategories': categories.toList(),
      'accessUrl': accessUrl,
    };
  }

  @override
  String showSubtitle() {
    return '';
  }

  @override
  String showTitle() {
    return filename;
  }

  @override
  Widget tileSubtitle() {
    return Text(showSubtitle());
  }

  @override
  Widget tileTitle() {
    return Row(
      children: [
        Image.network(
          accessUrl,
          height: 50,
        ),
        const SizedBox(
          width: 16,
        ),
        Text(showTitle())
      ],
    );
  }
}
