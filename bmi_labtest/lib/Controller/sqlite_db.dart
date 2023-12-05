import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLiteDB{
  // Define the name of the SQLite database
  static const String _dbName = "bitp3453_bmi";

  // Database instance
  Database? _db;

  // Private constructor
  SQLiteDB._();

  // Singleton instance of SQLiteDB
  static final SQLiteDB _instance = SQLiteDB._();

  // Factory constructor to return the singleton instance
  factory SQLiteDB(){
    return _instance;
  }

  // Getter to obtain the database instance
  Future<Database> get database async {
    if(_db != null){
      return _db!;
    }
    // If the database instance is null, create and initialize it
    String path = join(await getDatabasesPath(), _dbName,);
    _db = await openDatabase(
      path, version: 1,
      onCreate: (createDb, version) async {
      // Execute SQL commands to create tables when the database is created
      for(String tableSql in SQLiteDB.tableSQLStrings){
        await createDb.execute(tableSql);
      }
    },);
    // Return the initialized database instance
    return _db!;
  }

  // List of SQL strings to create tables in the database
  static List<String> tableSQLStrings =
  [
    '''
        CREATE TABLE IF NOT EXISTS bmi (
            _colUsername TEXT,
            _colWeight REAL,
            _colHeight REAL,
            _colGender TEXT,
            _colStatus TEXT)

             ''',
  ];

  // Function to insert data into the specified table
  Future<int> insert(String tableName, Map<String, dynamic> row) async {
    Database db = await _instance.database;
    return await db.insert(tableName, row);
  }

  // Function to query all data from the specified table
  Future<List<Map<String, dynamic>>> queryAll(String tableName) async {
    Database db = await _instance.database;
    return await db.query(tableName);
  }

}