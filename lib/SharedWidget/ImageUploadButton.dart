import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:point_of_sales/SharedWidget/AppButton.dart';

class ImageUploadButton extends StatefulWidget {
  final Function(html.File? file) onImageSelected;

  const ImageUploadButton({Key? key, required this.onImageSelected})
      : super(key: key);

  @override
  _ImageUploadButtonState createState() => _ImageUploadButtonState();
}

class _ImageUploadButtonState extends State<ImageUploadButton> {
  void _uploadImage() {
    // Create a file input element
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept = 'image/*';
    uploadInput.click();

    // Handle file selection
    uploadInput.onChange.listen((event) {
      final files = uploadInput.files;
      if (files != null && files.isNotEmpty) {
        final selectedFile = files.first;
        widget.onImageSelected(selectedFile);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppButtonWithIcon(
      onPress: _uploadImage,
      text: "Upload Image",
    );
  }
}
