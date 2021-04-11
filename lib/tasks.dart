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

  Future<List<Widget>> tasksSetUp() async {
    path = join(await getDatabasesPath(), 'tasks.db');
    database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE Tasks (id INTEGER PRIMARY KEY, description TEXT, startdate TEXT, enddate TEXT)');
      },
    );
    // await deleteDatabase(path);
    return refreshData();
  }

  void deleteTask(int rowID) async {
    print(rowID);
    print(await database.rawQuery('SELECT * FROM Tasks'));
    await database.rawDelete('DELETE FROM Tasks WHERE id = $rowID');
    setState(() {});
  }

  Future<List<Widget>> refreshData() async {
    List<Widget> resultList = [];
    List<Map> queryResults = await database.rawQuery('SELECT * FROM Tasks');
    if (queryResults.isNotEmpty) {
      for (int i = 0; i < queryResults.length; i++) {
        String taskDescription = queryResults[i]["description"];
        String dateStarted = queryResults[i]["startdate"];
        String deadline = queryResults[i]["enddate"];
        resultList.add(
          Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("${i + 1}"),
                      Spacer(flex: 1),
                      Column(
                        children: [
                          Text("$dateStarted to $deadline"),
                        ],
                      ),
                      Spacer(flex: 1),
                      TextButton(
                        onPressed: () {
                          deleteTask(queryResults[i]["id"]);
                        },
                        child: Icon(Icons.delete),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                  ),
                  Container(
                    child: Text(taskDescription),
                  )
                ],
              ),
              decoration: BoxDecoration(
                  color: Colors.white70,
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
            ),
          ),
        );
      }
    }
    return resultList;
  }

  void refreshTasks() async {
    tasks = await refreshData();
  }

  @override
  void initState() {
    tasksSetUp();
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
                  print(snapshot.error);
                  children = [
                    Padding(
                      padding: EdgeInsets.all(25),
                      child: Text(
                        "Failed to fetch your tasks!",
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ];
                } else {
                  children = [
                    Padding(
                      padding: EdgeInsets.all(25),
                      child: Text(
                        "No tasks found yet!",
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ];
                }
                return Column(
                  children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(25),
                          child: Text(
                            "Your Tasks",
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                      ] +
                      children,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                );
              },
              future: tasksSetUp())
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Text('+', style: TextStyle(fontSize: 25)),
        backgroundColor: Colors.pink[300],
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
