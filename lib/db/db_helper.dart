import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../core/utils/constants.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._();
  DBHelper._();
  factory DBHelper() => _instance;

  Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await openDatabase(
      join(await getDatabasesPath(), Constants.DB_NAME),
      onCreate: (db, v) => db.execute('''
        CREATE TABLE ${Constants.MSG_TABLE}(
          id INTEGER PRIMARY KEY,
          senderId TEXT,
          receiverId TEXT,
          message TEXT,
          timestamp TEXT
        )
      '''),
      version: 1,
    );
    return _db!;
  }
}
