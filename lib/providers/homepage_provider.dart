import 'package:ezcountry/common/constants.dart';
import 'package:ezcountry/common/graphql_query.dart';
import 'package:ezcountry/graphql/graphql_service.dart';
import 'package:ezcountry/model/country.dart';
import 'package:flutter/material.dart';

class HomepageProvider extends ChangeNotifier {
  bool isLoading = false, isDetailsLoading = false;
  List<Country> countriesList = [], tempCountriesList = [];
  List<String> languageList = [], selectedLanguage = [];
  Country selectedCountry;

  Future<void> fetchCountries() async {
    isLoading = true;
    notifyListeners();
    var response =
        await GraphqlService().executeQuery(GraphqlQuery.countryQuery);
    if (response != Constants.error) {
      if (response[Constants.countries] != null) {
        var countries = Countries.fromMap(response);
        if (countries != null) {
          if (countries.countries != null && countries.countries.isNotEmpty) {
            tempCountriesList = countriesList = countries.countries;
            fetchAllLanguages();
          }
        }
      }
    }
    isLoading = false;
    notifyListeners();
  }

  void searchByCountryCode({String value}) {
    if (value.trim().isNotEmpty) {
      countriesList = tempCountriesList
          .where((element) => element.code.toLowerCase() == value.toLowerCase())
          ?.toList();
    }
    notifyListeners();
  }

  void reInitializeCountries() {
    if (selectedLanguage.isNotEmpty) {
      return;
    } else {
      countriesList = tempCountriesList;
      notifyListeners();
    }
  }

  void fetchAllLanguages() {
    languageList = [];
    notifyListeners();
    countriesList.forEach((element) {
      element.languages.forEach((language) {
        if (!languageList.contains(language.name)) {
          languageList.add(language.name);
        }
      });
    });
  }

  void updateLanguageSettings({bool value, String language}) {
    if (selectedLanguage.contains(language)) {
      selectedLanguage.remove(language);
    } else {
      selectedLanguage.add(language);
    }
    applyFilter();
  }

  void applyFilter() {
    countriesList = [];
    tempCountriesList.forEach((element) {
      for (var language in element.languages) {
        if (selectedLanguage.contains(language.name)) {
          countriesList.add(element);
          break;
        }
      }
    });
    if (selectedLanguage.isEmpty) countriesList = tempCountriesList;
    notifyListeners();
  }

  void removeFilter() {
    countriesList = tempCountriesList;
    selectedLanguage = [];
    notifyListeners();
  }

  Future<void> fetchCountryDetails({String code}) async {
    isDetailsLoading = true;
    selectedCountry = null;
    notifyListeners();
    var response = await GraphqlService()
        .executeQuery(GraphqlQuery.countryDetailsQuery(code: code));
    if (response != null && response != Constants.error) {
      if (response[Constants.country] != null) {
        selectedCountry = Country.fromMap(response[Constants.country]);
      }
    }
    isDetailsLoading = false;
    notifyListeners();
  }
}
