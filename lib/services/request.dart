import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:todo_list/services/todo.dart';

class ApiCalls
{
  String title;
  String description;

  ApiCalls({this.title,this.description});

  Future<List<Todo>> getData() async
  {
    try{
      var response = await http.get('http://192.168.1.16:8000/items/');
      var items = List<Todo>();
      if(response.statusCode == 200)
      {
        var listData = jsonDecode(response.body);
        for(var itemsJson in listData)
        {
          items.add(Todo.fromJson(itemsJson));
        }
      }
      return items;
    }catch(e)
    {
      print('Caught Error $e');
    }
  }

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
  }
  else {
    throw Exception('Failed to create list item.');
   }
  }

  Future<void> updateItem(int id) async {
    String idToString = id.toString();
    final response = await http.put(
      'http://192.168.1.16:8000/items/$idToString/',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': title,
        'description': description
      }),
    );

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
    }
    else {
      throw Exception('Failed to update list item.');
    }
  }

  Future<void> deleteItem(int id) async {
    String idToString = id.toString();
    final  response = await http.delete(
      'http://192.168.1.16:8000/items/$idToString/',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 204) {
      if(response.body.isEmpty)
        {
          print("Deleted");
        }
    }
    else {
      throw Exception('Failed to delete list item.');
    }
  }
}