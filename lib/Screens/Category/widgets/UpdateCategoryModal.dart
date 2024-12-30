import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:point_of_sales/Services/Api.dart';
import 'package:point_of_sales/SharedWidget/AppButton.dart';
import 'package:point_of_sales/SharedWidget/ImageUploadButton.dart';
import 'package:point_of_sales/SharedWidget/PageTitle.dart';
import 'package:point_of_sales/Utils/AppColors.dart';
import 'dart:html' as html;

class UpdateCategoryModal extends StatefulWidget {
  final ValueNotifier<bool> refreshNotifier;
  final String categId;
  final Map<String, dynamic> categData;

  const UpdateCategoryModal(
      {super.key,
      required this.categId,
      required this.categData,
      required this.refreshNotifier});

  @override
  State<UpdateCategoryModal> createState() => _UpdateCategoryModalState();
}

class _UpdateCategoryModalState extends State<UpdateCategoryModal> {
  final _formKey3 = GlobalKey<FormBuilderState>();
  Uint8List? _selectedImageBytes;
  String _imageUrl = "";

  Future<void> _submitForm(BuildContext context) async {
    if (_formKey3.currentState?.saveAndValidate() ?? false) {
      final formData = _formKey3.currentState?.value;

      final updatedcategData = _imageUrl.isEmpty
          ? {
              "name": formData?['name'],
            }
          : {"name": formData?['name'], "imageUrl": _imageUrl};

      ApiResponse response =
          await ApiService.updateCategory(updatedcategData, widget.categId);

      if (response.status == 200) {
        // Successfully updated user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Category successfully updated!")),
        );
        //  Navigator.pop(context);
        widget.refreshNotifier.value = !widget.refreshNotifier.value;
      } else {
        // Handle error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to update category")),
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
        key: _formKey3,
        initialValue: {
          'name': widget.categData['name'],
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Pagetitle(title: "Update Category Form", path: ""),
            FormBuilderTextField(
              name: 'name',
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(
                    errorText: "Category name is required"),
              ]),
              decoration: InputDecoration(
                  labelText: 'Name',
                  prefixIcon: Icon(Icons.person_2_outlined),
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(
                      fontSize: 13, color: Appcolors.secondTextColor)),
            ),
            SizedBox(height: 20),
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
