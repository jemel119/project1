import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {

  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('campus_food.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final path = join(await getDatabasesPath(), filePath);

    return openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {

    await db.execute('''
    CREATE TABLE restaurants(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      cuisine TEXT,
      price_range TEXT,
      open_hours TEXT,
      notes TEXT,
      is_favorite INTEGER DEFAULT 0
    )
    ''');

    await db.execute('''
    CREATE TABLE expenses(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      amount REAL,
      category TEXT,
      date TEXT
    )
    ''');
  }

  // RESTAURANTS
  Future<int> updateRestaurant(int id, Map<String, dynamic> restaurant) async {
  final db = await database;

  return db.update(
    'restaurants',
    restaurant,
    where: 'id = ?',
    whereArgs: [id],
  );
}

Future<int> deleteRestaurant(int id) async {
  final db = await database;

  return db.delete(
    'restaurants',
    where: 'id = ?',
    whereArgs: [id],
  );
}

  Future<int> createRestaurant(Map<String, dynamic> r) async {
    final db = await database;
    return db.insert('restaurants', r);
  }

  Future<List<Map<String, dynamic>>> getRestaurants() async {
    final db = await database;
    return db.query('restaurants', orderBy: 'name ASC');
  }

  Future<List<Map<String, dynamic>>> getFavorites() async {
    final db = await database;
    return db.query('restaurants', where: 'is_favorite = 1');
  }

  Future<int> toggleFavorite(int id, int value) async {
    final db = await database;
    return db.update(
      'restaurants',
      {'is_favorite': value},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<Map<String, dynamic>?> getRecommendedRestaurant() async {
    final db = await database;

    final result = await db.rawQuery('''
      SELECT * FROM restaurants
      ORDER BY is_favorite DESC, RANDOM()
      LIMIT 1
    ''');

    return result.isEmpty ? null : result.first;
  }

  // EXPENSES

  Future<int> createExpense(Map<String, dynamic> e) async {
    final db = await database;
    return db.insert('expenses', e);
  }

  Future<List<Map<String, dynamic>>> getExpenses() async {
    final db = await database;
    return db.query('expenses', orderBy: 'date DESC');
  }

  Future<double> getTotalSpending() async {
    final db = await database;

    final result =
        await db.rawQuery("SELECT SUM(amount) as total FROM expenses");

    return (result.first['total'] as num?)?.toDouble() ?? 0.0;
  }

  Future<List<Map<String, dynamic>>> getSpendingByCategory() async {
    final db = await database;

    return db.rawQuery('''
      SELECT category, SUM(amount) as total
      FROM expenses
      GROUP BY category
    ''');
  }
}