import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:point_of_sales/Configuration/AppConfig.dart';
import 'package:point_of_sales/SharedWidget/AppButton.dart';
import 'package:point_of_sales/SharedWidget/PageTitle.dart';

import 'package:http/http.dart' as http;

class AddUserModal extends StatelessWidget {
  final VoidCallback onUserAdded; // Callback function to notify parent

  const AddUserModal({super.key, required this.onUserAdded});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormBuilderState>();

    Future<void> _submitForm(BuildContext context) async {
      if (_formKey.currentState?.saveAndValidate() ?? false) {
        final formData = _formKey.currentState?.value;

        // Construct the user data to be sent
        final userData = {
          "firstName": formData?['firstName'],
          "lastName": formData?['lastName'],
          "email": formData?['email'],
          "phoneNumber": formData?['phoneNumber'],
          "role": formData?['role'] == "simple user" ? 1 : 0,
        };

        try {
          // Send POST request
          final response = await http.post(
            Uri.parse(AppConfig.apiBaseUrl + 'api/users'),
            headers: {
              "Content-Type": "application/json",
            },
            body: jsonEncode(userData),
          );

          if (response.statusCode == 200) {
            // Successfully created user
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("User successfully added!")),
            );

            onUserAdded(); // Notify parent to refresh the table
            Navigator.pop(context);
          } else {
            // Handle error
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Failed to add user: ${response.body}")),
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error: $e")),
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Pagetitle(title: "Add User Form", path: ""),
            FormBuilderTextField(
              name: 'firstName',
              decoration: InputDecoration(
                  labelText: 'First Name',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder()),
            ),
            SizedBox(height: 20),
            FormBuilderTextField(
              name: 'lastName',
              decoration: InputDecoration(
                  labelText: 'Last Name',
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder()),
            ),
            SizedBox(height: 20),
            FormBuilderTextField(
              name: 'email',
              decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder()),
            ),
            SizedBox(height: 20),
            FormBuilderTextField(
              name: 'phoneNumber',
              decoration: InputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder()),
            ),
            SizedBox(height: 20),
            FormBuilderChoiceChip(
              name: "role",
              options: [
                FormBuilderChipOption(value: "admin"),
                FormBuilderChipOption(value: "simple user"),
              ],
            ),
            SizedBox(height: 30),
            AppButtonWithIcon(
              text: "Save and Submit",
              onPress: () => _submitForm(context),
              icon: Icons.add_box_outlined,
            ),
          ],
        ),
      ),
    );
  }
}
