import 'package:backend_flutter_ivo/bo/_i_bo.dart';
import 'package:flutter/material.dart';

class RecipeStep implements BO {
  String? _id;
  int order;
  String content;
  int duration;

  RecipeStep(
    this._id, {
    required this.order,
    required this.content,
    required this.duration,
  });

  @override
  String get id => _id ?? '';

  factory RecipeStep.fromMap(Map<String, dynamic> json) {
    final recipe = RecipeStep(
      json['_id'] ?? '',
      order: json['order'] ?? -1,
      content: json['content'] ?? '',
      // recipeIngredients: [],
      duration: json['duration'] ?? -1,
    );

    return recipe;
  }

  factory RecipeStep.placeholder() {
    return RecipeStep(
      null,
      order: -1,
      content: '',
      duration: -1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'order': order,
      'content': content,
      'duration': duration,
    };
  }

  @override
  String showSubtitle() {
    return duration == -1 ? 'Durée non spécifié' : '${duration / 60} minutes';
  }

  @override
  String showTitle() {
    return content;
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
