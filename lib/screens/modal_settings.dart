import 'package:flutter/material.dart';

class ModalSettings extends StatefulWidget {
  @override
  _ModalSettingsState createState() => _ModalSettingsState();
}

class _ModalSettingsState extends State<ModalSettings> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[800],
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.delete_forever,color: Colors.white,),
            title: Text("Delete",
              style: TextStyle(
                color: Colors.white
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.copy,color: Colors.white,),
            title: Text("Make A Copy",
              style: TextStyle(
                  color: Colors.white
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.share_outlined,color: Colors.white,),
            title: Text("Send",
              style: TextStyle(
                  color: Colors.white
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person_add_alt,color: Colors.white,),
            title: Text("Collaborator",
              style: TextStyle(
                  color: Colors.white
              ),
            ),
          )
        ],
      ),
    );
  }
}
