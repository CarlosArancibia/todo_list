import 'package:flutter/material.dart';

class NewTodoPage extends StatefulWidget {
  const NewTodoPage({Key? key}) : super(key: key);

  @override
  State<NewTodoPage> createState() => _NewTodoPageState();
}

class _NewTodoPageState extends State<NewTodoPage> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(243, 80, 170, 192),
        title: const Text(
          "Nueva Tarea",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage('images/new-task.png'),
              width: 120.0,
            ),
            const SizedBox(height: 15.0),
            TextField(
              autofocus: true,
              cursorColor: Colors.cyan[700],
              controller: _controller,
              decoration: const InputDecoration(
                  hintText: 'Escribe acá una nueva tarea...',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black26),
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(243, 80, 170, 192),
                          width: 2.5))),
              onSubmitted: (task) {
                Navigator.of(context).pop(_controller.text);
              },
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(_controller.text);
              },
              child: const Text("Agregar"),
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(243, 80, 170, 192),
                elevation: 7.0,
                textStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
