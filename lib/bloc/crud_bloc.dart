import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:crud_t1/model/book_model.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
part 'crud_event.dart';
part 'crud_state.dart';

class CrudBloc extends Bloc<CrudEvent, CrudState> {
  final link = 'https://jsonplaceholder.typicode.com/posts/';
  late final Uri uri = Uri.parse(link);
  final headers = {
    'Content-type': 'application/json; charset=UTF-8',
  };
  CrudBloc() : super(CrudInitial()) {
    on<CrudCreateEvent>((event, emit) async {
      await http
          .post(uri, headers: headers, body: jsonEncode(event.book.toJson()))
          .then((value) {
            print('data');
            print(value.body);
        emit(CrudCreateState(BookModel.fromJson(jsonDecode(value.body))));
      });
    });
    on<CrudReadEvent>((event, emit) async {
      late Uri uri;
      if (event.id == null) {
        uri = this.uri;
      } else {
        uri = Uri.parse(link + event.id.toString());
      }
      await http.get(uri).then(
        (value) {
          var res = jsonDecode(value.body);
          if (res is List) {
            emit(CrudReadState(res.map((e) => BookModel.fromJson(e)).toList()));
          } else {
            emit(CrudReadState([BookModel.fromJson(res)]));
          }
        },
      );
    });
    on<CrudUpdateEvent>((event, emit) async {
      Uri uri = Uri.parse(link + event.book.id.toString());
      await http
          .put(uri, headers: headers, body: jsonEncode(event.book.toJson()))
          .then((value) {
            print(value.body);
        emit(CrudUpdateState(BookModel.fromJson(jsonDecode(value.body))));
      });
    });
    on<CrudDeleteEvent>((event, emit) async {
      Uri uri = Uri.parse(link + event.id.toString());
      await http
          .delete(
        uri,
        headers: headers)
          .then((value) {
            print(value.body);
        emit(CrudDeleteState(value.statusCode == 200));
      });
    });
  }
}
