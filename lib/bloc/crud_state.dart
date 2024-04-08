part of 'crud_bloc.dart';

@immutable
class CrudState {}

class CrudInitial extends CrudState {}


class CrudCreateState  extends CrudState{
  final BookModel book;
  CrudCreateState( this.book);
}
class CrudReadState  extends CrudState{
  final List<BookModel> books;
  CrudReadState( this.books);
}
class CrudUpdateState  extends CrudState{
  final BookModel book;
  CrudUpdateState( this.book);
}
class CrudDeleteState  extends CrudState{
  final bool status;
  CrudDeleteState(this.status);
}
