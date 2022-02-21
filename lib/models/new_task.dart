class NewTaskRequestModel {
  NewTaskRequestModel({
    this.title,
    this.description,
  });

  // String? developerId;
  String? title;
  String? description;

  factory NewTaskRequestModel.fromJson(Map<String, dynamic> json) =>
      NewTaskRequestModel(
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
      );

  Map<String, dynamic> toJson() => {
        "developer_id": "Odinote",
        "title": title == null ? null : title,
        "description": description == null ? null : description,
      };
}
