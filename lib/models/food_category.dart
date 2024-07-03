class FoodCategory {
  final String title;
  final int id;
  final String image;
  late bool isSelected;

  FoodCategory({
    required this.title,
    required this.id,
    required this.image,
    this.isSelected = false,
  });
}
