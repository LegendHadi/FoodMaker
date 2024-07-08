import 'package:FoodMaker/models/nutrition.dart';
import 'ingredient.dart';
import 'media.dart';

class Recipe {
  final int id;
  final Media media;
  final String title;
  final String description;
  final List<Ingredient> ingredients;
  final Nutrition nutrition;
  final List<String> instructions;
  final int categoryId;
  late bool isFavorite;

  Recipe({
    required this.id,
    required this.media,
    required this.title,
    required this.description,
    required this.ingredients,
    required this.nutrition,
    required this.instructions,
    this.isFavorite = false,
    required this.categoryId,
  });
}
