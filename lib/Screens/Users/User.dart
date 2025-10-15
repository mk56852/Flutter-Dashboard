import 'package:flutter/material.dart';
import 'package:point_of_sales/Screens/Users/widgets/AddUserModal.dart';
import 'package:point_of_sales/SharedWidget/AppButton.dart';
import 'package:point_of_sales/SharedWidget/PageTitle.dart';
import 'package:point_of_sales/Utils/AppTable.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final GlobalKey<AppDataTableState> _tableKey = GlobalKey<AppDataTableState>();

  void _refreshTable() {
    // Calls a method in AppDataTable to refresh its data.
    _tableKey.currentState?.refreshData();
  }

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
                      path: "Home  >  User Management"),
                ),
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
                            onPress: () => showModalBottomSheet<void>(
                              isScrollControlled: true,
                              context: context,
                              builder: (BuildContext context) {
                                return AddUserModal(
                                  onUserAdded: _refreshTable,
                                );
                              },
                            ),
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
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: AppDataTable(
                key: _tableKey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
