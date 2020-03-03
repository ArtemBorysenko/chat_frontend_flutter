import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:chat_frontend_flutter/src/app/core/blocs/dialog_bloc.dart';
import 'package:chat_frontend_flutter/src/app/core/blocs/message_bloc.dart';
import 'package:chat_frontend_flutter/src/app/models/message_model.dart';

class DialogPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DialogPage();
}

class _DialogPage extends State<DialogPage> {

   DialogBloc dialogBloc;

  @override
  Widget build(BuildContext context) {
    dialogBloc = Provider.of<DialogBloc>(context);
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
              child: StreamBuilder<List<MessageModel>>(
                  stream: dialogBloc.outDialogBloc,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<MessageModel>> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView.builder(
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
                  })),
          TextField(
            decoration: InputDecoration(hintText: "Type in here"),
            onSubmitted: (str) {
              dialogBloc.create(dialogId, str);
            },
          ),
        ]),
      ))),
    );
  }

  @override
  void dispose() {
    dialogBloc.dispose();
    super.dispose();
}
}
