import 'dart:convert';

import 'package:backend_flutter_ivo/bo/_i_bo.dart';
import 'package:backend_flutter_ivo/bo/ingredient.dart';
import 'package:flutter/src/widgets/framework.dart';

class RecipeIngredient implements BO {
  String? _id;
  Ingredient ingredient;
  String mesure;

  RecipeIngredient(
    this._id, {
    required this.ingredient,
    required this.mesure,
  });

  @override
  String get id => _id ?? '';

  factory RecipeIngredient.fromMap(Map<String, dynamic> json) {
    return RecipeIngredient(json['_id'] ?? '',
        mesure: json['mesure'] ?? '',
        ingredient: Ingredient.fromMap(jsonDecode(json['ingredient'])));
  }

  factory RecipeIngredient.placeholder() {
    return RecipeIngredient(
      '',
      ingredient: Ingredient.placeholder(),
      mesure: '',
    );
  }

  @override
  String toJson() {
    return jsonEncode({
      '_id': id,
      'mesure': mesure,
      'ingredient': ingredient,
    });
  }

  @override
  String toCreateJson() {
    return jsonEncode({'mesure': mesure, 'ingredient': ingredient});
  }

  @override
  String showSubtitle() {
    return mesure;
  }

  @override
  String showTitle() {
    return ingredient.name;
  }

  @override
  Widget tileSubtitle() {
    // TODO: implement tileSubtitle
    throw UnimplementedError();
  }

  @override
  Widget tileTitle() {
    // TODO: implement tileTitle
    throw UnimplementedError();
  }
}
