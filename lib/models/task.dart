import '../constants.dart';

class Task {
  int? id;
  String? title;
  String? desc;
  bool? done;

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      columnTitle: title,
      columnDesc: desc,
      columnDone: done == true ? 1 : 0
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  Task({this.id, this.desc, this.done, this.title});

  Task.fromMap(Map<String, Object?> map) {
    id = int.parse(map[columnId].toString());
    title = map[columnTitle].toString();
    desc = map[columnDesc].toString();
    done = map[columnDone] == 1;
  }
}
