import 'package:http/http.dart';

class Todo
{
  String title;
  String description;

  Todo({this.title,this.description});

  Todo.fromJson(Map<String,dynamic>json)
  {
    title = json['title'];
    description = json['description'];
  }
}