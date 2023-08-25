import 'package:backend_flutter_ivo/bo/media_category.dart';
import 'package:flutter/material.dart';

class MediaCategoryEdit extends StatefulWidget {
  final String routeName = '/media-category/edit/';
  final MediaCategory category;
  final Function onSubmitCallback;

  const MediaCategoryEdit({
    required this.category,
    required this.onSubmitCallback,
    Key? key,
  }) : super(key: key);

  @override
  State<MediaCategoryEdit> createState() => _MediaCategoryEditState();
}

class _MediaCategoryEditState extends State<MediaCategoryEdit> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.category.name);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              // Update the item with the new values
              widget.category.name = _nameController.text;

              await widget.onSubmitCallback();
              // Call your update method here

              Navigator.pop(context);
            },
            child: const Text('Save Changes'),
          ),
        ],
      ),
    );
  }
}
