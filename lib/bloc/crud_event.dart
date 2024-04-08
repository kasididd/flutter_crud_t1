part of 'crud_bloc.dart';

@immutable
class CrudEvent {}
class CrudCreateEvent  extends CrudEvent{
  final BookModel book;
  CrudCreateEvent({required this.book});
}
class CrudReadEvent  extends CrudEvent{
  final int? id;
  CrudReadEvent([ this.id]);
}
class CrudUpdateEvent  extends CrudEvent{
  final BookModel book;
  CrudUpdateEvent({required this.book});
}
class CrudDeleteEvent  extends CrudEvent{
  final int id;
  CrudDeleteEvent(this.id);
}
