import 'package:odinote/models/new_task_response.dart';

class Deleteresponse {
  Deleteresponse({
    this.data,
  });

  Data? data;

  factory Deleteresponse.fromJson(Map<String, dynamic>? json) => Deleteresponse(
        data: json!["data"] == null ? null : Data.fromJson(json!["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data!.toJson(),
      };
}

class Data {
  Data({
    this.deleteTasksByPk,
  });

  Task? deleteTasksByPk;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        deleteTasksByPk: json["delete_tasks_by_pk"] == null
            ? null
            : Task.fromJson(json["delete_tasks_by_pk"]),
      );

  Map<String, dynamic> toJson() => {
        "delete_tasks_by_pk":
            deleteTasksByPk == null ? null : deleteTasksByPk!.toJson(),
      };
}
