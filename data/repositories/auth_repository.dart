import '../../core/models/user.dart';
import '../datasources/sqlite_datasource.dart';

class AuthRepository {
  AuthRepository(this.dataSource);
  final SQLiteDataSource dataSource;

  /// Get a user by username
  User? getUserByUsername(String username) {
    final result = dataSource.db.select(
      'SELECT * FROM users WHERE username = ?',
      [username],
    );

    if (result.isEmpty) return null;

    final row = result.first;
    return User.fromRow(row);
  }

  /// Register a new user
  void registerUser(String username, String passwordHash) {
    dataSource.db.execute(
      'INSERT INTO users (username, password_hash) VALUES (?, ?)',
      [username, passwordHash],
    );
  }
}
