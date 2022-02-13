import 'package:ezcountry/common/constants.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphqlService{
  GraphQLClient client;
  HttpLink httpLink= HttpLink(
  'https://countries.trevorblades.com/',
  );
  GraphqlService(){
    client = GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(),
    );
  }

  Future<dynamic> executeQuery(String query,
      {Map<String, dynamic> variables}) async {
    QueryOptions options =
    QueryOptions(document: gql(query), variables: variables);
    try {
      final result = await client.query(options);

      if (result.data != null) {
        return result.data;
      } else if (result.hasException) {
        if (result.exception.linkException.originalException
            .toString()
            .contains(Constants.failedToLookHost)) {
          return Constants.error;
        }
        return Constants.error;
      } else {
        return Constants.error;
      }
    } catch (e) {
      return Constants.error;
    }
  }
}