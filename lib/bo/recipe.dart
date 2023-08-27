import 'dart:convert';

import 'package:backend_flutter_ivo/bo/_i_bo.dart';
import 'package:backend_flutter_ivo/bo/media.dart';
import 'package:backend_flutter_ivo/bo/recipe_ingredient.dart';
import 'package:flutter/material.dart';

class Recipe implements BO {
  String? _id;
  String name;
  String description;
  String difficulty;
  List<RecipeIngredient> recipeIngredients;
  Media image;
  String timeToCook;
  String timeToPrepare;

  Recipe(
    this._id, {
    required this.name,
    required this.description,
    required this.difficulty,
    required this.recipeIngredients,
    required this.image,
    required this.timeToCook,
    required this.timeToPrepare,
  });

  @override
  String get id => _id ?? '';

  factory Recipe.fromMap(Map<String, dynamic> json) {
    final recipe = Recipe(
      json['_id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      // recipeIngredients: [],
      recipeIngredients: (json['recipeIngredients'] as List<dynamic>)
          .map((e) => RecipeIngredient.fromMap(jsonDecode(e)))
          .toList(),
      difficulty: json['difficulty'] ?? '',
      image: Media.fromMap(
        jsonDecode(json['image']),
      ),
      timeToCook: json['timeToCook'] ?? '',
      timeToPrepare: json['timeToPrepare'] ?? '',
    );

    return recipe;
  }

  factory Recipe.placeholder() {
    return Recipe(
      null,
      name: '',
      description: '',
      difficulty: '',
      image: Media.placeholder(),
      recipeIngredients: [],
      timeToCook: '',
      timeToPrepare: '',
    );
  }

  @override
  String toJson() {
    return jsonEncode({
      '_id': id,
      'name': name,
      'description': description,
      'difficulty': difficulty,
      'recipeIngredients': recipeIngredients,
      'image': image,
      'timeToCook': timeToCook,
      'timeToPrepare': timeToPrepare,
    });
  }

  @override
  String toCreateJson() {
    return jsonEncode({
      'name': name,
      'description': description,
      'difficulty': difficulty,
      'recipeIngredients': recipeIngredients,
      'image': image,
      'timeToCook': timeToCook,
      'timeToPrepare': timeToPrepare,
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
