class Ingredient {
  final int id;
  final String title;
  final String? unit;// واحد مثل کیلو یا قاشق
  final double amount;// تعداد یا مقدار

  Ingredient({
    required this.id,
    required this.title,
    required this.amount,
    // required this.unit,
    this.unit,
  });
}