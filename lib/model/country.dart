// To parse this JSON data, do
//
//     final countries = countriesFromJson(jsonString);

import 'dart:convert';

import 'package:ezcountry/model/continent.dart';
import 'package:ezcountry/model/language.dart';

Countries countriesFromJson(String str) => Countries.fromMap(json.decode(str));

String countriesToJson(Countries data) => json.encode(data.toMap());

class Countries {
  Countries({
    this.countries,
  });

  List<Country> countries;

  factory Countries.fromMap(Map<String, dynamic> json) => Countries(
        countries: json["countries"] == null
            ? null
            : List<Country>.from(
                json["countries"].map((x) => Country.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "countries": countries == null
            ? null
            : List<dynamic>.from(countries.map((x) => x.toMap())),
      };
}

class Country {
  Country({
    this.name,
    this.code,
    this.emoji,
    this.phone,
    this.languages,
    this.currency,
    this.continent,
  });

  String name;
  String code;
  String emoji;
  String phone;
  List<Language> languages;
  String currency;
  Continent continent;

  factory Country.fromMap(Map<String, dynamic> json) => Country(
        name: json["name"],
        code: json["code"],
        emoji: json["emoji"],
        phone: json["phone"],
        languages: List<Language>.from(
            json["languages"].map((x) => Language.fromMap(x))),
        currency: json == null ? null : json["currency"],
        continent: json == null ? null : Continent.fromMap(json["continent"]),
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "code": code,
        "emoji": emoji,
        "phone": phone,
        "languages": List<dynamic>.from(languages.map((x) => x.toMap())),
        "currency": currency,
        "continent": continent.toMap(),
      };
}
