import 'package:flutter/material.dart';
import 'package:point_of_sales/Models/Category.dart';
import 'package:point_of_sales/Utils/AppColors.dart';

List categories = [
  Category(id: 1, name: "Categoryazazaze 1", imageUrl: "assets/"),
  Category(id: 1, name: "Category 2", imageUrl: "assets/"),
  Category(id: 1, name: "Cate 3", imageUrl: "assets/"),
  Category(id: 1, name: "Category 4", imageUrl: "assets/"),
  Category(id: 1, name: "Categaaaaaaa 5", imageUrl: "assets/"),
  Category(id: 1, name: "Category 6", imageUrl: "assets/"),
  Category(id: 1, name: "Category 7", imageUrl: "assets/"),
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
        padding: const EdgeInsets.only(right: 15),
        child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Appcolors.borderColor, width: 1),
                borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.symmetric(horizontal: 10),
            constraints: const BoxConstraints(
                maxWidth: 150, minWidth: 30, minHeight: 50),
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
                const SizedBox(
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
