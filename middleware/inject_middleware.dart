import 'package:dart_frog/dart_frog.dart';
import '../data/datasources/sqlite_datasource.dart';
import '../data/repositories/poll_repository.dart';

Middleware injectDependencies(SQLiteDataSource dataSource) {
  final pollRepository = PollRepository(dataSource);

  return (handler) {
    return (context) {
      return handler(
        context.provide<PollRepository>(() => pollRepository),
      );
    };
  };
}
