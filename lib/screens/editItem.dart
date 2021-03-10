import 'package:flutter/material.dart';
import 'package:todo_list/services/request.dart';
import 'package:todo_list/services/todo.dart';

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
                    initialValue: todo.title,
                    decoration: InputDecoration(
                        hintText: 'Title',
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
    );
  }
}
