import 'dart:convert';

import 'package:backend_flutter_ivo/bo/_i_bo.dart';
import 'package:backend_flutter_ivo/bo/media.dart';
import 'package:backend_flutter_ivo/bo/recipe_ingredient.dart';
import 'package:flutter/material.dart';

class Recipe implements BO {
  String? _id;
  String name;
  String difficulty;
  List<RecipeIngredient> recipeIngredients;
  Media image;

  Recipe(
    this._id, {
    required this.name,
    required this.difficulty,
    required this.recipeIngredients,
    required this.image,
  });

  @override
  String get id => _id ?? '';

  factory Recipe.fromMap(Map<String, dynamic> json) {
    print('\nMap: $json');
    final recipe = Recipe(
      json['_id'] ?? '',
      name: json['name'] ?? '',
      // recipeIngredients: [],
      recipeIngredients: (json['recipeIngredients'] as List<dynamic>)
          .map((e) => RecipeIngredient.fromMap(jsonDecode(e)))
          .toList(),
      difficulty: json['difficulty'] ?? '',
      image: Media.fromMap(
        jsonDecode(json['image']),
      ),
    );

    return recipe;
  }

  factory Recipe.placeholder() {
    return Recipe(
      null,
      name: '',
      difficulty: '',
      image: Media.placeholder(),
      recipeIngredients: [],
    );
  }

  @override
  String toJson() {
    return jsonEncode({
      '_id': id,
      'name': name,
      'difficulty': difficulty,
      'recipeIngredients': recipeIngredients,
      'image': image
    });
  }

  @override
  String toCreateJson() {
    return jsonEncode({
      'name': name,
      'difficulty': difficulty,
      'recipeIngredients': recipeIngredients,
      'image': image
    });
  }

  @override
  String showSubtitle() {
    return difficulty;
  }

  @override
  String showTitle() {
    return name;
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
