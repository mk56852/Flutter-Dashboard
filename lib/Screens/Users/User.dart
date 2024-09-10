import 'package:flutter/material.dart';
import 'package:point_of_sales/Layout/Layout.dart';
import 'package:point_of_sales/Screens/Users/AddUserScreen.dart';
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
                        path: "Home    User Management")),
                Expanded(
                    child: Align(
                  alignment: Alignment.centerRight,
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 8,
                    children: [
                      SizedBox(
                        width: 150,
                        child: AppButtonWithIcon(
                          text: "Add User",
                          onPress: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Layout(body: AddUserScreen()))),
                          icon: Icons.add_box_outlined,
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: AppButtonWithIcon(
                          text: "Export",
                          onPress: () => print("hello"),
                          icon: Icons.data_exploration_outlined,
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
            Expanded(
                child: AppPaginatedDataTable(
              allData: List.generate(
                100,
                (index) => {
                  "id": index,
                  "name": "User $index",
                  "age": 20 + index % 50,
                  "profession": "Profession $index",
                  "role": "hello"
                },
              ),
              getFieldFunctions: [
                (data) => data['id'] as int,
                (data) => data['name'] as String,
                (data) => data['age'] as int,
                (data) => data['profession'] as String,
                (data) => data['role'] as String,
              ],
              getColumnValueFunctions: [
                (data) => data['id'].toString(),
                (data) => data['name'],
                (data) => data['age'].toString(),
                (data) => data['profession'],
                (data) => data['role'],
              ],
            ))
          ],
        ),
      ),
    );
  }
}
