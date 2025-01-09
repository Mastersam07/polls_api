import 'package:dart_frog/dart_frog.dart';
import '../../data/repositories/poll_repository.dart';

Response onRequest(RequestContext context) {
  final repository = context.read<PollRepository>();

  final polls = repository.getAllPolls();
  final response = polls
      .map(
        (poll) => {
          'id': poll.id,
          'title': poll.title,
        },
      )
      .toList();

  return Response.json(body: response);
}
