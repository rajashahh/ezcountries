class Language {
  Language({
    this.name,
  });

  String name;

  factory Language.fromMap(Map<String, dynamic> json) => Language(
    name: json["name"],
  );

  Map<String, dynamic> toMap() => {
    "name": name,
  };
}