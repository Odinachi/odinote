import 'package:odinote/models/new_task_response.dart';

// class GetAllTaskResponse {
//   GetAllTaskResponse({
//     this.data,
//   });
//
//   Data? data;
//
//   factory GetAllTaskResponse.fromJson(Map<String, dynamic>? json) =>
//       GetAllTaskResponse(
//         data: json!["data"] == null ? null : Data.fromJson(json["data"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "data": data == null ? null : data!.toJson(),
//       };
// }

class FetchAllResponse {
  FetchAllResponse({
    this.tasks,
  });

  List<Task>? tasks;

  factory FetchAllResponse.fromJson(Map<String, dynamic>? json) =>
      FetchAllResponse(
        tasks: json!["tasks"] == null
            ? null
            : List<Task>.from(json["tasks"].map((x) => Task.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "tasks": tasks == null
            ? null
            : List<dynamic>.from(tasks!.map((x) => x.toJson())),
      };
}
