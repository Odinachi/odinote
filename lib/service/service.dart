import 'package:odinote/models/deleteresponse.dart';
import 'package:odinote/models/get_all_task.dart';
import 'package:odinote/models/new_task_response.dart';
import 'package:odinote/models/update_response.dart';
import 'package:odinote/service/app_service_interface.dart';
import 'package:tuple/tuple.dart';

import 'app_repository.dart';

class AppService implements AppServiceInterface {
  final AppRepository _appRepository = AppRepository();

  @override
  Future<Tuple2<Updateresponse?, String?>> update(String query,
      {required Map<String, dynamic> variables}) async {
    var _res =
        await _appRepository.performMutation(query, variables: variables);
    if (_res.hasException == true && _res.data == null) {
      return const Tuple2(null, "Request Failed");
    } else {
      return Tuple2(Updateresponse.fromJson(_res.data), null);
    }
  }

  @override
  Future<Tuple2<Newtaskresponse?, String?>> create(String query,
      {required Map<String, dynamic> variables}) async {
    var _res =
        await _appRepository.performMutation(query, variables: variables);
    if (_res.hasException == true && _res.data == null) {
      return const Tuple2(null, "Request Failed");
    } else {
      return Tuple2(Newtaskresponse.fromJson(_res.data), null);
    }
  }

  @override
  Future<Tuple2<Deleteresponse?, String?>> delete(
      {required String query, required String id}) async {
    var _res =
        await _appRepository.performMutation(query, variables: {"id": id});
    if (_res.hasException == true && _res.data == null) {
      return const Tuple2(null, "Request Failed");
    } else {
      return Tuple2(Deleteresponse.fromJson(_res.data), null);
    }
  }

  @override
  Future<Tuple2<GetAllTaskResponse?, String?>> getAll(String query) async {
    var _res = await _appRepository
        .performQuery(query, variables: {"developer_id": "Odinote"});
    if (_res.hasException == true && _res.data == null) {
      return const Tuple2(null, "Request Failed");
    } else {
      return Tuple2(GetAllTaskResponse.fromJson(_res.data), null);
    }
  }
}
