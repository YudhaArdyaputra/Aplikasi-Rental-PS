import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._init();
  static Database? _database;

  DBHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('pelanggan.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    const pelangganTable = '''
    CREATE TABLE pelanggan (
      id_pelanggan INTEGER PRIMARY KEY AUTOINCREMENT,
      id_user TEXT,
      nama TEXT,
      alamat TEXT,
      nohp TEXT
    )
    ''';

    await db.execute(pelangganTable);
  }

  Future<void> createPelanggan(Map<String, dynamic> pelanggan) async {
    final db = await instance.database;
    await db.insert('pelanggan', pelanggan);
  }

  Future<List<Map<String, dynamic>>> readAllPelanggan() async {
    final db = await instance.database;
    final result = await db.query('pelanggan');
    return result;
  }

  Future<int> updatePelanggan(Map<String, dynamic> pelanggan) async {
    final db = await instance.database;
    final id = pelanggan['id_pelanggan'];
    return db.update(
      'pelanggan',
      pelanggan,
      where: 'id_pelanggan = ?',
      whereArgs: [id],
    );
  }

  Future<int> deletePelanggan(int id) async {
    final db = await instance.database;
    return await db.delete(
      'pelanggan',
      where: 'id_pelanggan = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
