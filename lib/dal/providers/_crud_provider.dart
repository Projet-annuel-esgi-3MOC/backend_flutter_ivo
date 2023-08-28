import 'package:backend_flutter_ivo/bo/_i_bo.dart';
import 'package:backend_flutter_ivo/dal/generic_dao.dart';
import 'package:flutter/material.dart';

class CrudProvider<T extends BO> extends ChangeNotifier {
  late final Access<T> accesser_;

  List<T>? _items;

  List<T> get items => _items ?? [];

  CrudProvider({required this.accesser_});

  Future<void> fetch() async {
    _items = await accesser_.getAll();
    notifyListeners();
  }

  Future<List<T>> getAll() async {
    if (_items == null) await fetch();
    return _items!;
  }

  Future<void> update(T updatedItem) async {
    // Update the item in your data source
    await accesser_.update(updatedItem);

    // Update the local list with the updated item
    _items = await accesser_.getAll();

    notifyListeners();
  }

  Future<void> add(T addedItem) async {
    await accesser_.create(addedItem);

    _items = await accesser_.getAll();

    notifyListeners();
  }

  Future<void> remove(T addedItem) async {
    await accesser_.delete(addedItem);

    _items = await accesser_.getAll();

    notifyListeners();
  }

  /// Updates the internal list, after a remote call
  /// without causing any persistence, internal use
  void updateItems(List<T> items) {
    _items = items;
  }
}
