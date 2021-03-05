import 'package:http/http.dart';

class Todo
{
  int id;
  String title;
  String description;

  Todo({this.id,this.title,this.description});

  Todo.fromJson(Map<String,dynamic>json)
  {
    id = json['id'];
    title = json['title'];
    description = json['description'];
  }
}