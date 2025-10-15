import 'package:flutter/material.dart';
import 'package:point_of_sales/Models/Category.dart';
import 'package:point_of_sales/Utils/AppColors.dart';

class CategoryList extends StatelessWidget {
  List<Category> categories;
  CategoryList({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Wrap(
        alignment: WrapAlignment.start,
        children:
            categories.map((item) => CategoryWidget(category: item)).toList(),
      ),
    );
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
