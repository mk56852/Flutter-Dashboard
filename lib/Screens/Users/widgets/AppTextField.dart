import 'package:flutter/material.dart';
import 'package:point_of_sales/SharedWidget/AppContainer.dart';

class AppTextField extends StatelessWidget {
  String text;
  AppTextField({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            text,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        AppContainer(
            height: 45,
            child: TextField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.article_outlined),
                  hintText: text,
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 15)),
            )),
      ],
    );
  }
}
