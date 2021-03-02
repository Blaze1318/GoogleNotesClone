import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:http/http.dart';
import 'package:todo_list/services/todo.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}


class _HomeState extends State<Home> {

  List<Todo> _list = List<Todo>();
  List<Todo> _listForDisplay = List<Todo>();
  Future<List<Todo>> getData() async
  {
    try{
      var response = await get('http://192.168.1.16:8000/items/');
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData().then((value) {
      setState(() {
        _list.addAll(value);
        _listForDisplay = _list;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.grey[900],
          child: ListView.builder(
            itemCount: _listForDisplay.length+1,
            itemBuilder: (context,index){
              return index == 0? _searchBar() : _listItem(index-1);
            },
          ),
        )
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        child: Icon(Icons.add,
        color: Colors.red[800],),
        backgroundColor: Colors.grey[800],
        onPressed: (){
          Navigator.pushNamed(context,'/edit');
        },
      ),
    );
  }

  _searchBar()
  {
      return Padding(
        padding: const EdgeInsets.all(32.0),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search...',
          ),
          onChanged: (text){
            text = text.toLowerCase();
            setState(() {
              _listForDisplay = _list.where((item) {
                var itemTitle = item.title.toLowerCase();
                return itemTitle.contains(text);
              }).toList();
            });
          },
        ),
      );
  }


  _listItem(index)
  {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0,horizontal: 4.0),
      child: Card(
        child: ListTile(
          title: Text(_listForDisplay[index].title),
          subtitle: Text(_listForDisplay[index].description),
        ),
      ),
    );
  }

}


