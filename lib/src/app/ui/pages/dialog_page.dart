import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:chat_frontend_flutter/src/app/core/blocs/dialog_bloc.dart';
import 'package:chat_frontend_flutter/src/app/core/blocs/dialogs_bloc.dart';
import 'package:chat_frontend_flutter/src/app/core/blocs/message_bloc.dart';
import 'package:chat_frontend_flutter/src/app/core/database/models/message_model.dart';

class DialogPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DialogPage();
}

class _DialogPage extends State<DialogPage> {

   DialogBloc dialogBloc;
   DialogsBloc dialogsBloc;

  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = new ScrollController();
    List<Widget> _messages = <Widget>[new Text('hello'), new Text('world')];
    dialogBloc = Provider.of<DialogBloc>(context);
    dialogsBloc = Provider.of<DialogsBloc>(context);

    // final MessageBloc messageBloc = Provider.of<MessageBloc>(context);

    String dialogId = '';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
            ),
            onPressed: () => Navigator.pop(context)),
        title: Text("Dialog"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.more_vert), onPressed: () => null)
        ],
      ),
      body: Container(
          child: Center(
              child: Padding(
        padding: const EdgeInsets.all(4.0),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
          Expanded(
            //  child: StreamProvider<List<MessageModel>>.value(
            //   value:
            //   child: ,
            //  ),
              child: StreamBuilder<List<MessageModel>>(
                  // initialData: dialogsBloc. initial 10 messages,
                  stream: dialogBloc.outDialogBloc,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<MessageModel>> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView.builder(
                      controller: _scrollController,
                  reverse: true,
                  shrinkWrap: true,
                  
                      itemBuilder: (BuildContext contex, int index) {
                        dialogId = snapshot.data[index].dialog;
                        return Dismissible(
                          key: Key(snapshot.data[index].user),
                          onDismissed: (direction) {
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "${snapshot.data[index].id} dismissed")
                                    ));
                          },
                          background: Container(color: Colors.blue),
                          child: ListTile(
                            title: Text('${snapshot.data[index].user}'),
                            subtitle: Text('${snapshot.data[index].text}'),
                            
                          ),
                        );
                      },
                      itemCount:
                          (snapshot.data == null ? 0 : snapshot.data.length),
                    );
                  })
                  ),
          TextField(
            autofocus: false,
            decoration: InputDecoration(hintText: "Type in here"),
            onSubmitted: (str) {
              dialogBloc.create(dialogId, str);
            },
          ),
        ]),
      )
      )
      ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.add),
        onPressed: () {
          setState(() {
            _messages.insert(0, new Text("message ${_messages.length}"));
          });
          _scrollController.animateTo(
            0.0,
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 300),
          );
        }
      ),
    );
  }

  @override
  void dispose() {
    dialogBloc.dispose();
    super.dispose();
}
}
