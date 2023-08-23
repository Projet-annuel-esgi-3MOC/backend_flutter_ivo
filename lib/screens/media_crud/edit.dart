import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController();
  }

  XFile? _image;

  Future<String> fetchImageData(String imageUrl) {
    final Completer<String> completer = Completer<String>();

    final HttpRequest request = HttpRequest();
    request.open('GET', imageUrl, async: true);
    request.responseType = 'arraybuffer';

    request.onLoad.listen((event) {
      if (request.status == 200) {
        final Uint8List imageData = Uint8List.view(request.response);
        final String base64Image = base64Encode(imageData);
        completer.complete(base64Image);
      } else {
        completer.completeError('Failed to fetch image: ${request.status}');
      }
    });

    request.onError.listen((event) {
      completer.completeError('Failed to fetch image');
    });

    request.send();

    return completer.future;
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState == null) {
      print('formKey is null');
      return;
    }

    if (_formKey.currentState!.validate()) {
      // Form is valid, process data
      String? textValue = _nameController.text;
      print('Text Value: $textValue');
      if (_image != null) {
        print(
            'Image Path: ${_image!.mimeType} ${_image!.name} ${_image!.path} ${_image!.hashCode} ${_image!.runtimeType}');
        // Here you can upload the image to your desired location
        print(await fetchImageData(_image!.path));
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
    return Form(
      key: _formKey,
      child: CrudEdit<Media>(
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
      ),
    );
  }
}
