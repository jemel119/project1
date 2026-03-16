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

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
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

    await db.execute('''
    CREATE TABLE reviews(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      restaurant_id INTEGER,
      rating INTEGER,
      comment TEXT,
      date TEXT
    )
    ''');
  }

  // RESTAURANTS

  Future<int> createRestaurant(Map<String, dynamic> restaurant) async {
    final db = await instance.database;
    return await db.insert('restaurants', restaurant);
  }

  Future<List<Map<String, dynamic>>> getRestaurants() async {
    final db = await instance.database;
    return await db.query('restaurants', orderBy: 'name ASC');
  }

  Future<Map<String, dynamic>?> getRestaurant(int id) async {

    final db = await instance.database;

    final result = await db.query(
      'restaurants',
      where: 'id = ?',
      whereArgs: [id],
    );

    return result.isNotEmpty ? result.first : null;
  }

  Future<int> updateRestaurant(int id, Map<String, dynamic> restaurant) async {

    final db = await instance.database;

    return db.update(
      'restaurants',
      restaurant,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // EXPENSES

  Future<int> createExpense(Map<String, dynamic> expense) async {

    final db = await instance.database;

    return db.insert('expenses', expense);
  }

  Future<List<Map<String, dynamic>>> getExpenses() async {

    final db = await instance.database;

    return db.query('expenses', orderBy: 'date DESC');
  }

  Future<double> getTotalSpending() async {

    final db = await instance.database;

    final result =
        await db.rawQuery("SELECT SUM(amount) as total FROM expenses");

    double total = (result.first['total'] as num?)?.toDouble() ?? 0.0;

    return total;
  }

  // CATEGORY ANALYTICS

  Future<List<Map<String, dynamic>>> getSpendingByCategory() async {

    final db = await instance.database;

    return await db.rawQuery('''
      SELECT category, SUM(amount) as total
      FROM expenses
      GROUP BY category
    ''');
  }

  // RECOMMENDATION LOGIC

  Future<Map<String, dynamic>?> getRecommendedRestaurant() async {

    final db = await instance.database;

    final result = await db.rawQuery('''
      SELECT * FROM restaurants
      ORDER BY is_favorite DESC, RANDOM()
      LIMIT 1
    ''');

    if (result.isEmpty) return null;

    return result.first;
  }
}