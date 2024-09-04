import 'package:flutter/material.dart';
import 'package:point_of_sales/SharedWidget/AppContainer.dart';

class AppSearchBar extends StatefulWidget {
  String hintText;
  Function onChange;
  AppSearchBar({super.key, required this.hintText, required this.onChange});

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  @override
  Widget build(BuildContext context) {
    return AppContainer(
      height: 40,
      constraints: BoxConstraints(minWidth: 250),
      child: TextField(
        onChanged: (value) => widget.onChange(value),
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            hintText: widget.hintText,
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey, fontSize: 13)),
      ),
    );
  }
}
