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
  List<AppointmentHistory> _database = new AppointmentHistory(vin: '2000')

  factory Database() {
    return _instance;
  }

  Database._internal();

  bool find(String item) {
    return _database.contains(item);
  }
 
  AppointmentHistory getCarHistory(String vin) => _database.where((item)=> item.);
}
