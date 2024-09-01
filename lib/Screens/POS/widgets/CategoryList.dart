import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:point_of_sales/Models/Category.dart';
import 'package:point_of_sales/SharedWidget/AppContainer.dart';
import 'package:point_of_sales/Utils/AppColors.dart';

List categories = [
  Category(name: "Categoryazazaze 1", icon: FontAwesomeIcons.addressCard),
  Category(name: "Category 2", icon: FontAwesomeIcons.addressCard),
  Category(name: "Cate 3", icon: FontAwesomeIcons.addressCard),
  Category(name: "Category 4", icon: FontAwesomeIcons.addressCard),
  Category(name: "Categaaaaaaa 5", icon: FontAwesomeIcons.addressCard),
  Category(name: "Category 6", icon: FontAwesomeIcons.addressCard),
  Category(name: "Category 7", icon: FontAwesomeIcons.addressCard),
];

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children:
              categories.map((item) => CategoryWidget(category: item)).toList(),
        ));
  }
}

class CategoryWidget extends StatefulWidget {
  Category category;
  CategoryWidget({super.key, required this.category});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  Color color = Colors.black;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          color = Appcolors.mainBlue;
        });
      },
      onExit: (event) {
        setState(() {
          color = Colors.black;
        });
      },
      child: Padding(
        padding: EdgeInsets.only(right: 15),
        child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Appcolors.borderColor, width: 1),
                borderRadius: BorderRadius.circular(6)),
            padding: EdgeInsets.symmetric(horizontal: 10),
            constraints:
                BoxConstraints(maxWidth: 150, minWidth: 30, minHeight: 50),
            child: Row(
              children: [
                SizedBox(
                  height: 40,
                  width: 40,
                  child: Image.asset(
                    "assets/images/choco.png",
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Text(
                  widget.category.name,
                  style: TextStyle(color: color),
                ))
              ],
            )),
      ),
    );
  }
}
