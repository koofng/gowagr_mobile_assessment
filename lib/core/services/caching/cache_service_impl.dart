import 'dart:convert';
import 'dart:developer';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'cache_registry.dart';
import 'cache_service_abstract.dart';

class CacheServiceImpl<T> implements CacheService<T> {
  late final String _tableName;
  late final T Function(String) _fromJson;
  late final String Function(T) _toJson;

  static Database? _db;

  CacheServiceImpl() {
    final meta = CacheRegistry.get<T>();
    _tableName = meta.tableName;
    _fromJson = (json) => meta.fromJson(jsonDecode(json)) as T;
    _toJson = (value) => jsonEncode(meta.toJson(value));
  }

  Future<Database> get _database async {
    if (_db != null) return _db!;
    final dir = await getApplicationDocumentsDirectory();
    final path = join(dir.path, 'app_cache.db');
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, _) async {
        await db.execute('CREATE TABLE IF NOT EXISTS $_tableName (key TEXT PRIMARY KEY, value TEXT)');
      },
    );
    return _db!;
  }

  @override
  Future<void> save(String key, T value) async {
    final db = await _database;
    await db.insert(_tableName, {'key': key, 'value': _toJson(value)}, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<T?> read(String key) async {
    final db = await _database;
    final result = await db.query(_tableName, where: 'key = ?', whereArgs: [key]);
    if (result.isNotEmpty) {
      return _fromJson(result.first['value'] as String);
    }
    return null;
  }

  @override
  Future<void> delete(String key) async {
    final db = await _database;
    await db.delete(_tableName, where: 'key = ?', whereArgs: [key]);
  }

  @override
  Future<void> clear() async {
    final db = await _database;
    await db.delete(_tableName);
  }

  @override
  Future<bool> contains(String key) async {
    final db = await _database;
    final result = await db.query(_tableName, where: 'key = ?', whereArgs: [key]);
    return result.isNotEmpty;
  }

  @override
  Future<void> insertItems(String key, List<T> items) async {
    final dbClient = await _database;
    final batch = dbClient.batch();
    for (final item in items) {
      batch.insert(_tableName, {'key': key, 'value': _toJson(item)}, conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit(noResult: true);
  }

  @override
  Future<List<T>> getAllItems(String key, T Function(Map<String, Object?> map) fromMap) async {
    final dbClient = await _database;
    List<Map<String, Object?>> result = await dbClient.query(_tableName);
    return result.map((map) => fromMap(map)).toList();

    // result.map(fromMap).toList();

    // result.map((map) => Item.fromMap(map)).toList();
  }
}
