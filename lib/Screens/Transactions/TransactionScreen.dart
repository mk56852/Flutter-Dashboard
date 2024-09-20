import 'package:flutter/material.dart';
import 'package:point_of_sales/Screens/Transactions/widgets/transactionTable.dart';
import 'package:point_of_sales/Screens/Users/widgets/AddUserModal.dart';
import 'package:point_of_sales/SharedWidget/AppButton.dart';
import 'package:point_of_sales/SharedWidget/PageTitle.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

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
                        title: "Transactions Management",
                        path: "Home  >  Transaction Table")),
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
                          text: "Add Transaction",
                          onPress: () => showModalBottomSheet<void>(
                            isScrollControlled: true,
                            context: context,
                            builder: (BuildContext context) {
                              return AddUserModal();
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
                ))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(child: TransactionTable())
          ],
        ),
      ),
    );
  }
}
