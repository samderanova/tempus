import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              Container(
                child: Text(
                  "About",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color(0xffffcccb),
                  shape: BoxShape.circle,
                ),
                height: MediaQuery.of(context).size.height / 2.5,
                width: MediaQuery.of(context).size.width / 2.5,
                alignment: Alignment.center,
              )
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Padding(
            child: Text(
              "Tempus is a motivational app that increases your focus and productivity to the max! You can create your own tasks and set timers for each one. When starting each task, the app can even lock your phone so you don't get distracted by it!",
              style: TextStyle(fontSize: 20, height: 1.5),
              textAlign: TextAlign.center,
            ),
            padding: EdgeInsets.fromLTRB(20, 200, 20, 20),
          ),
        ),
        Positioned(
          left: -100,
          bottom: -150,
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xffffcccb),
              shape: BoxShape.circle,
            ),
            height: MediaQuery.of(context).size.height / 2.5,
            width: MediaQuery.of(context).size.width / 2.5,
          ),
        ),
        Positioned(
          right: -100,
          bottom: -150,
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xffffcccb),
              shape: BoxShape.circle,
            ),
            height: MediaQuery.of(context).size.height / 2.5,
            width: MediaQuery.of(context).size.width / 2.5,
          ),
        ),
      ],
    );
  }
}
