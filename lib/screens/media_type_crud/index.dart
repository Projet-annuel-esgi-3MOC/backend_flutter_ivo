import 'package:flutter/material.dart';

class MediaTypeCrud extends StatefulWidget {
  const MediaTypeCrud({super.key});

  @override
  State<MediaTypeCrud> createState() => _MediaTypeCrudState();
}

class _MediaTypeCrudState extends State<MediaTypeCrud> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Placeholder(),
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
