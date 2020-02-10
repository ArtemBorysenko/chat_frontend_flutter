import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_frontend_flutter/src/app/core/blocs/application_bloc.dart';
import 'package:chat_frontend_flutter/src/app/core/blocs/dialogs_bloc.dart';
import 'package:chat_frontend_flutter/src/app/ui/pages/home_page.dart';

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
      title: 'Movies',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}