import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiCalls
{
  String title;
  String description;

  ApiCalls({this.title,this.description});

  Future<void> createItem() async {
  final response = await http.post(
    'http://192.168.1.16:8000/items/',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'title': title,
      'description': description
    }),
  );

  if (response.statusCode == 201) {
  print(jsonDecode(response.body));
  } else {
  throw Exception('Failed to create list item.');
  }
  }
}