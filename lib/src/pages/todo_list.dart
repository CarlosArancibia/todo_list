import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_list_app/src/pages/new_todo_page.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<Todo> _todos = [];

  @override
  void initState() {
    _readTodos();
    super.initState();
  }

  _readTodos() async {
    try {
      Directory dir = await getApplicationDocumentsDirectory();
      File file = File('${dir.path}/todos.json');
      List json = jsonDecode(await file.readAsString());
      List<Todo> todos = [];
      for (var item in json) {
        todos.add(Todo.fromJson(item));
      }
      super.setState(() {
        _todos = todos;
      });
    } catch (e) {
      setState(() => _todos = []);
    }
  }

  @override
  void setState(fn) {
    super.setState(fn);
    _writeTodos();
  }

  _writeTodos() async {
    try {
      Directory dir = await getApplicationDocumentsDirectory();
      File file = File('${dir.path}/todos.json');
      String jsonText = jsonEncode(_todos);
      await file.writeAsString(jsonText);
    } catch (e) {
      Scaffold(
        body: SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(243, 80, 170, 192),
        centerTitle: true,
        title: const Text(
          "Mis Tareas",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: listTodo(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(243, 227, 180, 109),
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (_) => const NewTodoPage(),
                ),
              )
              .then((task) => setState(() => _todos.add(Todo(task))));
        },
      ),
    );
  }

  listTodo() {
    if (_todos.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Image(
              image: AssetImage('images/empty-task.png'),
              width: 140.0,
            ),
            SizedBox(height: 30.0),
            Text(
              "No tienes tareas",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21.0),
            ),
            SizedBox(height: 10.0),
            Text(
              "Acá podrás ver las tareas que agregues",
              style: TextStyle(color: Colors.black45),
            )
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: _todos.length,
      itemBuilder: (context, index) => Card(
        child: InkWell(
          onTap: () {
            setState(() {
              _todos[index].toogleDone();
            });
          },
          child: ListTile(
            leading: Checkbox(
              activeColor: const Color.fromARGB(243, 80, 170, 192),
              shape: const CircleBorder(),
              value: _todos[index].done,
              onChanged: (checked) {
                setState(() {
                  _todos[index].done = checked!;
                });
              },
            ),
            title: Text(
              _todos[index].task,
              style: TextStyle(
                decoration: (_todos[index].done)
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  _todos.removeAt(index);
                });
              },
              icon: const Icon(Icons.delete),
            ),
          ),
        ),
      ),
    );
  }
}

class Todo {
  String task;
  bool done;
  Todo(this.task) : done = false;

  void toogleDone() => done = !done;

  Todo.fromJson(Map<String, dynamic> json)
      : task = json['task'],
        done = json['done'];

  Map<String, dynamic> toJson() => {
        'task': task,
        'done': done,
      };
}
