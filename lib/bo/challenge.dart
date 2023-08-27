import 'package:backend_flutter_ivo/bo/_i_bo.dart';
import 'package:backend_flutter_ivo/bo/recipe.dart';
import 'package:flutter/material.dart';

class Challenge implements BO {
  String? _id;
  Recipe recipe;
  int maxParticipants;

  Challenge(
    this._id, {
    required this.recipe,
    required this.maxParticipants,
  });

  @override
  String get id => _id ?? '';

  factory Challenge.fromMap(Map<String, dynamic> json) {
    return Challenge(
      json['_id'] ?? '',
      recipe: Recipe.fromMap(json['recipe']),
      maxParticipants: json['maxParticipants'] ?? 4,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'recipe': recipe.toJson(),
      'maxParticipants': maxParticipants,
    };
  }

  @override
  String showSubtitle() {
    return '0/$maxParticipants';
  }

  @override
  String showTitle() {
    return recipe.name;
  }

  @override
  factory Challenge.placeholder() {
    return Challenge(
      '',
      recipe: Recipe.placeholder(),
      maxParticipants: 0,
    );
  }

  @override
  Widget tileSubtitle() {
    return Text(showSubtitle());
  }

  @override
  Widget tileTitle() {
    return Row(children: [
      Image.network(
        recipe.image.accessUrl,
        height: 50,
        width: 50,
      ),
      const SizedBox(
        width: 16,
      ),
      Text(recipe.name),
    ]);
  }
}
