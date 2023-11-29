class CookingStep {
  int? id;
  String instruction;

  CookingStep({this.id, required this.instruction});

  factory CookingStep.fromSQL(Map<String, Object?> sqlMap) {
    return CookingStep(
        id: sqlMap["id"] as int, instruction: sqlMap["instruction"] as String);
  }
}
