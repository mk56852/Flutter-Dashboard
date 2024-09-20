import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:point_of_sales/SharedWidget/AppButton.dart';
import 'package:point_of_sales/SharedWidget/PageTitle.dart';
import 'package:point_of_sales/Utils/AppColors.dart';

class AddCategoryModal extends StatelessWidget {
  const AddCategoryModal({super.key});

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
            Pagetitle(title: "Add New Cateogry", path: ""),
            FormBuilderTextField(
              name: 'name',
              decoration: InputDecoration(
                  labelText: 'Category name',
                  prefixIcon: Icon(Icons.person_2_outlined),
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(
                      fontSize: 13, color: Appcolors.secondTextColor)),
              onChanged: (val) {},
            ),
            SizedBox(
              height: 20,
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
