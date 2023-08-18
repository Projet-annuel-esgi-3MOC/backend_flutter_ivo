import 'package:backend_flutter_ivo/bo/media_category.dart';
import 'package:backend_flutter_ivo/dal/media_category_access.dart';
import 'package:backend_flutter_ivo/dal/providers/media_category_provider.dart';
import 'package:backend_flutter_ivo/screens/media_category_crud/edit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MediaCategoryCrud extends StatefulWidget {
  const MediaCategoryCrud({super.key});

  @override
  State<MediaCategoryCrud> createState() => _MediaCategoryCrudState();
}

class _MediaCategoryCrudState extends State<MediaCategoryCrud> {
  final MediaCategoryAccess mediaCategoryAccess = MediaCategoryAccess();

  @override
  void initState() {
    super.initState();
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
    final newItem = MediaCategory('', '', '');
    return Stack(
      children: [
        Positioned.fill(child: _buildItemList(context)),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: () => _showModal(
              context,
              newItem,
              () async => {
                await context.read<MediaCategoryProvider>().addItem(newItem)
              },
            ),
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }

  Widget _buildItemList(BuildContext context) {
    final itemsProvider = context.watch<MediaCategoryProvider>();

    return FutureBuilder<List<MediaCategory>>(
      future: mediaCategoryAccess.getAll(),
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
                title: Text(item.title),
                subtitle: Text(item.subtitle),
                onTap: () => _showModal(
                  context,
                  item,
                  () async => {
                    await context.read<MediaCategoryProvider>().updateItem(item)
                  },
                ),
              );
            },
          );
        }
      },
    );
  }
}
