import 'dart:convert';
import 'dart:typed_data'; // For handling binary image data
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:point_of_sales/Services/Api.dart';
import 'package:point_of_sales/SharedWidget/AppButton.dart';
import 'package:point_of_sales/Configuration/AppConfig.dart';
import 'package:point_of_sales/SharedWidget/ImageUploadButton.dart';
import 'package:point_of_sales/SharedWidget/PageTitle.dart';
import 'package:point_of_sales/Utils/AppColors.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;

class AddCategoryModal extends StatefulWidget {
  final VoidCallback onAddingCateg;

  AddCategoryModal({super.key, required this.onAddingCateg});

  @override
  _AddCategoryModalState createState() => _AddCategoryModalState();
}

class _AddCategoryModalState extends State<AddCategoryModal> {
  final _formKey = GlobalKey<FormBuilderState>();
  Uint8List? _selectedImageBytes;
  String? _imageUrl;

  Future<void> _submitForm(BuildContext context) async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final formData = _formKey.currentState?.value;
      final categData = {"name": formData?['name'], "imageUrl": _imageUrl};

      try {
        // Send POST request
        final response = await http.post(
          Uri.parse(AppConfig.apiBaseUrl + 'api/categories'),
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode(categData),
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Category successfully added!")),
          );
          widget.onAddingCateg(); // Notify parent to refresh the table
          Navigator.pop(context);
        } else {
          // Handle error
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed to add Category: ${response.body}")),
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

  Future<void> _uploadImage(dynamic file) async {
    if (file != null) {
      final reader = html.FileReader();
      reader.readAsArrayBuffer(file);
      reader.onLoadEnd.listen((event) async {
        final Uint8List fileBytes = reader.result as Uint8List;
        final fileName = file.name;

        // Send the request
        final response =
            await ApiService.uploadCategoryImage(fileName, fileBytes);
        if (response.status == 200) {
          final imageUrl = response.data; // Adjust key based on API response
          setState(() {
            _selectedImageBytes = fileBytes;
            _imageUrl = imageUrl;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Image uploaded successfully!")),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed to upload image")),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 600, maxWidth: 1000),
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 50),
      alignment: Alignment.center,
      child: FormBuilder(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Pagetitle(title: "Add New Category", path: ""),
            FormBuilderTextField(
              name: 'name',
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(
                    errorText: "Category name is required"),
              ]),
              decoration: InputDecoration(
                  labelText: 'Category name',
                  prefixIcon: Icon(Icons.person_2_outlined),
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(
                      fontSize: 13, color: Appcolors.secondTextColor)),
              onChanged: (val) {},
            ),
            SizedBox(height: 20),
            // Image upload button
            ImageUploadButton(onImageSelected: (file) => _uploadImage(file)),
            SizedBox(height: 20),
            // Display the uploaded image
            if (_selectedImageBytes != null)
              Container(
                height: 175,
                width: 175,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: MemoryImage(_selectedImageBytes!),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            else
              Text("No image selected."),
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                child: AppButtonWithIcon(
                  text: "Save And Submit",
                  onPress: () => _submitForm(context),
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
