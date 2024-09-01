import 'package:flutter/material.dart';

class Pagetitle extends StatelessWidget {
  String title;
  String path;
  Pagetitle({super.key, required this.title, required this.path});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
          ),
          SizedBox(
            height: 6,
          ),
          Text(
            path,
            style: TextStyle(
                fontSize: 13, fontWeight: FontWeight.w400, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
