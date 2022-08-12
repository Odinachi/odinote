import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:odinote/constants.dart';
import 'package:odinote/models/task.dart';
import 'package:odinote/service/app_service.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'app_service_test.mocks.dart';

@GenerateMocks([TaskService])
void main() {
  late Database database;
  late MockTaskService taskService;
  Task testTask = Task(id: 1, title: "first ", done: false, desc: "yes");
  List<Task> taskList = List.generate(10, (index) => testTask);
  setUpAll(() async {
    sqfliteFfiInit();
    database = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    await database.execute(databaseRules);
    taskService = MockTaskService();
    taskService.db = database;
    when(taskService.insert(any)).thenAnswer((_) async => testTask);
    when(taskService.update(any)).thenAnswer((_) async => 1);
    when(taskService.delete(any)).thenAnswer((_) async => 1);
    when(taskService.getTask(any)).thenAnswer((_) async => testTask);
    when(taskService.getAllTask()).thenAnswer((_) async => taskList);
  });

  group('Database Test', () {
    test('sqflite version', () async {
      expect(await database.getVersion(), 0);
    });
    test('add Item to database', () async {
      var i = await database.insert(
          tableTodo, Task(title: "first ", done: false, desc: "yes").toMap());
      var p = await database.query(tableTodo);
      expect(p.length, i);
    });
    test('add three Items to database', () async {
      await database.insert(
          tableTodo, Task(title: "second", done: false, desc: "yes").toMap());
      await database.insert(
          tableTodo, Task(title: "third ", done: false, desc: "yes").toMap());
      await database.insert(
          tableTodo, Task(title: "fourth ", done: false, desc: "yes").toMap());
      var p = await database.query(tableTodo);
      expect(p.length, 4);
    });
    test('update first Item', () async {
      await database.update(tableTodo,
          Task(title: "Changed the first", done: false, desc: "yes").toMap(),
          where: '$columnId = ?', whereArgs: [1]);
      var p = await database.query(tableTodo);
      expect(p.first['title'], "Changed the first");
    });
    test('delete the first Item', () async {
      await database.delete(tableTodo, where: '$columnId = ?', whereArgs: [1]);
      var p = await database.query(tableTodo);
      expect(p.length, 3);
    });
    test('Close db', () async {
      await database.close();
      expect(database.isOpen, false);
    });
  });

  group("Service test", () {
    test("create task", () async {
      verifyNever(taskService.insert(testTask));
      expect(await taskService.insert(testTask), testTask);
      verify(taskService.insert(testTask)).called(1);
    });
    test("update task", () async {
      verifyNever(taskService.update(testTask));
      expect(await taskService.update(testTask), 1);
      verify(taskService.update(testTask)).called(1);
    });
    test("delete task", () async {
      verifyNever(taskService.delete(1));
      expect(await taskService.delete(1), 1);
      verify(taskService.delete(1)).called(1);
    });
    test("get task", () async {
      verifyNever(taskService.getTask(1));
      expect(await taskService.getTask(1), testTask);
      verify(taskService.getTask(1)).called(1);
    });
    test("get all task", () async {
      verifyNever(taskService.getAllTask());
      expect(await taskService.getAllTask(), taskList);
      verify(taskService.getAllTask()).called(1);
    });
  });
}
