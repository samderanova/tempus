import 'package:http/http.dart' as http;
import 'dart:convert';

Future fetchQuote() async {
  final response = await http.get(Uri.https('zenquotes.io', 'api/random'));

  if (response.statusCode == 200) {
    return Quote.fromJson(jsonDecode(response.body)[0]);
  } else {
    throw Exception('Quote generation failed.');
  }
}

class Quote {
  final String text;
  final String author;
  Quote({this.text, this.author});

  factory Quote.fromJson(Map<String, dynamic> json) {
    if (json['q'].startsWith('Too many requests')) {
      throw Exception("Quote generation failed. Too many requests.");
    }

    return Quote(
      text: json['q'],
      author: json['a'],
    );
  }
}
