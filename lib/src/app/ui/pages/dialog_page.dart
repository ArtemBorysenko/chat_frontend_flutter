import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:chat_frontend_flutter/src/app/core/blocs/dialog_bloc.dart';
import 'package:chat_frontend_flutter/src/app/core/blocs/message_bloc.dart';

class DialogPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _DialogPage();
  
}

class _DialogPage extends State<DialogPage> {

  

  _socketStatus() {
    print('socket run');
  }


  @override
  Widget build(BuildContext context) {

  final DialogBloc dialogBloc = Provider.of<DialogBloc>(context);
  final MessageBloc messageBloc = Provider.of<MessageBloc>(context);

  String dialogId = '';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
              Icons.arrow_back,
          ), 
          onPressed: () => Navigator.pop(context) 
          ),
        title: Text("Dialog"),
        actions: <Widget>[
            IconButton(icon: Icon(Icons.more_vert), onPressed: () => null )
          ],
      ),
      body: Container(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Expanded( 
                 child: StreamBuilder(
                stream: dialogBloc.outDialogBloc,
                builder: (BuildContext context, snapshot){  
                   if (!snapshot.hasData) return Text('Loading...');
                    return ListView(
                      children: snapshot.data.map<Widget>((item) {
                        dialogId = item.dialog;
                        return ListTile(
                           leading: CircleAvatar(
                            // backgroundImage: ,
                            ),
                          title: Text(item.user),
                          subtitle: Text(item.text),
                        );
                        }).toList()
                    );
                })
          ),
          TextField(
                    decoration: InputDecoration(
                      hintText: "Type in here"
                    ),
                    onSubmitted: (str){
                      messageBloc.create(dialogId, str);
                      print('STR: $str');
                    },
                  ),
                  ]
                ),
            )
          )
        ),
        floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.check),
        onPressed: () {
          dialogBloc.getDialogBloc.add(null);
        },
      ),
    );
  }
}