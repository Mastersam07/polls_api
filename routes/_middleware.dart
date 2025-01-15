import 'package:dart_frog/dart_frog.dart';

import '../data/datasources/json_datasource.dart';
import '../data/repositories/poll_repository.dart';

Handler middleware(Handler handler) {
  final dataSource = JSONDataSource('data/polls.json');

  final pollRepository = PollRepository(dataSource);

  return handler
      .use(provider<PollRepository>((context) => pollRepository));
}
