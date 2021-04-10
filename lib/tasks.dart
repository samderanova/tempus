import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import './form.dart';

class Tasks extends StatefulWidget {
  Tasks();
  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  List<Map> tasks;
  String path;
  Database database;

  void setUp() async {
    path = join(await getDatabasesPath(), 'tasks.db');
    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE Tasks (id INTEGER PRIMARY KEY, description TEXT)');
    });
    tasks = await database.rawQuery('SELECT * FROM Tasks');
  }

  @override
  void initState() {
    super.initState();
    setUp();
    print(tasks);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Text('+'),
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(content: Text("Hello")),
          );
        },
      ),
    );
  }
}
