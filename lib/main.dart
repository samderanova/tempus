import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import './tasks.dart';
import './home.dart';
import './about.dart';
import './timer.dart';

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
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _widgetOptions = <Widget>[
    Home(),
    Countdown(),
    Tasks(),
    Text(
      'Calendar',
      style: optionStyle,
    ),
    About(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.pageNum;
    print(_selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: navBackgroundColor,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      backgroundColor: Color(0xffdbb0a0),
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
