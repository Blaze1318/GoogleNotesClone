import 'package:flutter/material.dart';
import 'package:todo_list/services/request.dart';
import 'package:todo_list/services/todo.dart';

import 'modal_settings.dart';

class EditItem extends StatefulWidget {
  @override
  _EditItemState createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  final _formKey = GlobalKey<FormState>();
  String? title = '';
  String? description = '';

  late ApiCalls _apiCalls;
  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel()
    {
      showModalBottomSheet(context: context, builder:(context) {
        return Container(
          child: ModalSettings(),
        );
      });
    }
    final Todo todo = ModalRoute.of(context)!.settings.arguments as Todo;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        elevation: 0,
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () async{
          if(todo != null)
          {
            if((title != null  )|| (description != null))
            {
              if(title != null && description == null)
                {
                  description =  todo.description;
                  print("Id: ${todo.id}");
                  _apiCalls = ApiCalls(title: title,description: description);
                  await _apiCalls.updateItem(todo.id);
                  Navigator.of(context).pop();
                }
              else if(title == null  && description != null)
              {
                title =  todo.title;
                print("Id: ${todo.id}");
                _apiCalls = ApiCalls(title: title,description: description);
                await _apiCalls.updateItem(todo.id);
                Navigator.of(context).pop();
              }
              else{
                print("Id: ${todo.id}");
                title = todo.title;
                description = todo.description;
                _apiCalls = ApiCalls(title: title,description: description);
                await _apiCalls.updateItem(todo.id);
                Navigator.of(context).pop();
              }
            }
            else{
              print("title: $title \n description: $description");
              Navigator.of(context).pop();
            }
          }
        }),
        actions: <Widget>[
         Padding(
             padding: EdgeInsets.all(15),
             child: GestureDetector(
               onTap: null,
               child: Icon(Icons.push_pin_outlined),
             ),
         ),
          Padding(
            padding: EdgeInsets.all(15),
            child: GestureDetector(
              onTap: null,
              child: Icon(Icons.add_alert_outlined),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: GestureDetector(
              onTap: null,
              child: Icon(Icons.move_to_inbox_sharp),
            ),
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
                    initialValue: todo.title,
                    decoration: InputDecoration(
                        hintText: 'Title',
                    ),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30
                    ),
                    onChanged: (val){
                      setState(() => title = val);
                    },
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Description'
                      ),
                      initialValue: todo.description,
                      maxLines: null,
                      expands: true,
                      style: TextStyle(
                          color: Colors.white,
                        fontSize: 20
                      ),
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
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey[800],
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(icon: Icon(Icons.add_box_outlined), onPressed: () {},),
            IconButton(icon: Icon(Icons.menu), onPressed: () {
              _showSettingsPanel();
            },),
          ],
        ),
      ),
    );
  }
}
