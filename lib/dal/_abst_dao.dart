abstract class DAO<T> {
  Future<bool> create(T data);
  Future<T> get(String id);
  Future<List<T>> getAll();
  Future<bool> update(T o);
  Future<bool> delete(T o);
}
