import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_frontend_flutter/src/app/core/blocs/dialogs_bloc.dart';
import 'package:chat_frontend_flutter/src/app/core/blocs/dialog_bloc.dart';
import 'package:chat_frontend_flutter/src/app/core/blocs/message_bloc.dart';
import 'package:chat_frontend_flutter/src/app/models/dialogs_model.dart';

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
            child: StreamBuilder<List<DialogModel>>(
              // initialData: dialogsBloc.initionalData(),
              stream: dialogsBloc.outDialogsBloc,
              builder: (BuildContext context,
              AsyncSnapshot<List<DialogModel>> snapshot) {  
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                 }
                  return ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                    // snapshot.data.map<Widget>((item) {
                      return ListTile(
                         leading: CircleAvatar(
                          // backgroundImage: ,
                          ),
                        title: Text('Login: ${snapshot.data[index].partner} ${snapshot.data[index].id}'),
                        subtitle: Text(snapshot.data[index].lastMessage),
                        onTap: () {
                           _openPageDialog(context, snapshot.data[index]); },
                      );
                      // }).toList();
                    },
                    itemCount:
                        (snapshot.data == null ? 0 : snapshot.data.length),
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

// Widget _buildDialogList (
//       BuildContext context,
//       DialogsBloc dialogsBloc,
//       int index,
//       List<DialogModel> dialogsList,
//       Stream<List<DialogModel>> favoritesStream
// ){
//   final DialogModel dialogList =
//         (dialogsList != null && dialogsList.length > index)
//             ? dialogsList[index]
//             : null;

//   if (dialogList == null) {
//       return Center(
//         child: CircularProgressIndicator(),
//       );
//   }

//   return MovieCardWidget(
//         key: Key('movie_${movieCard.id}'),
//         movieCard: movieCard,
//         favoritesStream: favoritesStream,
//         onPressed: () {
//           Navigator
//               .of(context)
//               .push(MaterialPageRoute(builder: (BuildContext context) {
//             return DialogPage(
//               data: movieCard,
//             );
//           }));
//         });

// }

void _openPageDialog(BuildContext context, item) {

    // DialogApi dialogApi = DialogApi();

    // dialogApi.getDialog();

    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) {
        return MultiProvider(
  providers: [
    Provider<DialogBloc>(create: (context) => DialogBloc(item.id)),
    // Provider<MessageBloc>(create: (context) => MessageBloc()),
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