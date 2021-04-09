import 'package:flutter/material.dart';
import 'package:todo_list/screens/modal_settings.dart';
import 'package:todo_list/services/request.dart';


class Edit extends StatefulWidget {
  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  final _formKey = GlobalKey<FormState>();
  String? title;
  String? description;

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        elevation: 0,
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () async{
          if((title != null  )|| (description != null))
          {
            _apiCalls = ApiCalls(title: title,description: description);
            await _apiCalls.createItem();
            Navigator.pop(context);

          }
          else{
            Navigator.pop(context);
          }
        }),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: null,
              child: Icon(Icons.push_pin_outlined),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right:15),
            child: GestureDetector(
              onTap: null,
              child: Icon(Icons.add_alert_outlined),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right:15),
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
                  decoration: InputDecoration(
                    hintText: 'Title'
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
            IconButton(icon: Icon(Icons.add_box_outlined), onPressed: () {

            },),
            IconButton(icon: Icon(Icons.menu), onPressed: () {
              _showSettingsPanel();
            },),
          ],
        ),
      ),
    );
  }
}
