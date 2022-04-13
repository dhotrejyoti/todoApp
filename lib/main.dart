// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

void main() {
  runApp(Todo());
}

class Todo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: TodoList());
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final List<String> _todoList = <String>[];

  final TextEditingController _textFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.lime,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text(
              'To-Do List',
            ),
          ),
          body: Container(
              color: Colors.limeAccent,
              child: Card(
                  color: Colors.white10,
                  shape: RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  child: ListView(children: _getItems()))),
          floatingActionButton: FloatingActionButton(
              onPressed: () => _displayDialog(context),
              tooltip: 'Add Item',
              child: Icon(Icons.add)),
        ));
  }

  void _addTodoItem(String title) {
    setState(() {
      _todoList.add(title);
    });
    _textFieldController.clear();
  }

  Widget _buildTodoItem(String title) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
          margin: const EdgeInsets.all(5.0),
          child: ListTile(title: Text(title))),
    );
  }

  Future<Future> _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Add a task to your list'),
            content: TextField(
              controller: _textFieldController,
              decoration: const InputDecoration(hintText: 'Enter task here'),
            ),
            actions: <Widget>[
              FlatButton(
                child: const Text('ADD'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _addTodoItem(_textFieldController.text);
                },
              ),
              FlatButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  List<Widget> _getItems() {
    final List<Widget> _todoWidgets = <Widget>[];
    for (String title in _todoList) {
      _todoWidgets.add(_buildTodoItem(title));
    }
    return _todoWidgets;
  }
}
