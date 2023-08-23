import 'package:backend_flutter_ivo/bo/media_category.dart';
import 'package:backend_flutter_ivo/dal/providers/media_category_provider.dart';
import 'package:backend_flutter_ivo/screens/_fab_action.dart';
import 'package:backend_flutter_ivo/screens/media_category_crud/edit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MediaCategoryCrud extends StatefulWidget {
  final Function(FABAction) setFab;

  const MediaCategoryCrud({required this.setFab, Key? key}) : super(key: key);

  @override
  State<MediaCategoryCrud> createState() => _MediaCategoryCrudState();
}

class _MediaCategoryCrudState extends State<MediaCategoryCrud> {
  @override
  void initState() {
    super.initState();

    final newItem = MediaCategory('', '');

    widget.setFab(FABAction(function: openModal, parameters: [newItem]));
  }

  void openModal(List<dynamic> newItem) {
    final MediaCategory newItem_ = newItem.first;

    _showModal(
      context,
      newItem_,
      () async => {await context.read<MediaCategoryProvider>().add(newItem_)},
    );
  }

  void _showModal(
      BuildContext context, MediaCategory category, Function onSubmitCallback) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit'),
          content: MediaCategoryEdit(
            category: category,
            onSubmitCallback: onSubmitCallback,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the modal
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildItemList(context);
  }

  _editItem(MediaCategory item) {
    _showModal(
      context,
      item,
      () async => {await context.read<MediaCategoryProvider>().update(item)},
    );
  }

  _deleteItem(MediaCategory item) async {
    await context.read<MediaCategoryProvider>().remove(item);
  }

  Widget _buildItemList(BuildContext context) {
    final itemsProvider = context.watch<MediaCategoryProvider>();

    return FutureBuilder<List<MediaCategory>>(
      future: itemsProvider.getAll(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Snap Error: ${snapshot.error}'));
        } else {
          //final itemProvider = context.read<MediaCategoryProvider>();
          itemsProvider.updateItems(snapshot.data!);
          List<MediaCategory> itemList = snapshot.data!;

          return ListView.builder(
            itemCount: itemList.length,
            itemBuilder: (context, index) {
              MediaCategory item = itemList[index];
              return ListTile(
                title: Text(item.showTitle()),
                subtitle: Text(item.showSubtitle()),
                onTap: () => _editItem(item),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        // Perform edit action for the current item
                        _editItem(item);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        // Perform delete action for the current item
                        await _deleteItem(item);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}
