import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo_list/services/request.dart';
import 'package:todo_list/services/todo.dart';
class Edit extends StatefulWidget {
  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  ApiCalls _apiCalls;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        elevation: 0,
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
          setState(() {
            if((title?.isNotEmpty ?? true  )|| (description?.isNotEmpty ?? true))
              {
                _apiCalls = ApiCalls(title: title,description: description);
                _apiCalls.createItem();
                Navigator.pop(context);
              }
            else{
              Navigator.pop(context);
            }
          });
        }),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: null,
              icon: Icon(Icons.push_pin_outlined,
              color: Colors.black,),
              label: Text(''),
          ),
          FlatButton.icon(
              onPressed: () => null,
              icon: Icon(Icons.add_alert_outlined,color: Colors.black,),
              label: Text('')
          ),
          FlatButton.icon(
              onPressed: null,
              icon: Icon(Icons.move_to_inbox_sharp,color: Colors.black,),
              label: Text(''),
          ),
        ],
      ),
      body: Container(
        color: Colors.grey[900],
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0,16.0,8.0,0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget> [
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Title'
                  ),
                  onChanged: (val){
                    setState(() => title = val);
                  },
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Description'
                    ),
                    maxLines: null,
                    expands: true,
                    onChanged: (val){
                      setState(() => description = val);
                    },
                  ),
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}
