import 'package:sqlite3/sqlite3.dart';

void main() {
  final db = sqlite3.open('polls.db')

    // Create tables if they don't exist
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
  ''')

    // Insert sample data into the polls table
    ..execute('DELETE FROM polls;')
    ..execute('DELETE FROM questions;')
    ..execute('DELETE FROM choices;')
    ..execute('DELETE FROM users;')
    ..execute("INSERT INTO polls (title) VALUES ('Favorite Programming Language');")
    ..execute("INSERT INTO polls (title) VALUES ('Best Framework');")

    // Insert questions and choices
    ..execute("INSERT INTO questions (text, poll_id) VALUES ('What is your favorite programming language?', 1);")
    ..execute("INSERT INTO questions (text, poll_id) VALUES ('Which programming language do you dislike most?', 1);")
    ..execute("INSERT INTO choices (text, votes, question_id) VALUES ('Dart', 0, 1);")
    ..execute("INSERT INTO choices (text, votes, question_id) VALUES ('Python', 0, 1);")
    ..execute("INSERT INTO choices (text, votes, question_id) VALUES ('JavaScript', 0, 1);")
    ..execute("INSERT INTO choices (text, votes, question_id) VALUES ('PHP', 0, 2);")
    ..execute("INSERT INTO choices (text, votes, question_id) VALUES ('Perl', 0, 2);")
    ..execute("INSERT INTO choices (text, votes, question_id) VALUES ('C++', 0, 2);");

  print('Database seeded successfully!');

  db.dispose();
}
