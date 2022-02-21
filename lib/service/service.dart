import 'package:odinote/models/deleteresponse.dart';
import 'package:odinote/models/new_task_response.dart';
import 'package:odinote/models/update_response.dart';
import 'package:odinote/service/graph_ql.dart';
import 'package:tuple/tuple.dart';

class AppService {
  AppRepository _appRepository = AppRepository();
  Future<Tuple2<Updateresponse?, String?>> update(String query,
      {required Map<String, dynamic> variables}) async {
    var _res =
        await _appRepository.performMutation(query, variables: variables);
    if (_res.hasException == true && _res.data == null) {
      return Tuple2(null, "Request Failed");
    } else {
      return Tuple2(Updateresponse.fromJson(_res.data), null);
    }
  }

  Future<Tuple2<Newtaskresponse, String>> create(String query,
      {required Map<String, dynamic> variables}) {}
  Future<Tuple2<Deleteresponse, String>> delete(
      {required String query, required String id}) {}
  Future<Tuple2<List<Task>, String>> getAll({String query}) {}
}
