import 'package:flutter/material.dart';

class Edit extends StatefulWidget {
  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        elevation: 0,
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
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Description'
                    ),
                    maxLines: null,
                    expands: true,
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
