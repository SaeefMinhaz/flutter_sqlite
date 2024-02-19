import 'package:sqflite/sqflite.dart';

class DatabaseProvider{

  static final DatabaseProvider instance = DatabaseProvider._init();
  static Database? _db;

  DatabaseProvider._init();
}