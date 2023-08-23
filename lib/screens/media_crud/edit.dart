import 'dart:io';

import 'package:backend_flutter_ivo/bo/media.dart';
import 'package:backend_flutter_ivo/screens/crud/edit.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MediaEditWidget extends StatefulWidget {
  const MediaEditWidget({Key? key}) : super(key: key);

  @override
  State<MediaEditWidget> createState() => _MediaEditWidgetState();
}

class _MediaEditWidgetState extends State<MediaEditWidget> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  XFile? _image;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Form is valid, process data
      String textValue = _nameController.text;
      print('Text Value: $textValue');
      if (_image != null) {
        print('Image Path: ${_image!.path}');
        // Here you can upload the image to your desired location
      }
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CrudEdit<Media>(
      fields: [
        TextFormField(
          controller: _nameController,
          decoration: const InputDecoration(
            labelText: 'Title',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        TextFormField(
          controller: _nameController,
          decoration: const InputDecoration(
            labelText: 'Text Field',
          ),
        ),
        const SizedBox(height: 16.0),
        _image != null
            ? Image.network(
                _image!.path,
                height: 100,
              )
            : Container(),
        ElevatedButton(
          onPressed: _pickImage,
          child: const Text('Pick Image'),
        ),
        const SizedBox(height: 16.0),
      ],
      onSave: _submitForm,
    );
  }
}
