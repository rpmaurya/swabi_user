import 'package:flutter/material.dart';

class HomeScreen1 extends StatelessWidget {
  const HomeScreen1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text("Push Notification",
      ),
      ),
      body: const Center(
        child: Text("Home Page"),),
    );
  }
}
