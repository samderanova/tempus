import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import './tasks.dart';
import './home.dart';
import './about.dart';
import './timer.dart';
import './calendar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Colors.pink,
      ),
      home: SafeArea(
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final int pageNum;
  MyHomePage({this.pageNum = 0});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const Color navTextColor = Colors.white;
  static const Color navBackgroundColor = Color(0xffe0c2c0);
  int _selectedIndex;
  List<Widget> _widgetOptions;
  String path;
  Database database;
  _MyHomePageState() {
    _widgetOptions = <Widget>[
      Home(),
      Countdown(),
      Tasks(),
      Calendar(setUp()),
      About(),
    ];
    setUp();
  }

  Future<List> setUp() async {
    path = join(await getDatabasesPath(), 'tasks.db');
    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE Tasks (id INTEGER PRIMARY KEY, description TEXT, startdate TEXT, enddate TEXT)');
    });
    return [path, database];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.pageNum;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: navBackgroundColor,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xffdbb0a0),
              Color(0xffffbdca),
              Color(0xffff8695),
            ],
          ),
        ),
        child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: navBackgroundColor,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: navTextColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.timer),
              label: 'Timer',
              backgroundColor: navTextColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Tasks',
              backgroundColor: navTextColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'Calendar',
              backgroundColor: navTextColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: 'About',
              backgroundColor: navTextColor,
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: navTextColor,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed),
    );
  }
}
