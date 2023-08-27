import 'package:backend_flutter_ivo/bo/challenge.dart';
import 'package:backend_flutter_ivo/dal/generic_dao.dart';
import 'package:backend_flutter_ivo/dal/providers/_i_provider.dart';
import 'package:flutter/material.dart';

final accesser = Access<Challenge>(
  collectionName: 'challenge',
  instanceCreator: (s) => Challenge.fromMap(s),
  // I didnt find how to have an instance created without reflection
  // (dart:mirror) which seems to be unadvised to be used on flutter
  // because of poor performance, so I embed the creator as a callback
);

class ChallengeProvider extends ChangeNotifier implements Iprovider<Challenge> {
  final Access<Challenge> accesser_ = accesser;

  List<Challenge>? _items;

  List<Challenge> get items => _items ?? [];

  // Method to populate items initially
  @override
  Future<void> fetch() async {
    _items = await accesser_.getAll();
    notifyListeners();
  }

  @override
  Future<List<Challenge>> getAll() async {
    if (_items == null) await fetch();
    return _items!;
  }

  @override
  Future<void> update(Challenge updatedItem) async {
    // Update the item in your data source
    await accesser_.update(updatedItem);

    // Update the local list with the updated item
    _items = await accesser_.getAll();

    notifyListeners();
  }

  @override
  Future<void> add(Challenge addedItem) async {
    await accesser_.create(addedItem);

    _items = await accesser_.getAll();

    notifyListeners();
  }

  @override
  Future<void> remove(Challenge addedItem) async {
    await accesser_.delete(addedItem);

    _items = await accesser_.getAll();

    notifyListeners();
  }

  @override
  void updateItems(List<Challenge> items) {
    _items = items;

    //notifyListeners();  // ! this triggers setstate on build
  }
}
