class User {
  User({
    required this.id,
    required this.username,
    required this.passwordHash,
  });

  factory User.fromRow(Map<String, dynamic> row) {
    return User(
      id: row['id'] as int,
      username: row['username'] as String,
      passwordHash: row['password_hash'] as String,
    );
  }
  final int id;
  final String username;
  final String passwordHash;
}
