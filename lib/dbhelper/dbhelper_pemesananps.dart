import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'pemesanan.db');

    return await openDatabase(
      path,
      version: 4, // Increment version to 4
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE pemesanan(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        tanggalPeminjaman TEXT,
        tanggalPengembalian TEXT,
        jenisPS TEXT,
        jumlahStik INTEGER,
        lokasiPemesanan TEXT,
        harga INTEGER,
        status TEXT DEFAULT 'Rent'
      )
    ''');
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('''
        ALTER TABLE pemesanan ADD COLUMN lokasiPemesanan TEXT
      ''');
    }
    if (oldVersion < 3) {
      await db.execute('''
        ALTER TABLE pemesanan ADD COLUMN harga INTEGER
      ''');
    }
    if (oldVersion < 4) {
      await db.execute('''
        ALTER TABLE pemesanan ADD COLUMN status TEXT DEFAULT 'Rent'
      ''');
    }
  }

  Future<int> insertPemesanan(Map<String, dynamic> pemesanan) async {
    final db = await database;
    return await db.insert('pemesanan', pemesanan);
  }

  Future<List<Map<String, dynamic>>> getPemesanans() async {
    final db = await database;
    return await db.query('pemesanan');
  }

  Future<int> updatePemesanan(int id, Map<String, dynamic> pemesanan) async {
    final db = await database;
    return await db.update('pemesanan', pemesanan, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deletePemesanan(int id) async {
    final db = await database;
    return await db.delete('pemesanan', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updatePemesananStatus(int id, String newStatus) async {
    final db = await database;
    return await db.update(
      'pemesanan',
      {'status': newStatus},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
