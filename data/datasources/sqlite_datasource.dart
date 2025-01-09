import 'package:sqlite3/sqlite3.dart';

class SQLiteDataSource {
  late final Database db;

  void initialize() {
    db = sqlite3.open('polls.db');

    db
      ..execute('''
      CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL UNIQUE,
        password_hash TEXT NOT NULL
      );
    ''')
      ..execute('''
      CREATE TABLE IF NOT EXISTS polls (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL
      );
    ''')
      ..execute('''
      CREATE TABLE IF NOT EXISTS questions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        text TEXT NOT NULL,
        poll_id INTEGER NOT NULL,
        FOREIGN KEY (poll_id) REFERENCES polls (id)
      );
    ''')
      ..execute('''
      CREATE TABLE IF NOT EXISTS choices (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        text TEXT NOT NULL,
        votes INTEGER DEFAULT 0,
        question_id INTEGER NOT NULL,
        FOREIGN KEY (question_id) REFERENCES questions (id)
      );
    ''');
  }

  void close() {
    db.dispose();
  }
}
