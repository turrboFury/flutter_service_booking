// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// class DatabaseHelper {
//   static final DatabaseHelper _instance = DatabaseHelper._internal();
//   static Database? _database;

//   factory DatabaseHelper() {
//     return _instance;
//   }

//   DatabaseHelper._internal();

//   Future<Database> get database async {
//     if (_database != null) return _database!;

//     _database = await _initDatabase();
//     return _database!;
//   }

//   Future<Database> _initDatabase() async {
//     final dbPath = await getDatabasesPath();
//     final path = join(dbPath, 'appointments.db');

//     return await openDatabase(path, version: 1, onCreate: _createDB);
//   }

//   Future<void> _createDB(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE appointments (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         licensePlate TEXT,
//         brandModel TEXT,
//         year INTEGER,
//         mileage INTEGER,
//         fuelType TEXT,
//         description TEXT,
//         date TEXT
//       )
//     ''');
//   }
// }

import 'package:flutter_service_booking/models/appoiment_history.dart';

class Database {
  static final Database _instance = Database._internal();

  final List<AppointmentHistory> _database = [];

  factory Database() {
    return _instance;
  }

  Database._internal();

  bool find(String vin) {
    return _database.any((item) => item.vin == vin);
  }

  AppointmentHistory? getCarHistory(String vin) {
    return _database.firstWhere(
          (item) => item.vin == vin,
    );
  }

  void addHistory(AppointmentHistory history) {
    _database.add(history);
  }
}