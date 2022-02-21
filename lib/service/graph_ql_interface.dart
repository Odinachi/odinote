import 'package:graphql_flutter/graphql_flutter.dart';

abstract class RepopsitoryInterface {
  Future<QueryResult> performQuery(String query,
      {required Map<String, dynamic> variables});
  Future<QueryResult> performMutation(String query,
      {required Map<String, dynamic> variables});
}
