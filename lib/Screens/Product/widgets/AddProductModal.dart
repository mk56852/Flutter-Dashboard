import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:point_of_sales/Models/Category.dart';
import 'package:point_of_sales/Services/Api.dart';
import 'package:point_of_sales/SharedWidget/AppButton.dart';
import 'package:point_of_sales/Configuration/AppConfig.dart';
import 'package:point_of_sales/SharedWidget/ImageUploadButton.dart';
import 'package:point_of_sales/SharedWidget/PageTitle.dart';
import 'package:point_of_sales/Utils/AppColors.dart';
import 'package:http/http.dart' as http;

import 'dart:html' as html;

class AddProductModal extends StatefulWidget {
  VoidCallback onAddingCateg;
  List<Category> categories;
  AddProductModal(
      {super.key, required this.onAddingCateg, required this.categories});

  @override
  State<AddProductModal> createState() => _AddProductModalState();
}

class _AddProductModalState extends State<AddProductModal> {
  final _formKey = GlobalKey<FormBuilderState>();
  Uint8List? _selectedImageBytes;
  String? _imageUrl;

  Future<void> _submitForm(BuildContext context) async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final formData = _formKey.currentState?.value;

      final categData = {
        "name": formData?['name'],
        "price": formData?['price'],
        "stock": formData?['stock'],
        "minimumStock": formData?['min_stock'],
        "imageUrl": _imageUrl,
        "category": {
          "id": formData?['category'],
        }
      };

      try {
        // Send POST request
        final response = await http.post(
          Uri.parse(AppConfig.apiBaseUrl + 'api/products'),
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode(categData),
        );
        print(response.statusCode);
        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Product successfully added!")),
          );
          widget.onAddingCateg(); // Notify parent to refresh the table
          Navigator.pop(context);
        } else {
          // Handle error
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed to add Product: ${response.body}")),
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
            await ApiService.uploadProductImage(fileName, fileBytes);
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
            Pagetitle(title: "Add New Product", path: ""),
            FormBuilderTextField(
              name: 'name',
              decoration: InputDecoration(
                  labelText: 'Product name',
                  prefixIcon: Icon(Icons.abc),
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(
                      fontSize: 13, color: Appcolors.secondTextColor)),
              onChanged: (val) {},
            ),
            SizedBox(
              height: 10,
            ),
            FormBuilderTextField(
              name: 'price',
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(
                    errorText: "Category name is required"),
              ]),
              decoration: InputDecoration(
                  labelText: 'Price',
                  prefixIcon: Icon(Icons.price_change),
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(
                      fontSize: 13, color: Appcolors.secondTextColor)),
              onChanged: (val) {},
            ),
            SizedBox(
              height: 10,
            ),
            FormBuilderTextField(
              name: 'stock',
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(
                    errorText: "Category name is required"),
              ]),
              decoration: InputDecoration(
                  labelText: 'Stock',
                  prefixIcon: Icon(Icons.numbers),
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(
                      fontSize: 13, color: Appcolors.secondTextColor)),
              onChanged: (val) {},
            ),
            SizedBox(
              height: 10,
            ),
            FormBuilderTextField(
              name: 'min_stock',
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(
                    errorText: "Category name is required"),
              ]),
              decoration: InputDecoration(
                  labelText: 'Minimum Stock',
                  prefixIcon: Icon(Icons.dangerous),
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(
                      fontSize: 13, color: Appcolors.secondTextColor)),
              onChanged: (val) {},
            ),
            SizedBox(
              height: 10,
            ),
            FormBuilderDropdown<int>(
              name: 'category',
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(
                    errorText: "Category name is required"),
              ]),
              decoration: InputDecoration(
                labelText: 'Product Category',
                prefixIcon: Icon(Icons.category),
                border: OutlineInputBorder(),
                labelStyle: TextStyle(
                  fontSize: 13,
                  color: Appcolors.secondTextColor,
                ),
              ),
              items: widget.categories
                  .map((item) =>
                      DropdownMenuItem(value: item.id, child: Text(item.name)))
                  .toList(),
              onChanged: (val) {
                // Handle any specific logic when the value changes if needed
              },
            ),
            SizedBox(height: 10),
            // Image upload button
            ImageUploadButton(onImageSelected: (file) => _uploadImage(file)),
            SizedBox(height: 10),
            // Display the uploaded image
            if (_selectedImageBytes != null)
              Text("image uploaded succefully.")
            else
              Text("No image selected."),
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                child: AppButtonWithIcon(
                  text: "Save And submit",
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
