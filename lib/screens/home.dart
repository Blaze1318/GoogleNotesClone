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
  bool flag = false;
  GlobalKey<RefreshIndicatorState>? refresh;
  int _selectedIndex = 0;
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
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
      ),
      drawer: Drawer(
        child:Container(
          color: Colors.grey[800],
          child: ListView(
            children: <Widget> [
              DrawerHeader(
                child:  Text("Google Keep Clone",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                ),
              ),
              ListTile(
                tileColor: Colors.grey[500],
                selectedTileColor: Colors.grey[700],
                leading: Icon(Icons.lightbulb_outline_sharp,color: Colors.white,),
                title: Text("Notes",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
              )
            ]
          ),
        ),
      ),
      key:_scaffoldKey,
      body: SafeArea(
        child: RefreshIndicator(
          key: refresh,
          child: Container(
            color: Colors.grey[900],
            child: Column(
              children: [
                _searchBar(),
                SizedBox(height: 15),
                Expanded(
                  child: GridView.builder(
                            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                childAspectRatio: 3 / 2,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20),
                            itemCount: _listForDisplay.length,
                            itemBuilder: (context,index){
                              return _listItem(index);
                            }),
                ),
              ],
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
        padding: const EdgeInsets.all(20.0),
        child: TextField(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(20),
            hintText: 'Search...',
            filled: true,
            fillColor: Colors.grey[800]
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
            subtitle: Text(_listForDisplay[index]!.description ?? '',
              maxLines: 4,
            ),
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


