import 'package:flutter/material.dart';
import 'dart:async';

class Countdown extends StatefulWidget {
  @override
  _CountdownState createState() => _CountdownState();
}

class _CountdownState extends State<Countdown> {
  bool _timerRunning = false;
  Duration _timer = new Duration(hours: 0, minutes: 0, seconds: 0);
  TextStyle _txtStyle = TextStyle(color: Colors.white);
  Timer runCode;

  @override
  void initState() {
    super.initState();
    runCode = new Timer.periodic(
        Duration(seconds: 1), (Timer t) => decreaseCountdown());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          new Text("asdf"),
          new Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width / 2,
            decoration: new BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                this._timer.toString().substring(0, 7),
                style: this._txtStyle,
              ),
            ),
          ),
          new ElevatedButton(
            onPressed: () => increaseTime(),
            child: Text('Increase timer by 1 minute'),
          ),
          new ElevatedButton(
            onPressed: () => startCountdown(),
            child: Text('Start timer!'),
          ),
          new ElevatedButton(
            onPressed: () => stopCountdown(),
            child: Text('Stop timer'),
          )
        ],
      ),
    );
  }

  void increaseTime() {
    setState(() => {
          this._timer += new Duration(hours: 0, minutes: 1, seconds: 0),
        });
  }

  void startCountdown() {
    if (!this._timerRunning) {
      setState(() => {
            this._timerRunning = true,
          });
    }
  }

  void stopCountdown() {
    if (this._timerRunning) {
      setState(() => {
            this._timerRunning = false,
          });
    }
  }

  void decreaseCountdown() {
    if (this._timerRunning) {
      setState(() => {
            this._timer -= new Duration(seconds: 1),
          });
    }
  }
}
