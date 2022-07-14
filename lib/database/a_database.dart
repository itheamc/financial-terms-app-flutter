import 'package:financial_terms/models/finance_term.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ADatabase {
  static const String _dbName = "financial_terms.db";
  static const String _termsTable = "terms";
  static const int _version = 1;

  Database? _database;

  /// Private Constructor
  ADatabase._();

  static Future<ADatabase> init() async {
    ADatabase termsDatabase = ADatabase._()
      .._database = await _createDatabase();
    return termsDatabase;
  }

  // Private static function to create and return the instance of sqlite database
  static Future<Database> _createDatabase() async {
    return await openDatabase(join(await getDatabasesPath(), _dbName),
        version: _version, onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE $_termsTable (id INTEGER PRIMARY KEY, title TEXT, body TEXT, author TEXT)');
    });
  }

  ///--------------------------------------------------------------------------
  /// Methods for CRUD operations

  /// Get all terms data if exists
  Future<List<Map<String, dynamic>>?> terms() async {
    return await _database?.query(_termsTable, orderBy: 'title ASC');
  }

  Future<FinanceTerm?> term(int id) async {
    final maps =
        await _database?.query(_termsTable, where: 'id = ?', whereArgs: [id]);
    return maps != null && maps.isNotEmpty
        ? FinanceTerm.fromJson(maps.first)
        : null;
  }

  /// Method to insert new term
  Future<bool> insertTerm(FinanceTerm term) async {
    int? res = await _database?.insert(
      _termsTable,
      term.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return res != null;
  }

  /// Method to delete the given term
  Future<bool> deleteTerm(FinanceTerm term) async {
    int? res = await _database
        ?.delete(_termsTable, where: 'id = ?', whereArgs: [term.id]);
    return res != null;
  }

  // Function to update worker
  Future<bool> updateWorker(FinanceTerm term) async {
    int? res = await _database?.update(_termsTable, term.toJson(),
        where: 'id = ?',
        whereArgs: [term.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
    return res != null;
  }

  ///---------------------------------------------------------------------------
  /// Method to close the database
  Future<void> close() async {
    if (_database != null && _database?.isOpen == true) {
      await _database?.close();
    }
  }
}
