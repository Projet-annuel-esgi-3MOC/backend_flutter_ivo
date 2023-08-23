import 'package:backend_flutter_ivo/bo/_i_bo.dart';
import 'package:backend_flutter_ivo/bo/_i_firebaseable.dart';

abstract class Iprovider<BO> {
  void fetch() async {
    throw UnimplementedError("implement this");
  }

  Future<List<BO>> getAll() async {
    print('toto');
    throw UnimplementedError("implement this");
  }

  Future<void> update(BO updatedItem) async {
    throw UnimplementedError("implement this");
  }

  Future<void> add(BO addedItem) async {
    throw UnimplementedError("implement this");
  }

  Future<void> remove(BO addedItem) async {
    throw UnimplementedError("implement this");
  }

  void updateItems(List<BO> items) {
    throw UnimplementedError("implement this");
  }
}
