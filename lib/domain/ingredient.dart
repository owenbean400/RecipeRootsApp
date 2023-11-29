class Ingredient {
  int? id;
  String amount;
  String unit;
  String ingredient;
  String? prepMethod;

  Ingredient(
      {this.id,
      required this.amount,
      required this.unit,
      required this.ingredient,
      this.prepMethod});

  factory Ingredient.fromSQL(Map<String, Object?> sqlMap) {
    return Ingredient(
        id: sqlMap["id"] as int,
        amount: sqlMap["amount"] as String,
        unit: sqlMap["unit"] as String,
        ingredient: sqlMap["ingredient"] as String,
        prepMethod: (sqlMap["prep_method"] != null)
            ? sqlMap["prep_method"] as String
            : "");
  }
}
