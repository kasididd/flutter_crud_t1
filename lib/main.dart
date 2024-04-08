import 'package:crud_t1/model/book_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/crud_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => CrudBloc(),
        child: const CrudPage(),
      ),
    );
  }
}

class CrudPage extends StatefulWidget {
  const CrudPage({super.key});

  @override
  State<CrudPage> createState() => _CrudPageState();
}

class _CrudPageState extends State<CrudPage> {
  List<BookModel>? books;
  @override
  void initState() {
    context.read<CrudBloc>().add(CrudReadEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              context.read<CrudBloc>().add(
                    CrudCreateEvent(
                      book: BookModel(
                          id: 200, title: 'Create', body: 'body', userId: 1),
                    ),
                  );
            },
            child: const Icon(Icons.create),
          ),
          FloatingActionButton(
            onPressed: () {
              context.read<CrudBloc>().add(CrudReadEvent(2));
            },
            child: const Icon(Icons.read_more),
          ),
          FloatingActionButton(
            onPressed: () {
              context.read<CrudBloc>().add(CrudUpdateEvent(
                    book: BookModel(
                        id: 2, title: 'Update', body: 'body', userId: 1),
                  ));
            },
            child: const Icon(Icons.update),
          ),
          FloatingActionButton(
            onPressed: () {
              context.read<CrudBloc>().add(CrudDeleteEvent(1));
            },
            child: const Icon(Icons.delete),
          ),
        ],
      ),
      body: BlocBuilder<CrudBloc,CrudState>(
        buildWhen: (previous, current) {
          late Widget msg;
          if (current is CrudCreateState) {
            msg = const Text('Create Success');
          }
          if (current is CrudUpdateState) {
            msg = const Text('Update Success');
          }
          if (current is CrudDeleteState) {
            msg = const Text('Delete Success');
          }
          if (current is! CrudReadState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: msg));
          }else{
            books = current.books;
          }
          return true;
        },
        builder: (context, state) {
          if (books == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: books!.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(books![index].title),
                subtitle: Text(books![index].body),
              );
            },
          );
        },
      ),
    );
  }
}
