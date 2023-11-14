class Person {
  int? id;
  final String firstName;
  final String middleName;
  final String lastName;

  Person(
      {this.id,
      required this.firstName,
      required this.middleName,
      required this.lastName});

  factory Person.fromSQL(Map<String, Object?> sqlMap) {
    return Person(
        id: sqlMap["id"] as int,
        firstName: sqlMap["first_name"] as String,
        middleName: sqlMap["middle_name"] as String,
        lastName: sqlMap["last_name"] as String);
  }
}
