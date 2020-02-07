import 'dart:async';
import 'dart:collection';

import 'package:chat_frontend_flutter/src/app/data/api/api.dart';

class ApplicationBloc {

  ///
  /// Synchronous Stream to handle the provision of the movie genres
  ///
  StreamController<List> _syncController = StreamController<List>.broadcast();
  Stream<List> get outMovieGenres => _syncController.stream;

  /// 
  StreamController<List> _cmdController = StreamController<List>.broadcast();
  StreamSink get getMovieGenres => _cmdController.sink;

  ApplicationBloc() {
    api.movieGenres().then((list) {
      _genresList = list;
    });

    _cmdController.stream.listen((_){
      _syncController.sink.add(UnmodifiableListView(_genresList.genres));
    });
  }

  void dispose(){
    _syncController.close();
    _cmdController.close();
  }

  dynamic _genresList;
 
}
