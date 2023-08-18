import 'package:backend_flutter_ivo/bo/media_category.dart';
import 'package:backend_flutter_ivo/dal/media_category_access.dart';
import 'package:backend_flutter_ivo/dal/providers/media_category_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MediaCategoryEdit extends StatefulWidget {
  final String routeName = '/media-category/edit/';
  final MediaCategory category;

  const MediaCategoryEdit({required this.category, Key? key}) : super(key: key);

  @override
  State<MediaCategoryEdit> createState() => _MediaCategoryEditState();
}

class _MediaCategoryEditState extends State<MediaCategoryEdit> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.category.title);
    _descriptionController =
        TextEditingController(text: widget.category.subtitle);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: _descriptionController,
            decoration: InputDecoration(labelText: 'Description'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              // Update the item with the new values
              widget.category.title = _nameController.text;
              widget.category.subtitle = _descriptionController.text;

              // Call your update method here
              await context
                  .read<MediaCategoryProvider>()
                  .updateItem(widget.category);

              Navigator.pop(context);
            },
            child: const Text('Save Changes'),
          ),
        ],
      ),
    );
  }
}
