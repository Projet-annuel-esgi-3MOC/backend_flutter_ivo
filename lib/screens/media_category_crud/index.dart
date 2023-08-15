import 'dart:convert';

import 'package:backend_flutter_ivo/bo/media_category.dart';
import 'package:backend_flutter_ivo/dal/http.dart';
import 'package:backend_flutter_ivo/screens/media_category_crud/edit.dart';
import 'package:flutter/material.dart';

class MediaCategoryCrud extends StatefulWidget {
  const MediaCategoryCrud({super.key});

  @override
  State<MediaCategoryCrud> createState() => _MediaCategoryCrudState();
}

class _MediaCategoryCrudState extends State<MediaCategoryCrud> {
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<List<dynamic>> fetchData() async {
    var res = await fetch('localhost:3000', 'media-category');
    return json.decode(res);
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
    return Stack(
      children: [
        Positioned.fill(
          child: FutureBuilder<List<dynamic>>(
            future: fetchData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                List<dynamic> itemList = snapshot.data!;
                return ListView.builder(
                  itemCount: itemList.length,
                  itemBuilder: (context, index) {
                    MediaCategory item =
                        MediaCategory.fromJson(itemList[index]);
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
