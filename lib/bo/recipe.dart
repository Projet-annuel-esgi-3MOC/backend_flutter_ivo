import 'dart:convert';

import 'package:backend_flutter_ivo/bo/_i_bo.dart';
import 'package:backend_flutter_ivo/bo/media.dart';
import 'package:backend_flutter_ivo/bo/recipe_ingredient.dart';

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
    return Recipe(
      json['_id'] ?? '',
      name: json['name'] ?? '',
      recipeIngredients:
          (jsonDecode(json['recipeIngredients']) as List<Map<String, dynamic>>)
              .map(
                (e) => RecipeIngredient.fromMap(e),
              )
              .toList(),
      difficulty: json['difficulty'] ?? '',
      image: Media.fromMap(
        jsonDecode(json['image']),
      ),
    );
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
      'recipeIngredients': jsonEncode(recipeIngredients),
      'image': jsonEncode(image)
    });
  }

  @override
  String toCreateJson() {
    return jsonEncode({
      'name': name,
      'difficulty': difficulty,
      'recipeIngredients': jsonEncode(recipeIngredients),
      'image': jsonEncode(image)
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
}
