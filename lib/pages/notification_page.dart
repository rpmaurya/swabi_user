import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);
static const route = "/notification";
  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context)?.settings.arguments;
    return  Scaffold(
      appBar: AppBar(title: const Text("Push Notification",
      )
        ,),
      body: const Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           // Text("${message?.notification?.title}"),
           // Text("${message.notification?.body}"),
           // Text("${message.data}"),
        ],
      ),),
    );
  }
}
