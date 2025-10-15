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

class UpdateProductModal extends StatefulWidget {
  final ValueNotifier<bool> refreshNotifier;
  final String id;
  final Map<String, dynamic> categData;

  const UpdateProductModal(
      {super.key,
      required this.id,
      required this.categData,
      required this.refreshNotifier});

  @override
  State<UpdateProductModal> createState() => _UpdateProductModalState();
}

class _UpdateProductModalState extends State<UpdateProductModal> {
  final _formKey6 = GlobalKey<FormBuilderState>();
  Uint8List? _selectedImageBytes;
  String _imageUrl = "";

  Future<void> _submitForm(BuildContext context) async {
    if (_formKey6.currentState?.saveAndValidate() ?? false) {
      final formData = _formKey6.currentState?.value;

      // Construct the updated user data to be sent
      final data = _imageUrl.isEmpty
          ? {
              "name": formData?['name'],
              "price": double.tryParse(formData?['price'] ?? '0') ?? 0.0,
              "stock": int.tryParse(formData?['stock'] ?? '0') ?? 0,
              "minimumStock":
                  int.tryParse(formData?['minimumStock'] ?? '0') ?? 0,
            }
          : {
              "name": formData?['name'],
              "price": double.tryParse(formData?['price'] ?? '0') ?? 0.0,
              "stock": int.tryParse(formData?['stock'] ?? '0') ?? 0,
              "minimumStock":
                  int.tryParse(formData?['minimumStock'] ?? '0') ?? 0,
              "imageUrl": _imageUrl
            };

      ApiResponse response = await ApiService.updateProduct(data, widget.id);

      if (response.status == 200) {
        // Successfully updated user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Product successfully updated!")),
        );
        //  Navigator.pop(context);
        widget.refreshNotifier.value = !widget.refreshNotifier.value;
      } else {
        // Handle error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to update product: ${response.data}")),
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
        key: _formKey6,
        initialValue: {
          'name': widget.categData['name'],
          'price': widget.categData['price'].toString(),
          'stock': widget.categData['stock'].toString(),
          'minimumStock': widget.categData['minimumStock'].toString(),
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Pagetitle(title: "Update Product Form", path: ""),
            FormBuilderTextField(
              name: 'name',
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(
                    errorText: "Product name is required"),
              ]),
              decoration: InputDecoration(
                  labelText: 'Name',
                  prefixIcon: Icon(Icons.person_2_outlined),
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(
                      fontSize: 13, color: Appcolors.secondTextColor)),
            ),
            SizedBox(height: 10),
            FormBuilderTextField(
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(
                    errorText: "Product price is required"),
              ]),
              name: 'price',
              decoration: InputDecoration(
                  labelText: 'Price',
                  prefixIcon: Icon(Icons.person_2_outlined),
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(
                      fontSize: 13, color: Appcolors.secondTextColor)),
            ),
            SizedBox(height: 10),
            FormBuilderTextField(
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(
                    errorText: "Product stock is required"),
              ]),
              name: 'stock',
              decoration: InputDecoration(
                  labelText: 'Stock',
                  prefixIcon: Icon(Icons.person_2_outlined),
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(
                      fontSize: 13, color: Appcolors.secondTextColor)),
            ),
            SizedBox(height: 10),
            FormBuilderTextField(
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(
                    errorText: "Product minimum stock  is required"),
              ]),
              name: 'minimumStock',
              decoration: InputDecoration(
                  labelText: 'Minimum Stock',
                  prefixIcon: Icon(Icons.person_2_outlined),
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(
                      fontSize: 13, color: Appcolors.secondTextColor)),
            ),
            SizedBox(height: 10),
            ImageUploadButton(onImageSelected: (file) => _uploadImage(file)),
            SizedBox(height: 10),
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
