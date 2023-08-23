abstract class Iprovider<BO> {
  void fetch() async {
    throw UnimplementedError("implement this");
  }

  Future<List<BO>> getAll() async {
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

  /// Updates the internal list, after a remote call
  /// without causing any persistence, internal use
  void updateItems(List<BO> items) {
    throw UnimplementedError("implement this");
  }
}
