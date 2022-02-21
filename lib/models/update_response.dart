import 'package:odinote/models/new_task_response.dart';

class Updateresponse {
  Updateresponse({
    this.data,
  });

  Data? data;

  factory Updateresponse.fromJson(Map<String, dynamic>? json) => Updateresponse(
        data: json["data"] == null ? null : Data.fromJson(json!["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data!.toJson(),
      };
}

class Data {
  Data({
    this.updateTasksByPk,
  });

  Task? updateTasksByPk;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        updateTasksByPk: json["update_tasks_by_pk"] == null
            ? null
            : Task.fromJson(json["update_tasks_by_pk"]),
      );

  Map<String, dynamic> toJson() => {
        "update_tasks_by_pk":
            updateTasksByPk == null ? null : updateTasksByPk!.toJson(),
      };
}
