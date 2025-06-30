import 'dart:async';
import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:gowagr_mobile_assessment/core/services/caching/cache_registry.dart';
import 'package:gowagr_mobile_assessment/core/services/caching/cache_service_abstract.dart';

class CacheServiceImpl<T> implements CacheServiceAbstract<T> {
  late final String _tableName;
  late final T Function(String) _fromJson;
  late final String Function(T) _toJson;
  static Database? _db;

  CacheServiceImpl() {
    final meta = CacheRegistry.get<T>();
    _tableName = meta.tableName;
    _fromJson = (str) => meta.fromJson(jsonDecode(str)) as T;
    _toJson = (value) => jsonEncode(meta.toJson(value));
  }

  Future<Database> get _database async {
    if (_db != null) return _db!;
    final dir = await getApplicationDocumentsDirectory();
    final path = join(dir.path, 'app_cache.db');
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, _) {
        return db.execute('''
        CREATE TABLE IF NOT EXISTS $_tableName (
          key TEXT PRIMARY KEY,
          value TEXT
        )
      ''');
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
    final result = await db.query(_tableName, columns: ['key'], where: 'key = ?', whereArgs: [key]);
    return result.isNotEmpty;
  }
}
