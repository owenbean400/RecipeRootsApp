class Ingredient {
  int? id;
  final String amount;
  final String unit;
  final String ingredient;
  String? prepMethod;

  Ingredient(
      {this.id,
      required this.amount,
      required this.unit,
      required this.ingredient,
      this.prepMethod});
}
