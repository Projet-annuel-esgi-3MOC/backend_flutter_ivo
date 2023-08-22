import 'package:backend_flutter_ivo/bo/media_category.dart';
import 'package:backend_flutter_ivo/dal/media_category_access.dart';
import 'package:backend_flutter_ivo/dal/providers/_i_provider.dart';
import 'package:flutter/material.dart';

class MediaCategoryProvider extends ChangeNotifier
    implements Iprovider<MediaCategory> {
  final MediaCategoryAccess mediaCategoryAccess = MediaCategoryAccess();

  List<MediaCategory> _items = [];

  List<MediaCategory> get items => _items;

  // Method to populate items initially
  @override
  void fetch() async {
    _items = await mediaCategoryAccess.getAll();
    notifyListeners();
  }

  @override
  Future<void> update(MediaCategory updatedItem) async {
    // Update the item in your data source
    await mediaCategoryAccess.update(updatedItem);

    // Update the local list with the updated item
    _items = await mediaCategoryAccess.getAll();

    notifyListeners();
  }

  @override
  Future<void> add(MediaCategory addedItem) async {
    await mediaCategoryAccess.create(addedItem);

    _items = await mediaCategoryAccess.getAll();

    notifyListeners();
  }

  @override
  Future<void> remove(MediaCategory addedItem) async {
    await mediaCategoryAccess.delete(addedItem);

    _items = await mediaCategoryAccess.getAll();

    notifyListeners();
  }

  @override
  void updateItems(List<MediaCategory> items) {
    _items = items;

    //notifyListeners();  // ! this triggers setstate on build
  }
}
