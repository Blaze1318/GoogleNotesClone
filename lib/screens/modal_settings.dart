import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/services/request.dart';
import 'package:share/share.dart';

class ModalSettings extends StatefulWidget {
  final String? title;
  final String? description;
  final int? id;
  ModalSettings({Key? key,this.id,this.title,this.description}) : super(key: key);
  @override
  _ModalSettingsState createState() => _ModalSettingsState();
}


class _ModalSettingsState extends State<ModalSettings> {

  late ApiCalls apiCalls;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[800],
      child: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.delete_forever,color: Colors.white,),
            title: Text("Delete",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: (){
              showDialog(context: context, builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)
                ),
                title: Text("Delete Note"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget> [
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget> [
                          ElevatedButton(
                            onPressed: () async{
                              if(widget.id != null)
                                {
                                  apiCalls = new ApiCalls();
                                  await apiCalls.deleteItem(widget.id);
                                  Navigator.of(context).popAndPushNamed("/");
                                }
                              else{
                                Navigator.pop(context);
                              }
                            }, child: Text("Yes"),
                          ),
                          SizedBox(width: 20.0),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            }, child: Text("No"),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ));
            },
          ),
          ListTile(
            leading: Icon(Icons.copy,color: Colors.white,),
            title: Text("Make A Copy",
              style: TextStyle(
                  color: Colors.white
              ),
            ),
            onTap: (){
              showDialog(context: context, builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)
                ),
                title: Text("Copy?"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget> [
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget> [
                          ElevatedButton(
                            onPressed: () async{
                             if(widget.title != null || widget.description != null)
                               {
                                 apiCalls = new ApiCalls(title: widget.title,description: widget.description);
                                 await apiCalls.createItem();
                                 Navigator.of(context).popAndPushNamed("/");
                               }
                             else{
                               Navigator.pop(context);
                             }
                            }, child: Text("Yes"),
                          ),
                          SizedBox(width: 20.0),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            }, child: Text("No"),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ));
            },
          ),
          ListTile(
            leading: Icon(Icons.share_outlined,color: Colors.white,),
            title: Text("Share",
              style: TextStyle(
                  color: Colors.white
              ),
            ),
            onTap: (){
              showDialog(context: context, builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)
                ),
                title: Text("Share"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget> [
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget> [
                          ElevatedButton(
                            onPressed: () async{
                              if(widget.description != null)
                                {
                                  await Share.share(widget.description!);
                                  Navigator.pop(context);
                                }
                              else{
                                Navigator.pop(context);
                              }

                            }, child: Text("Yes"),
                          ),
                          SizedBox(width: 20.0),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            }, child: Text("No"),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ));
            },
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
