class Country {
  final String name, code;
  Country({required this.name, required this.code});
  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name']['common'],
      code: json['cca2'],
    );
  }
}
