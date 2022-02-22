import 'package:odinote/models/deleteresponse.dart';
import 'package:odinote/models/get_all_task.dart';
import 'package:odinote/models/new_task_response.dart';
import 'package:odinote/models/update_response.dart';
import 'package:tuple/tuple.dart';

abstract class AppServiceInterface {
  Future<Tuple2<Updateresponse?, String?>> update(String query,
      {required Map<String, dynamic> variables});
  Future<Tuple2<Newtaskresponse?, String?>> create(String query,
      {required Map<String, dynamic> variables});
  Future<Tuple2<Deleteresponse?, String?>> delete(
      {required String query, required String id});
  Future<Tuple2<FetchAllResponse?, String?>> getAll(String query);
}
