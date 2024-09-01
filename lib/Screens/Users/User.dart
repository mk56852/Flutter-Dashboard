import 'package:flutter/material.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white30,
        constraints: BoxConstraints(maxWidth: 300, maxHeight: 10),
        child: Container(
          color: Colors.blue,
          height: 50,
          width: 1500,
          child: Text("dd"),
        ));
  }
}
