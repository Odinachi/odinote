class Newtaskresponse {
  Newtaskresponse({
    this.data,
  });

  Data? data;

  factory Newtaskresponse.fromJson(Map<String, dynamic> json) =>
      Newtaskresponse(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data!.toJson(),
      };
}

class Data {
  Data({
    this.insertTasksOne,
  });

  Task? insertTasksOne;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        insertTasksOne: json["insert_tasks_one"] == null
            ? null
            : Task.fromJson(json["insert_tasks_one"]),
      );

  Map<String, dynamic> toJson() => {
        "insert_tasks_one":
            insertTasksOne == null ? null : insertTasksOne!.toJson(),
      };
}

class Task {
  Task({
    this.createdAt,
    this.description,
    this.developerId,
    this.id,
    this.isCompleted,
    this.title,
    this.updatedAt,
  });

  DateTime? createdAt;
  String? description;
  String? developerId;
  String? id;
  bool? isCompleted;
  String? title;
  DateTime? updatedAt;

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        description: json["description"] == null ? null : json["description"],
        developerId: json["developer_id"] == null ? null : json["developer_id"],
        id: json["id"] == null ? null : json["id"],
        isCompleted: json["isCompleted"] == null ? null : json["isCompleted"],
        title: json["title"] == null ? null : json["title"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "description": description == null ? null : description,
        "developer_id": developerId == null ? null : developerId,
        "id": id == null ? null : id,
        "isCompleted": isCompleted == null ? null : isCompleted,
        "title": title == null ? null : title,
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}
