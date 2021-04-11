import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';

class Countdown extends StatefulWidget {
  @override
  _CountdownState createState() => _CountdownState();
}

class _CountdownState extends State<Countdown> {
  bool _timerRunning = false;
  Duration _timer = new Duration(hours: 0, minutes: 0, seconds: 0);
  TextStyle _mainTxtStyle = TextStyle(color: Colors.white, fontSize: 30);
  Timer runCode;
  ButtonStyle btnStyle = new ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Color(0xffEAB586)));
  String _timeString = '00:00:00';
  final hoursController = TextEditingController(text: '0');
  final minutesController = TextEditingController(text: '0');
  final secondsController = TextEditingController(text: '0');

  @override
  void initState() {
    super.initState();
    runCode = new Timer.periodic(
        Duration(seconds: 1), (Timer t) => decreaseCountdown());
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Container(
        child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              new Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width / 2,
                decoration: new BoxDecoration(
                  color: Color(0xffffcccb),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    this._timeString,
                    style: this._mainTxtStyle,
                  ),
                ),
              ),
              new SizedBox(height: 10),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  new SizedBox(width: 20),
                  new Text('Hours: '),
                  new Flexible(
                    child: new TextFormField(
                        controller: this.hoursController,
                        decoration: new InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ]),
                  ),
                  new SizedBox(width: 20),
                  new Text('Minutes: '),
                  new Flexible(
                    child: new TextFormField(
                        controller: this.minutesController,
                        decoration: new InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ]),
                  ),
                  new SizedBox(width: 20),
                  new Text('Seconds: '),
                  new Flexible(
                    child: new TextFormField(
                      controller: this.secondsController,
                      decoration: new InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 1),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                  new SizedBox(width: 20),
                ],
              ),
              new SizedBox(height: 10),
              new Row(
                children: [
                  new Spacer(),
                  new SizedBox(
                    width: 125,
                    child: new ElevatedButton(
                      style: this.btnStyle,
                      child: new Text("Set time"),
                      onPressed: () => {this.setTime()},
                    ),
                  ),
                  new SizedBox(width: 20),
                  new SizedBox(
                    width: 125,
                    child: new ElevatedButton(
                      style: this.btnStyle,
                      child: new Text("Reset time"),
                      onPressed: () => {this.resetTime()},
                    ),
                  ),
                  new Spacer(),
                ],
              ),
              new SizedBox(height: 10),
              new Row(
                children: [
                  new Spacer(),
                  new SizedBox(
                    width: 125,
                    child: new ElevatedButton(
                        style: this.btnStyle,
                        child: new Text('Start Timer'),
                        onPressed: () => {
                              this.startCountdown(),
                            }),
                  ),
                  new SizedBox(width: 20),
                  new SizedBox(
                    width: 125,
                    child: new ElevatedButton(
                        style: this.btnStyle,
                        child: new Text('Stop Timer'),
                        onPressed: () => {
                              this.stopCountdown(),
                            }),
                  ),
                  new Spacer(),
                ],
              ),
            ]),
      ),
    ]);
  }

  void setTime() {
    setState(() => {
          this._timer = new Duration(
            hours: int.parse(this.hoursController.text),
            minutes: int.parse(this.minutesController.text),
            seconds: int.parse(this.secondsController.text),
          ),
          this._timeString = this.getTimeString(this._timer),
        });
  }

  void resetTime() {
    setState(() => {
          this._timer = new Duration(hours: 0, minutes: 0, seconds: 0),
          this.hoursController.text = '0',
          this.minutesController.text = '0',
          this.secondsController.text = '0',
          this._timeString = this.getTimeString(this._timer),
        });
  }

  String getTimeString(Duration t) {
    String res = t.toString();
    return res.substring(0, res.length - 7);
  }

  void startCountdown() {
    if (!this._timerRunning &&
        this._timer != new Duration(hours: 0, minutes: 0, seconds: 0)) {
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
    if (this._timerRunning &&
        this._timer != new Duration(hours: 0, minutes: 0, seconds: 0)) {
      setState(() => {
            this._timer -= new Duration(seconds: 1),
            this._timeString = this.getTimeString(this._timer),
          });
    }
  }
}
