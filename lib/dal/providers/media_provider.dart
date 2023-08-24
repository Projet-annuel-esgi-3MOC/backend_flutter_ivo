import 'package:backend_flutter_ivo/bo/media.dart';
import 'package:backend_flutter_ivo/dal/generic_dao.dart';
import 'package:backend_flutter_ivo/dal/providers/_i_provider.dart';
import 'package:flutter/material.dart';

final mediaAccess = Access<Media>(
  collectionName: 'media',
  instanceCreator: (s) => Media.fromMap(s),
  // I didnt find how to have an instance created without reflection
  // (dart:mirror) which seems to be unadvised to be used on flutter
  // because of poor performance, so I embed the creator as a callback
);

class MediaProvider extends ChangeNotifier implements Iprovider<Media> {
  final Access<Media> mediaAccess_ = mediaAccess;

  List<Media>? _items = null;

  List<Media> get items => _items ?? [];

  // Method to populate items initially
  @override
  Future<void> fetch() async {
    _items = await mediaAccess_.getAll();
    notifyListeners();
  }

  @override
  Future<List<Media>> getAll() async {
    if (_items == null) await fetch();
    return _items!;
  }

  @override
  Future<void> update(Media updatedItem) async {
    // Update the item in your data source
    await mediaAccess_.update(updatedItem);

    // Update the local list with the updated item
    _items = await mediaAccess_.getAll();

    notifyListeners();
  }

  @override
  Future<void> add(Media addedItem) async {
    await mediaAccess_.create(addedItem);

    _items = await mediaAccess_.getAll();

    notifyListeners();
  }

  @override
  Future<void> remove(Media addedItem) async {
    await mediaAccess_.delete(addedItem);

    _items = await mediaAccess_.getAll();

    notifyListeners();
  }

  @override
  void updateItems(List<Media> items) {
    _items = items;

    //notifyListeners();  // ! this triggers setstate on build
  }
}
