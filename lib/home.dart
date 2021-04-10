import 'package:flutter/material.dart';
import 'quote.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future futureQuote;

  @override
  void initState() {
    super.initState();
    futureQuote = fetchQuote();
  }

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
                  "Tempus",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                decoration: new BoxDecoration(
                  color: Color(0xffffcccb),
                  shape: BoxShape.circle,
                ),
                height: MediaQuery.of(context).size.height / 2.5,
                width: MediaQuery.of(context).size.width / 2.5,
                alignment: Alignment.center,
              ),
              FutureBuilder(
                  future: futureQuote,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          Container(
                              child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(20),
                                child: Text(
                                  snapshot.data.text,
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 20,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Text('~${snapshot.data.author}',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ))
                            ],
                          )),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            snapshot.error.toString().substring(11),
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ));
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              "Welcome!",
              style: TextStyle(
                fontSize: 30,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
