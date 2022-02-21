class UpdateRequestModel {
  UpdateRequestModel({
    this.id,
    this.payload,
  });

  String? id;
  Payload? payload;

  factory UpdateRequestModel.fromJson(Map<String, dynamic> json) =>
      UpdateRequestModel(
        id: json["id"] == null ? null : json["id"],
        payload:
            json["payload"] == null ? null : Payload.fromJson(json["payload"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "payload": payload == null ? null : payload!.toJson(),
      };
}

class Payload {
  Payload({
    this.isCompleted,
    this.title,
    this.description,
  });

  bool? isCompleted;
  String? title;
  String? description;

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        isCompleted: json["isCompleted"] == null ? null : json["isCompleted"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
      );

  Map<String, dynamic> toJson() => {
        "isCompleted": isCompleted == null ? null : isCompleted,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
      };
}
