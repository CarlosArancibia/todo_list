import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_list_app/src/pages/todo_list.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(
        const Duration(seconds: 2),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const TodoList())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xff50aac0),
                  Color(0xff0d697f),
                ],
              ),
            ),
          ),
          const Positioned(
            child: Text(
              "Todos",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 55,
                  fontWeight: FontWeight.bold),
            ),
            top: 65,
            right: 40,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Image(
                image: AssetImage('images/cover-image.png'),
                width: 370,
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              CircularProgressIndicator(
                color: Color.fromARGB(243, 227, 180, 109),
              ),
              SizedBox(height: 30.0),
              Text(
                "from",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                "Carlos Arancibia",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
              Padding(padding: EdgeInsets.only(bottom: 40.0))
            ],
          )
        ],
      ),
    );
  }
}
