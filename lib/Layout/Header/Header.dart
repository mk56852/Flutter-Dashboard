import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:point_of_sales/Layout/Header/widgets/DropDownWidget.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 50,
      ),
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          headerItemContainer(
            item: Dropdownwidget(
                size: 20,
                iconData: FontAwesomeIcons.gear,
                items: [
                  AppDropDownItem(
                      iconData: FontAwesomeIcons.accusoft,
                      title: "log out",
                      onTap: () => print("hello"))
                ]),
          ),
          SizedBox(
            width: 15,
          ),
          headerItemContainer(
            item: Dropdownwidget(
                size: 20,
                iconData: FontAwesomeIcons.airbnb,
                items: [
                  AppDropDownItem(
                      iconData: FontAwesomeIcons.accusoft,
                      title: "log out",
                      onTap: () => print("hello"))
                ]),
          ),
          SizedBox(
            width: 15,
          ),
        ],
      ),
    );
  }
}

class headerItemContainer extends StatelessWidget {
  Dropdownwidget item;
  headerItemContainer({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      child: Center(
        child: item,
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3), // Shadow color
            spreadRadius: 1, // Spread radius
            blurRadius: 1, // Blur radius
            offset: Offset(-1, 1), // Offset in x and y direction
          ),
        ],
        gradient: LinearGradient(
          colors: [
            Colors.white,
            Color.fromRGBO(121, 227, 214, 1)
          ], // Define the gradient colors
          begin: Alignment.bottomLeft, // Start the gradient from the top-left
          end: Alignment.topRight, // End the gradient at the bottom-right
        ),
      ),
    );
  }
}
