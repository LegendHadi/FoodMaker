class FoodCategory {
  final String title;
  final int id;
  late String? image;
  late bool isSelected;

  FoodCategory({
    required this.title,
    required this.id,
    this.image,
    this.isSelected = false,
  });
}
