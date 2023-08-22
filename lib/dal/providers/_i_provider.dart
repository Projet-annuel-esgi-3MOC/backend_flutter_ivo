import 'package:backend_flutter_ivo/bo/_i_firebaseable.dart';

abstract class Iprovider<T extends Firebaseable> {
  void fetch() async {
    throw UnimplementedError("implement this");
  }

  Future<void> update(T updatedItem) async {
    throw UnimplementedError("implement this");
  }

  Future<void> add(T addedItem) async {
    throw UnimplementedError("implement this");
  }

  Future<void> remove(T addedItem) async {
    throw UnimplementedError("implement this");
  }

  void updateItems(List<T> items) {
    throw UnimplementedError("implement this");
  }
}
