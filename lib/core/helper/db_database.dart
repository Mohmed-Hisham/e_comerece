// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// class DBHelper {
//   static late Database database;

//   // name of the cache table (you can move this constant to your constants file)
//   static const String cacheTableName = 'cacheTable';

//   // bump DB version to 2 to add the cache table (if upgrading)
//   static const int _dbVersion = 1;

//   static init() async {
//     var databasesPath = await getDatabasesPath();
//     String path = join(databasesPath, 'slutk.db');
//     database = await openDatabase(
//       path,
//       version: _dbVersion,
//       onCreate: (db, version) async {
//         try {
//           // await db.execute('''
//           //   CREATE TABLE $searchTable (
//           //     $searchItemId INTEGER PRIMARY KEY,
//           //     $searchItemName TEXT NOT NULL UNIQUE
//           //   )
//           // ''');

//           // new cache table
//           await db.execute('''
//             CREATE TABLE $cacheTableName (
//               id INTEGER PRIMARY KEY AUTOINCREMENT,
//               key TEXT NOT NULL UNIQUE,
//               type TEXT NOT NULL,
//               platform TEXT,
//               value TEXT NOT NULL,
//               created_at INTEGER NOT NULL,
//               ttl INTEGER
//             )
//           ''');

//           if (kDebugMode) {
//             print('$cacheTableName table created');
//           }
//         } catch (e) {
//           if (kDebugMode) {
//             print(e.toString());
//           }
//         }
//       },
//       onUpgrade: (db, oldVersion, newVersion) async {
//         // handle upgrade: add cache table if upgrading from older version
//         if (oldVersion < 2) {
//           await db.execute('''
//             CREATE TABLE IF NOT EXISTS $cacheTableName (
//               id INTEGER PRIMARY KEY AUTOINCREMENT,
//               key TEXT NOT NULL UNIQUE,
//               type TEXT NOT NULL,
//               platform TEXT,
//               value TEXT NOT NULL,
//               created_at INTEGER NOT NULL,
//               ttl INTEGER
//             )
//           ''');
//           if (kDebugMode) print('$cacheTableName created on upgrade');
//         }
//       },
//       onOpen: (db) {
//         //
//       },
//     );
//   }

//   // -------------------- Generic CRUD --------------------

//   static Future<int> insertData({
//     required String table,
//     required Map<String, dynamic> values,
//   }) async {
//     try {
//       int row = await database.insert(
//         table,
//         values,
//         conflictAlgorithm: ConflictAlgorithm.replace,
//       );

//       return row;
//     } catch (e) {
//       throw 'is not inserted successfully: $e';
//     }
//   }

//   static Future<List<Map<String, Object?>>> queryData({
//     required String table,
//     List<String>? columns,
//     String? where,
//     List<Object?>? whereArgs,
//   }) async {
//     return await database.query(
//       table,
//       columns: columns,
//       where: where,
//       whereArgs: whereArgs,
//     );
//   }

//   static Future<int> updateData({
//     required String table,
//     required Map<String, Object?> values,
//     String? where,
//     List<Object?>? whereArgs,
//   }) async {
//     try {
//       int updatedRow = await database.update(
//         table,
//         values,
//         where: where,
//         whereArgs: whereArgs,
//       );

//       return updatedRow;
//     } catch (e) {
//       throw '$e, ${whereArgs?[0]} not updated successfully';
//     }
//   }

//   static Future<int> deleteData({
//     required String table,
//     String? where,
//     List<Object?>? whereArgs,
//   }) async {
//     try {
//       int deletedRow = await database.delete(
//         table,
//         where: where,
//         whereArgs: whereArgs,
//       );

//       return deletedRow;
//     } catch (e) {
//       throw '$e, ${whereArgs?[0]} not deleted successfully';
//     }
//   }

//   static Future<void> saveCache({
//     required String key,
//     required String type,
//     required Map<String, dynamic> data,
//     String? platform,
//     int? ttlHours,
//   }) async {
//     final values = {
//       'key': key,
//       'type': type,
//       'platform': platform,
//       'value': jsonEncode(data),
//       'created_at': DateTime.now().millisecondsSinceEpoch,
//       'ttl': ttlHours! * 3600, // convert hours to seconds
//     };

//     await insertData(table: cacheTableName, values: values);

//     if (kDebugMode) {
//       print('Cache saved: $key');
//     }
//   }

//   static Future<Map<String, dynamic>?> getCache({
//     required String key,
//     bool allowStale = false,
//   }) async {
//     final rows = await queryData(
//       table: cacheTableName,
//       columns: ['value', 'created_at', 'ttl'],
//       where: 'key = ?',
//       whereArgs: [key],
//     );

//     if (rows.isEmpty) return null;

//     final row = rows.first;
//     final String jsonStr = row['value'] as String;
//     // final int createdAt = row['created_at'] as int;
//     // final int? ttl = row['ttl'] == null ? null : (row['ttl'] as int);

//     // if (ttl != null) {
//     //   final expiry = createdAt + ttl * 1000;
//     //   final now = DateTime.now().millisecondsSinceEpoch;
//     //   if (now > expiry) {
//     //     if (!allowStale) {
//     //       // expired — delete it and return null
//     //       await deleteData(
//     //         table: cacheTableName,
//     //         where: 'key = ?',
//     //         whereArgs: [key],
//     //       );
//     //       return null;
//     //     }
//     //     // otherwise fallthrough and return stale data
//     //   }
//     // }

//     return jsonDecode(jsonStr) as Map<String, dynamic>;
//   }

//   /// Invalidate single key
//   static Future<void> invalidateCacheKey(String key) async {
//     await deleteData(table: cacheTableName, where: 'key = ?', whereArgs: [key]);
//   }

//   /// Clear all cache or only by type/platform
//   static Future<void> clearCache({String? type, String? platform}) async {
//     if (type == null && platform == null) {
//       // delete all rows
//       await deleteData(table: cacheTableName);
//     } else if (type != null && platform == null) {
//       await deleteData(
//         table: cacheTableName,
//         where: 'type = ?',
//         whereArgs: [type],
//       );
//     } else if (type == null && platform != null) {
//       await deleteData(
//         table: cacheTableName,
//         where: 'platform = ?',
//         whereArgs: [platform],
//       );
//     } else {
//       await deleteData(
//         table: cacheTableName,
//         where: 'type = ? AND platform = ?',
//         whereArgs: [type, platform],
//       );
//     }
//   }

//   /// Cleanup expired cache rows (call on app start or periodically)
//   static Future<void> cleanupExpired() async {
//     final now = DateTime.now().millisecondsSinceEpoch;
//     final rows = await queryData(
//       table: cacheTableName,
//       columns: ['key', 'created_at', 'ttl'],
//     );

//     for (var row in rows) {
//       final dynamic ttlObj = row['ttl'];
//       final int? ttl = ttlObj == null ? null : (ttlObj as int);
//       if (ttl != null) {
//         final int createdAt = row['created_at'] as int;
//         final int expiry = createdAt + ttl * 1000;
//         if (now > expiry) {
//           final String key = row['key'] as String;
//           await deleteData(
//             table: cacheTableName,
//             where: 'key = ?',
//             whereArgs: [key],
//           );
//         }
//       }
//     }
//   }

//   // -------------------- Utilities --------------------

//   static Future<List<String>> getTables(Database database) async {
//     List<Map<String, Object?>> tables = await database.rawQuery(
//       "SELECT name FROM sqlite_master WHERE type='table'",
//     );

//     List<String> tableNames = tables
//         .map((table) => table['name'] as String)
//         .toList();

//     return tableNames;
//   }

//   static Future<void> deleteDB() async {
//     String databasePath = await getDatabasesPath();
//     String path = join(databasePath, 'slutk.db');
//     return await deleteDatabase(path);
//   }
// }
