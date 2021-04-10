import 'package:flutter/material.dart';

class Timer extends StatefulWidget {
  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  bool _isClicked = false;
  int _timeLeft = 0;
  TextStyle _txtStyle = TextStyle(color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          new Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width / 2,
            decoration: new BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
            child: Text(
              "TIMEE",
              style: this._txtStyle,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
