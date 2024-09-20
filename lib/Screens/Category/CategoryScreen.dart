import 'package:flutter/material.dart';
import 'package:point_of_sales/Screens/Category/widgets/AddCategoryModal.dart';
import 'package:point_of_sales/Screens/Category/widgets/CategoryTable.dart';
import 'package:point_of_sales/SharedWidget/AppButton.dart';
import 'package:point_of_sales/SharedWidget/PageTitle.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        constraints: BoxConstraints(minHeight: 500, maxHeight: 600),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                    child: Pagetitle(
                        title: "Category", path: "Home  >  cateogries Table")),
                Expanded(
                    child: Align(
                  alignment: Alignment.centerRight,
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 8,
                    children: [
                      SizedBox(
                        width: 190,
                        child: AppButtonWithIcon(
                          text: "Add Category",
                          onPress: () => showModalBottomSheet<void>(
                            isScrollControlled: true,
                            context: context,
                            builder: (BuildContext context) {
                              return AddCategoryModal();
                            },
                          ),
                          icon: Icons.add_box_outlined,
                        ),
                      ),
                    ],
                  ),
                ))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(child: CategoryTable())
          ],
        ),
      ),
    );
  }
}
