import 'package:dart_frog/dart_frog.dart';
import '../../../data/repositories/poll_repository.dart';

Response onRequest(RequestContext context, String pollId) {
  final repository = context.read<PollRepository>();

  final poll = repository.getPollById(int.parse(pollId));
  if (poll == null) {
    return Response.json(body: {'error': 'Poll not found'}, statusCode: 404);
  }

  final response = {
    'id': poll.id,
    'title': poll.title,
    'questions': poll.questions.map((question) {
      return {
        'id': question.id,
        'text': question.text,
        'choices': question.choices.map((choice) {
          return {
            'id': choice.id,
            'text': choice.text,
            'votes': choice.votes,
          };
        }).toList(),
      };
    }).toList(),
  };

  return Response.json(body: response);
}
