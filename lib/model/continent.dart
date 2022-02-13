class Continent {
  Continent({
    this.name,
  });

  String name;

  factory Continent.fromMap(Map<String, dynamic> json) => Continent(
    name: json==null?null:json["name"],
  );

  Map<String, dynamic> toMap() => {
    "name": name,
  };
}
