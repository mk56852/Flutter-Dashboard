import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:point_of_sales/Configuration/AppConfig.dart';
import 'package:point_of_sales/Services/Api.dart';
import 'package:point_of_sales/SharedWidget/AppButton.dart';
import 'package:point_of_sales/SharedWidget/PageTitle.dart';
import 'package:point_of_sales/Utils/AppColors.dart';
import 'package:http/http.dart' as http;

class UpdateUserModal extends StatelessWidget {
  final ValueNotifier<bool> refreshNotifier;
  final String userId;
  final Map<String, dynamic> userData;

  const UpdateUserModal(
      {super.key,
      required this.userId,
      required this.userData,
      required this.refreshNotifier});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormBuilderState>();

    Future<void> _submitForm(BuildContext context) async {
      if (_formKey.currentState?.saveAndValidate() ?? false) {
        final formData = _formKey.currentState?.value;

        // Construct the updated user data to be sent
        final updatedUserData = {
          "firstName": formData?['firstName'],
          "lastName": formData?['lastName'],
          "email": formData?['email'],
          "phoneNumber": formData?['phoneNumber'],
          "role": formData?['role'] == "simple user" ? 1 : 0,
        };

        ApiResponse response =
            await ApiService.updateUser(updatedUserData, userId);

        if (response.status == 200) {
          // Successfully updated user
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("User successfully updated!")),
          );
          //  Navigator.pop(context);
          refreshNotifier.value = !refreshNotifier.value;
        } else {
          // Handle error
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed to update user")),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please complete the form.")),
        );
      }
    }

    return Container(
      constraints: BoxConstraints(maxHeight: 600, maxWidth: 1000),
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 50),
      alignment: Alignment.center,
      child: FormBuilder(
        key: _formKey,
        initialValue: {
          'firstName': userData['firstName'],
          'lastName': userData['lastName'],
          'email': userData['email'],
          'phoneNumber': userData['phoneNumber'],
          'role': userData['role'] == 1 ? "simple user" : "admin",
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Pagetitle(title: "Update User Form", path: ""),
            FormBuilderTextField(
              name: 'firstName',
              decoration: InputDecoration(
                  labelText: 'firstName',
                  prefixIcon: Icon(Icons.person_2_outlined),
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(
                      fontSize: 13, color: Appcolors.secondTextColor)),
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
                  onPress: () {
                    _submitForm(context);
                    Navigator.pop(context);
                  },
                  icon: Icons.update_outlined,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
