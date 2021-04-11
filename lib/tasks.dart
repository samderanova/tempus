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
  List<Widget> tasks = [];
  String path;
  Database database;

  Future<List<Widget>> setUp() async {
    path = join(await getDatabasesPath(), 'tasks.db');
    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE Tasks (id INTEGER PRIMARY KEY, description TEXT, startdate TEXT, enddate TEXT)');
    });
    return refreshData();
  }

  Future<List<Widget>> refreshData() async {
    List<Widget> resultList = [];
    List<Map> queryResults = await database.rawQuery('SELECT * FROM Tasks');
    if (queryResults.isNotEmpty) {
      for (int i = 0; i < queryResults.length; i++) {
        resultList.add(Text(queryResults[i]["description"].toString()));
      }
    }
    return resultList;
  }

  void refreshTasks() async {
    tasks = await refreshData();
  }

  @override
  void initState() {
    setUp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          FutureBuilder(
              builder:
                  (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
                List<Widget> children;
                if (snapshot.hasData) {
                  children = snapshot.data;
                } else if (snapshot.hasError) {
                  children = [Text("Failed to fetch your tasks!")];
                } else {
                  children = [Text("No tasks found yet!")];
                }
                return Column(
                  children: children,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                );
              },
              future: setUp())
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Text('+', style: TextStyle(fontSize: 25)),
        backgroundColor: Colors.pink,
        focusColor: Colors.pink[100],
        splashColor: Colors.pink[50],
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              backgroundColor: Color(0xffffcccb),
              content: CustomForm(path, database),
            ),
            useSafeArea: true,
          ).then((value) {
            refreshTasks();
            setState(() {});
          });
        },
      ),
      backgroundColor: Color(0xffdbb0a0),
    );
  }
}
