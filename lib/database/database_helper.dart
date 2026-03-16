// Import required packages
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// DatabaseHelper class - Singleton pattern
class DatabaseHelper {

  // Singleton instance
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  // Private constructor
  DatabaseHelper._init();

  // Get database instance
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('campus_food.db');
    return _database!;
  }

  // Initialize database
  Future<Database> _initDB(String filePath) async {

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  // Create database tables
  Future _createDB(Database db, int version) async {

    await db.execute('''
      CREATE TABLE restaurants (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        cuisine TEXT,
        price_range TEXT,
        open_hours TEXT,
        notes TEXT,
        is_favorite INTEGER DEFAULT 0
      )
    ''');

    await db.execute('''
      CREATE TABLE expenses (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        restaurant_id INTEGER,
        amount REAL NOT NULL,
        date TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE reviews (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        restaurant_id INTEGER,
        rating INTEGER,
        comment TEXT,
        date TEXT
      )
    ''');
  }

  // -------------------------------
  // RESTAURANT CRUD OPERATIONS
  // -------------------------------

  // CREATE restaurant
  Future<int> createRestaurant(Map<String, dynamic> restaurant) async {
    final db = await instance.database;
    return await db.insert('restaurants', restaurant);
  }

  // READ all restaurants
  Future<List<Map<String, dynamic>>> getRestaurants() async {
    final db = await instance.database;
    return await db.query('restaurants', orderBy: 'name ASC');
  }

  // READ single restaurant
  Future<Map<String, dynamic>?> getRestaurant(int id) async {
    final db = await instance.database;

    final results = await db.query(
      'restaurants',
      where: 'id = ?',
      whereArgs: [id],
    );

    return results.isNotEmpty ? results.first : null;
  }

  // UPDATE restaurant
  Future<int> updateRestaurant(int id, Map<String, dynamic> restaurant) async {
    final db = await instance.database;

    return await db.update(
      'restaurants',
      restaurant,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // DELETE restaurant
  Future<int> deleteRestaurant(int id) async {
    final db = await instance.database;

    return await db.delete(
      'restaurants',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // -------------------------------
  // EXPENSE CRUD OPERATIONS
  // -------------------------------

  // CREATE expense
  Future<int> createExpense(Map<String, dynamic> expense) async {
    final db = await instance.database;
    return await db.insert('expenses', expense);
  }

  // READ all expenses
  Future<List<Map<String, dynamic>>> getExpenses() async {
    final db = await instance.database;
    return await db.query('expenses', orderBy: 'date DESC');
  }

  // DELETE expense
  Future<int> deleteExpense(int id) async {
    final db = await instance.database;

    return await db.delete(
      'expenses',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // -------------------------------
  // REVIEW CRUD OPERATIONS
  // -------------------------------

  // CREATE review
  Future<int> createReview(Map<String, dynamic> review) async {
    final db = await instance.database;
    return await db.insert('reviews', review);
  }

  // READ reviews for restaurant
  Future<List<Map<String, dynamic>>> getReviews(int restaurantId) async {
    final db = await instance.database;

    return await db.query(
      'reviews',
      where: 'restaurant_id = ?',
      whereArgs: [restaurantId],
    );
  }

  // Close database connection
  Future close() async {
    final db = await instance.database;
    db.close();
  }

  Future<double> getTotalSpending() async {
  final db = await instance.database;

  final result =
      await db.rawQuery("SELECT SUM(amount) as total FROM expenses");

  double total = (result.first['total'] as num?)?.toDouble() ?? 0.0;

  return total;
}
}