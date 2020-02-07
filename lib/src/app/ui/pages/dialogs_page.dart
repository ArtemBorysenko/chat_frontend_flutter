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
  dialogsBloc.dispose();

    return Scaffold(
      key: _scaffoldKey,
      body: Center(
        child: Column(
          children: <Widget>[
          Expanded(
            child: StreamBuilder(
              stream: dialogsBloc.outDialogsBloc,
              builder: (BuildContext context, snapshot){
                //TODO
                    })
          ),
        ],
        ),
    ),
    );
  }
}