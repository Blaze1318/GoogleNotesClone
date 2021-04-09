import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:todo_list/services/todo.dart';

class ApiCalls
{
  String? title;
  String? description;

  ApiCalls({this.title,this.description});

  Future<List<Todo>> getData() async
  {
    try{
      var url = Uri.http('192.168.1.16:5001', '/v1/todo');

      var response = await http.get(url);
      var items = <Todo>[];
      if(response.statusCode == 200)
      {
        var listData = jsonDecode(response.body);
        for(var itemsJson in listData)
        {
          items.add(Todo.fromJson(itemsJson));
        }
        return items;
      }
    }catch(e)
    {
      print('Caught Error $e');
    }
    return [];
  }

  Future<void> createItem() async {
    var url = Uri.http('192.168.1.16:5001', '/v1/todo');
  final response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String?>{
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

  Future<void> updateItem(int? id) async {
    String idToString = id.toString();
    var url = Uri.http('192.168.1.16:5001', '/v1/todo/$idToString');
    final response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String?>{
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

  Future<String> deleteItem(int? id) async {
    String idToString = id.toString();
    var url = Uri.http('192.168.1.16:5001', '/v1/todo/$idToString');
    final  response = await http.delete(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      if(response.body.isNotEmpty)
        {
          return response.body;
          print("Deleted");
        }
    }
    else {
      throw Exception('Failed to delete list item.');
    }
    return "";
  }
}