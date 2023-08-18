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

  void _showModal(BuildContext context, MediaCategory category) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit'),
          content: MediaCategoryEdit(category: category),
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
    // final items = context.watch<MediaCategoryProvider>().items;

    return Stack(
      children: [
        Positioned.fill(
          child: FutureBuilder<List<MediaCategory>>(
            future: mediaCategoryAccess.getAll(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Snap Error: ${snapshot.error}'));
              } else {
                final itemProvider = context.read<MediaCategoryProvider>();
                //itemProvider.updateItems(snapshot.data!);

                //List<MediaCategory> itemList = itemProvider.items;
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    MediaCategory item = snapshot.data![index];
                    return ListTile(
                      title: Text(item.title),
                      subtitle: Text(item.subtitle),
                      onTap: () => _showModal(context, item),
                    );
                  },
                );
              }
            },
          ),
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: () => 0,
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
