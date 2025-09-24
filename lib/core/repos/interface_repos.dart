abstract class InterfaceRepository<T> {
  ///Get all data from database
  Future<T?> getAll();

  /// inster data to database
  Future<void> insertItem({required T object});

  /// is data available
  Future<bool> isDataAvailable();
}
