class GraphqlQuery {
  static String countryQuery = """
  query ExampleQuery {
  countries {
    name
    code
    emoji
    phone
    languages {
      name
    }
  }
}""";
  static String countryDetailsQuery({String code})=>"""
  {
  country(code: "$code") {
    name
    code
    phone
    emoji
    currency
    languages {
      code
      name
    }
    continent{
    name
    }
  }
}""";
}
