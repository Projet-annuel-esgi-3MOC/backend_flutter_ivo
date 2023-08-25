import 'dart:convert';

import 'package:backend_flutter_ivo/bo/_i_bo.dart';
import 'package:backend_flutter_ivo/bo/media.dart';
import 'package:flutter/material.dart';

class Ingredient implements BO {
  String? _id;
  String name;
  Media image;

  Ingredient(
    this._id, {
    required this.name,
    required this.image,
  });

  @override
  String get id => _id ?? '';

  factory Ingredient.fromMap(Map<String, dynamic> json) {
    return Ingredient(
      json['_id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
    );
  }

  @override
  String toJson() {
    return jsonEncode({
      '_id': id,
      'name': name,
      'image': image,
    });
  }

  @override
  String toCreateJson() {
    return jsonEncode({
      'name': name,
      'image': image,
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
  factory Ingredient.placeholder() {
    return Ingredient('', name: '', image: Media.placeholder());
  }

  @override
  Widget tileSubtitle() {
    return Text(showSubtitle());
  }

  @override
  Widget tileTitle() {
    return Row(children: [
      Image.network(image.accessUrl),
      const SizedBox(
        height: 16,
      ),
      Text(name),
    ]);
  }
}
