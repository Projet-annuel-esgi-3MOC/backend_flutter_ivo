import 'package:backend_flutter_ivo/bo/media.dart';
import 'package:backend_flutter_ivo/dal/providers/media_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MediaDropDown extends StatelessWidget {
  final void Function(Media) setMedia;

  const MediaDropDown({required this.setMedia, Key? key}) : super(key: key);

  Future<List<Media>> fetchMedia(BuildContext context) async {
    MediaProvider mediaProvider = context.watch<MediaProvider>();

    return await mediaProvider.getAll();
  }

  @override
  Widget build(BuildContext context) {
    Media? selectedMedia;
    return FutureBuilder<List<Media>>(
      future: fetchMedia(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          print(snapshot.stackTrace);

          return Center(child: Text('Snap Error: ${snapshot.error}'));
        } else {
          //final itemProvider = context.read<MediaCategoryProvider>();
          List<Media> itemList = snapshot.data!;

          return DropdownButton<Media>(
            value: selectedMedia,
            onChanged: (newValue) {
              setMedia(newValue!);
            },
            items: itemList.map((item) {
              print(item.accessUrl);
              return DropdownMenuItem<Media>(
                value: item,
                child: Row(
                  children: [
                    Image.network(
                      item.accessUrl,
                      height: 100,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(item.filename),
                  ],
                ),
              );
            }).toList(),
          );
        }
      },
    );
  }
}
