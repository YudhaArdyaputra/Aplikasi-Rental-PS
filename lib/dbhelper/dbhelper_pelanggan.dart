import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper._internal();
  factory DbHelper() => _instance;

  DbHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    String path = join(await getDatabasesPath(), 'pelanggan.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE pelanggan (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nama TEXT,
        alamat TEXT,
        no_hp TEXT
      )
    ''');
  }

  Future<int> insertPelanggan(Map<String, String> pelanggan) async {
    Database db = await database;
    return await db.insert('pelanggan', pelanggan);
  }

  Future<List<Map<String, dynamic>>> getPelanggan() async {
    Database db = await database;
    return await db.query('pelanggan');
  }

  Future<int> updatePelanggan(Map<String, String> pelanggan, int id) async {
    Database db = await database;
    return await db.update('pelanggan', pelanggan, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deletePelanggan(int id) async {
    Database db = await database;
    return await db.delete('pelanggan', where: 'id = ?', whereArgs: [id]);
  }
}
