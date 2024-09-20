import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:point_of_sales/SharedWidget/AppButton.dart';
import 'package:point_of_sales/SharedWidget/PageTitle.dart';
import 'package:point_of_sales/Utils/AppColors.dart';

class AddUserModal extends StatelessWidget {
  const AddUserModal({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormBuilderState>();
    return Container(
      constraints: BoxConstraints(maxHeight: 600, maxWidth: 1000),
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 50),
      alignment: Alignment.center,
      child: FormBuilder(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Pagetitle(title: "Add User Form", path: ""),
            FormBuilderTextField(
              name: 'firstName',
              decoration: InputDecoration(
                  labelText: 'firstName',
                  prefixIcon: Icon(Icons.person_2_outlined),
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(
                      fontSize: 13, color: Appcolors.secondTextColor)),
              onChanged: (val) {},
            ),
            SizedBox(
              height: 20,
            ),
            FormBuilderTextField(
              name: 'lastName',
              decoration: InputDecoration(
                  labelText: 'lastName',
                  prefixIcon: Icon(Icons.person_2_outlined),
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(
                      fontSize: 13, color: Appcolors.secondTextColor)),
              onChanged: (val) {},
            ),
            SizedBox(
              height: 20,
            ),
            FormBuilderTextField(
              name: 'email',
              decoration: InputDecoration(
                  labelText: 'email',
                  prefixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(
                      fontSize: 13, color: Appcolors.secondTextColor)),
              onChanged: (val) {},
            ),
            SizedBox(
              height: 20,
            ),
            FormBuilderTextField(
              name: 'phoneNumber',
              decoration: InputDecoration(
                  labelText: 'phoneNumber',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                  labelStyle: TextStyle(
                      fontSize: 13, color: Appcolors.secondTextColor)),
              onChanged: (val) {},
            ),
            SizedBox(
              height: 30,
            ),
            FormBuilderChoiceChip(
              name: "role",
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              alignment: WrapAlignment.center,
              spacing: 10,
              showCheckmark: true,
              options: [
                FormBuilderChipOption(
                  value: "admin",
                ),
                FormBuilderChipOption(
                  value: "simple user",
                ),
              ],
            ),
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                child: AppButtonWithIcon(
                  text: "Save And submit",
                  onPress: () => Navigator.pop(context),
                  icon: Icons.add_box_outlined,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
