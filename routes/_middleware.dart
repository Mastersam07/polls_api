import 'package:dart_frog/dart_frog.dart';

import '../data/datasources/sqlite_datasource.dart';
import '../data/repositories/auth_repository.dart';
import '../data/repositories/poll_repository.dart';

Handler middleware(Handler handler) {
  final dataSource = SQLiteDataSource()..initialize();

  final pollRepository = PollRepository(dataSource);
  final authRepository = AuthRepository(dataSource);

  return handler
      .use(provider<PollRepository>((context) => pollRepository))
      .use(provider<AuthRepository>((context) => authRepository));
}
