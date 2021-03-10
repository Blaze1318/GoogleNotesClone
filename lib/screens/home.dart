import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:http/http.dart';
import 'package:todo_list/screens/edit.dart';
import 'package:todo_list/screens/editItem.dart';
import 'package:todo_list/services/request.dart';
import 'package:todo_list/services/todo.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}


class _HomeState extends State<Home> {
  List<Todo?> _list = <Todo>[];
  List<Todo?> _listForDisplay = <Todo>[];
  ApiCalls call = new ApiCalls();
  GlobalKey<RefreshIndicatorState>? refresh;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    call.getData().then((value) {
      setState(() {
        _list.addAll((value));
        _listForDisplay = _list;
      });
    });
    refresh = GlobalKey<RefreshIndicatorState>();
    super.initState();
  }

  Future<Null> refreshList() async{
    await Future.delayed(Duration(seconds: 1));
    call.getData().then((value) {
      setState(() {
        _list.clear();
        _list.addAll(value);
        _listForDisplay = _list;
      });
    });
    return null;
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      key:_scaffoldKey,
      body: SafeArea(
        child: RefreshIndicator(
          key: refresh,
          child: Container(
            color: Colors.grey[900],
            child: ListView.builder(
              itemCount: _listForDisplay.length+1,
              itemBuilder: (context,index){
                return index == 0? _searchBar() : _listItem(index-1);
              },
            ),
          ),
          onRefresh: () async {
              await refreshList();
          },
        )
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        child: Icon(Icons.add,
        color: Colors.red[800],),
        backgroundColor: Colors.grey[800],
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context){
            return Edit();
          })).then((value) => setState(() {
            refreshList();
          }));
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
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30)
            ),
            hintText: 'Search...',
            fillColor: Colors.grey[600],
            filled: true,
          ),
          onChanged: (text){
            text = text.toLowerCase();
            setState(() {
              _listForDisplay = _list.where((item) {
                var itemTitle = item!.title!.toLowerCase();
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
      child: Dismissible(
        key: UniqueKey(),
        background: deleteBG(),
        onDismissed: (direction) async{
          await call.deleteItem(_listForDisplay[index]!.id);
          setState(() {
            _listForDisplay.removeAt(index);
          });
        },
        child: Card(
          color: Colors.grey[500],
          child: ListTile(
            title: Text(_listForDisplay[index]!.title ?? ''),
            subtitle: Text(_listForDisplay[index]!.description ?? ''),
            onTap: () {
              Todo sendTodo = Todo(id:  _listForDisplay[index]!.id,title: _listForDisplay[index]!.title,description: _listForDisplay[index]!.description);
              Navigator.of(context).push(new MaterialPageRoute(builder: (context) => EditItem(),settings: RouteSettings(
                  arguments: sendTodo
              ))).then((value) => setState(() => {
                refreshList()
              }));
            },
          ),
        ),
      ),
    );
  }

  Widget deleteBG()
  {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 10),
      color: Colors.red,
      child: Icon(Icons.delete,color: Colors.white),
    );
  }


}


