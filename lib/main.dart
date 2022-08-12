import 'package:flutter/material.dart';
import 'package:odinote/constants.dart';
import 'package:odinote/screens/edit_screen.dart';
import 'package:odinote/screens/home_screen.dart';
import 'package:odinote/service/app_service.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  createTable();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: _routes,
      initialRoute: '/',
      home: const HomeScreen(),
    );
  }

  Route _routes(RouteSettings settings) {
    Widget _builder = Container();
    switch (settings.name) {
      case "/":
        _builder = const HomeScreen();
        break;
      case "edit":
        EditScreenArg arg = settings.arguments as EditScreenArg;
        _builder = EditScreen(
          task: arg.task,
        );
        break;
      default:
        throw Exception('Invalid route: ${settings.name}');
    }

    return MaterialPageRoute(
      builder: (_) => _builder,
      settings: settings,
    );
  }
}

createTable() async {
  var databasesPath = await getDatabasesPath();
  String path = (databasesPath + demoDb);
  await TaskService.instance.initialize(path);
}
