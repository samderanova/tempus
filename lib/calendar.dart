import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:path/path.dart';
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
  List _selectedEvents = [];

  List _getEventsForDay(DateTime day) {
    // get events from task page
    // using test events for the moment
    return ["Task 1", "Task 2"];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _focusedDay = focusedDay;
        _selectedDay = selectedDay;
        _selectedEvents = _getEventsForDay(selectedDay);
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
        for (int i = 0; i < _selectedEvents.length; i++)
          Text(
            _selectedEvents[i],
          ),
      ],
    );
  }
}
