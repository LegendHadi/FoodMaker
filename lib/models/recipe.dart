import 'package:foodager/models/food_category.dart';
import 'package:foodager/models/nutrition.dart';
import 'ingredient.dart';
import 'media.dart';

class Recipe {
  final int id;
  final Media media; //صدا و تصویر
  final String title;
  final String description;
  final List<Ingredient> ingredients; //مواد لازم
  final Nutrition nutrition; // ارزش غذایی
  final List<String> instructions; // دستورالعمل تهیه
  final FoodCategory? category; //دسته بندی
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
    // required this.category,
    this.category,
  });
}
