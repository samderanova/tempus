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
    return FutureBuilder(
        future: futureQuote,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data.text);
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
