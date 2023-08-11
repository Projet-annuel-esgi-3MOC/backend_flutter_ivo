import 'dart:convert';

import 'package:backend_flutter_ivo/dal/http.dart';
import 'package:flutter/material.dart';

class MediaTypeCrud extends StatefulWidget {
  const MediaTypeCrud({super.key});

  @override
  State<MediaTypeCrud> createState() => _MediaTypeCrudState();
}

class _MediaTypeCrudState extends State<MediaTypeCrud> {
  List<dynamic> _data = [];

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<void>  fetchData() async {
    var res = await fetch('localhost:3000', 'media-category');
    _data = json.decode(res);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          itemCount: _data.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_data[index]['title']),
            );
          },
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: () => 0,
            child: Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
