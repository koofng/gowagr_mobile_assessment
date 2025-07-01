abstract class CacheService<T> {
  Future<void> save(String key, T value);
  Future<T?> read(String key);
  Future<void> delete(String key);
  Future<void> clear();
  Future<bool> contains(String key);

  /// Insert one or more items into the database
  Future<void> insertItems(String key, List<T> items);

  /// Retrieve all items from the database
  Future<List<T>> getAllItems(String key, T Function(Map<String, Object?> map) fromMap);
}
