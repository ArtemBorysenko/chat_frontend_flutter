import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_frontend_flutter/src/app/core/blocs/dialogs_bloc.dart';
import 'package:chat_frontend_flutter/src/app/ui/pages/home_page.dart';
//ЧЕ за говно это не js.Пиши на js
Future<void> main() async {
  
  return runApp(
    MultiProvider(
  providers: [
    Provider<DialogsBloc>(create: (context) => DialogsBloc()),
  ],
   child: MyApp(),
) 
  );
} 

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
