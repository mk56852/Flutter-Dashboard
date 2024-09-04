import 'package:flutter/material.dart';
import 'package:point_of_sales/SharedWidget/AppButton.dart';
import 'package:point_of_sales/SharedWidget/PageTitle.dart';
import 'package:point_of_sales/Utils/AppTable.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

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
                        title: "User Management",
                        path: "home  User Management")),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AppButtonWithIcon(
                      text: "Add User",
                      onPress: () => print("hello"),
                      icon: Icons.add_box_outlined,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    AppButtonWithIcon(
                      text: "Export",
                      onPress: () => print("hello"),
                      icon: Icons.data_exploration_outlined,
                    ),
                  ],
                ))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(child: PaginatedDataTableExample())
          ],
        ),
      ),
    );
  }
}
