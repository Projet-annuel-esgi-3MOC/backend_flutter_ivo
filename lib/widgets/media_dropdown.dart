import 'package:backend_flutter_ivo/bo/media.dart';
import 'package:backend_flutter_ivo/dal/providers/media_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MediaDropDown extends StatefulWidget {
  final void Function(Media) setMedia;
  final Media Function() getInitialMedia;

  const MediaDropDown({
    required this.setMedia,
    required this.getInitialMedia,
    Key? key,
  }) : super(key: key);

  @override
  State<MediaDropDown> createState() => _MediaDropDownState();
}

class _MediaDropDownState extends State<MediaDropDown> {
  Future<List<Media>> fetchMedia(BuildContext context) async {
    MediaProvider mediaProvider = context.watch<MediaProvider>();

    return await mediaProvider.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Media>>(
      future: fetchMedia(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Snap Error: ${snapshot.error}'));
        } else {
          //final itemProvider = context.read<MediaCategoryProvider>();
          List<Media> itemList = snapshot.data!;

          return DropdownMenu<Media>(
            width: 250,
            initialSelection: itemList
                .where((element) => element.id == widget.getInitialMedia().id)
                .firstOrNull,
            onSelected: (newValue) {
              widget.setMedia(newValue!);
            },
            dropdownMenuEntries: itemList.map((item) {
              return DropdownMenuEntry<Media>(
                value: item,
                label: item.filename,
                leadingIcon: Image.network(
                  item.accessUrl,
                  height: 50,
                  width: 50,
                ),
              );
            }).toList(),
          );
        }
      },
    );
  }
}
