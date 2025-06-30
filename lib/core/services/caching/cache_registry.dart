typedef FromJson<T> = T Function(Map<String, dynamic>);
typedef ToJson<T> = Map<String, dynamic> Function(T);

class CacheRegistry {
  static final Map<Type, _CacheMetadata> _registry = {};

  static void register<T>({required String tableName, required FromJson<T> fromJson, required ToJson<T> toJson}) {
    _registry[T] = _CacheMetadata(tableName: tableName, fromJson: (json) => fromJson(json), toJson: (value) => toJson(value as T));
  }

  static _CacheMetadata get<T>() {
    final meta = _registry[T];
    if (meta == null) {
      throw Exception('No cache config registered for type $T');
    }
    return meta;
  }
}

class _CacheMetadata {
  final String tableName;
  final dynamic Function(Map<String, dynamic>) fromJson;
  final Map<String, dynamic> Function(dynamic) toJson;

  _CacheMetadata({required this.tableName, required this.fromJson, required this.toJson});
}
