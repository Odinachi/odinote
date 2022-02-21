import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:odinote/service/app_repository_interface.dart';

class AppRepository implements RepopsitoryInterface {
  GraphQLClient? _client;

  AppRepository() {
    HttpLink link = HttpLink(
      'https://todolistassessment.hasura.app/v1/graphql',
      defaultHeaders: {
        "x-hasura-admin-secret":
            "JG7vDm15n1fVT2QhwYNyDFJJmm5iQKIea3H0tVpYnNV735Wa2ms3msthBGquM2sm",
        "content-type": "application/json"
      },
    );

    _client = GraphQLClient(link: link, cache: GraphQLCache());
  }

  @override
  Future<QueryResult> performQuery(String query,
      {required Map<String, dynamic> variables}) async {
    QueryOptions options =
        QueryOptions(document: gql(query), variables: variables);
    print("option is ${options}");

    final result = await _client!.query(options);
    print("result is ${result}");
    print("result is ${result.hasException}");

    return result;
  }

  @override
  Future<QueryResult> performMutation(String query,
      {required Map<String, dynamic> variables}) async {
    MutationOptions options =
        MutationOptions(document: gql(query), variables: variables);

    final result = await _client!.mutate(options);

    print(result);

    return result;
  }
}
