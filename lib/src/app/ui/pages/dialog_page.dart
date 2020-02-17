import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:web_socket_channel/io.dart';
import  'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


import 'package:chat_frontend_flutter/src/app/core/blocs/dialog_bloc.dart';

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
// // --> GET /socket.io/?EIO=3&transport=polling 404 1ms - 10.0.2.2 no proxy and with
// IO.Socket socket = IO.io('http://10.0.2.2:3003');
// // socket.emit('connect');


// socket.emit('send_message', (_) {
//      print('connection');
//      socket.emit('send_message', _socketStatus);
//     });

//     socket.emit('send_message', (_) {
//      print('connect');
//      socket.emit('send_message', _socketStatus);
//     });
    
//      print('BuildContext _DialogPage');

//     socket.emit('send_message', (_) => print('disconnect'));

//     socket.emit('disconnect', (_) => print('disconnect'));

//     SocketIO socketIO;
// //GET /socket.io/?EIO=3&userId=21031&transport=websocket 404 1ms -
//     _connectSocket01() { 
// 	 socketIO = SocketIOManager()
//    .createSocketIO(
//      "http://10.0.2.2:3003",
//       "/",
//       query: "userId=21031",
//       socketStatusCallback: _socketStatus); 

// 	socketIO.init(); 

// 	socketIO.subscribe("send_message", _socketStatus); 

//   socketIO.sendMessage("send_message", _socketStatus);

// 	socketIO.connect(); 

// }

// _connectSocket01();

  final DialogBloc dialogBloc = Provider.of<DialogBloc>(context);

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