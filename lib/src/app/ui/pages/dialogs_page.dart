import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_frontend_flutter/src/app/core/blocs/dialogs_bloc.dart';
import 'package:chat_frontend_flutter/src/app/models/dialogs_model.dart';

class DialogsPage extends StatefulWidget {
  static String tag = "Login Page";
  
  @override
  State<StatefulWidget> createState() => _DialogsPageState();

}

class _DialogsPageState extends State<DialogsPage> {
  
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context){

  final DialogsBloc dialogsBloc = Provider.of<DialogsBloc>(context);

    return Scaffold(
      key: _scaffoldKey,
      body: Center(
        child: Column(
          children: <Widget>[
          Expanded( 
            child: StreamBuilder(
              initialData: dialogsBloc.initionalData(),
              stream: dialogsBloc.outDialogsBloc,
              builder: (BuildContext context, snapshot){
                print(snapshot.data);
                 if (!snapshot.hasData) return new Text('Loading...');
                  return new ListView(
                    children: snapshot.data.map<Widget>((item) {
                      return new ListTile(
                        title: new Text(item.author),
                        subtitle: new Text(item.partner),
                      );
                      }).toList()
                  );
              })
          ),
          
        ],
        ),
    ),
    floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.check),
        onPressed: () {
          dialogsBloc.getDialogsBloc.add(null);
        },
      ),
    );
  }
}