import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:sqflite/sqflite.dart';

class Calendar extends StatefulWidget {
  final Future<List> dbLocation;

  Calendar(this.dbLocation);
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime _selectedDay;
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.week;
  Future<List> futureDB;

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _focusedDay = focusedDay;
        _selectedDay = selectedDay;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    futureDB = widget.dbLocation;
  }

  Future<List> getDBInfo(database) async {
    List resultList = [];
    List<Map> queryResults = await database.rawQuery('SELECT * FROM Tasks');
    if (queryResults.isNotEmpty) {
      for (int i = 0; i < queryResults.length; i++) {
        String strSelectedDay = _focusedDay.toIso8601String().substring(0, 10);
        if (strSelectedDay == queryResults[i]["enddate"]) {
          resultList.add(Text(queryResults[i]["description"].toString()));
        }
      }
    }
    return resultList;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        TableCalendar(
            firstDay: DateTime.utc(2000, 1, 1),
            lastDay: DateTime.utc(3000, 1, 1),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: _onDaySelected,
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            }),
        FutureBuilder(
          future: futureDB,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Future<List> resultList;
              Database database = snapshot.data[1];
              resultList = getDBInfo(database);
              return FutureBuilder(
                  future: resultList,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(25),
                            child: Text(
                              "Your Tasks For " +
                                  _focusedDay
                                      .toIso8601String()
                                      .substring(0, 10),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                          for (int i = 0; i < snapshot.data.length; i++)
                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                              child: Container(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text("${i + 1}"),
                                        Spacer(flex: 1),
                                      ],
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                    ),
                                    Container(
                                      child: snapshot.data[i],
                                    )
                                  ],
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.white70,
                                    border: Border.all(width: 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                              ),
                            ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                      );
                    } else if (snapshot.hasError) {
                      return Text("Failure");
                    } else {
                      return CircularProgressIndicator();
                    }
                  });
            } else if (snapshot.hasError) {
              return Text("Failure");
            } else {
              return CircularProgressIndicator();
            }
          },
        )
      ],
    );
  }
}
