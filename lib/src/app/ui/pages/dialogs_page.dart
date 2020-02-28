import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_frontend_flutter/src/app/core/blocs/dialogs_bloc.dart';
import 'package:chat_frontend_flutter/src/app/core/blocs/dialog_bloc.dart';
import 'package:chat_frontend_flutter/src/app/core/blocs/message_bloc.dart';

import 'package:chat_frontend_flutter/src/app/ui/pages/dialog_page.dart';

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
      appBar: AppBar(
          title: Text("Dialogs"),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.search), onPressed: () => null )
          ],
      ),
      drawer: new Drawer(
          child: new ListView(
            children: <Widget>[
              new DrawerHeader(
                child: new Text("Drawer Header"),
                decoration: new BoxDecoration(
                color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      body: Center(
        child: Column(
          children: <Widget>[
          Expanded( 
            child: StreamBuilder(
              // initialData: dialogsBloc.initionalData(),
              stream: dialogsBloc.outDialogsBloc,
              builder: (BuildContext context, snapshot){  
                
                 if (!snapshot.hasData) return new Text('Loading...');
                  return new ListView(
                    children: snapshot.data.map<Widget>((item) {
                      return new ListTile(
                         leading: CircleAvatar(
                          // backgroundImage: ,
                          ),
                        title: new Text('Login: ${item.partner} ${item.id}'),
                        subtitle: new Text(item.lastMessage),
                        onTap: () {
                           _openPageDialog(context, item); },
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

void _openPageDialog(BuildContext context, item) {

    // DialogApi dialogApi = DialogApi();

    // dialogApi.getDialog();

    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) {
        return MultiProvider(
  providers: [
    Provider<DialogBloc>(create: (context) => DialogBloc(item.id)),
    Provider<MessageBloc>(create: (context) => MessageBloc()),
  ],
   child: DialogPage(),
   );
      //   return Provider<DialogBloc>(
      //   create: (context) => DialogBloc(item.id),
      //   dispose: (context, value) => value.dispose(),
      //   child: DialogPage(),
      // );
      }));
  }