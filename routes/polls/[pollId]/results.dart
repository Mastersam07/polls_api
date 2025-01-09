import 'package:dart_frog/dart_frog.dart';

import '../../../data/repositories/poll_repository.dart';

Response onRequest(RequestContext context, String pollId) {
  final repository = context.read<PollRepository>();

  final parsedPollId = int.tryParse(pollId) ?? -1;
  if (parsedPollId < 0) {
    return Response.json(
      body: {'error': 'Invalid poll ID'},
      statusCode: 400,
    );
  }

  final questions = repository.getPollResults(parsedPollId);
  if (questions.isEmpty) {
    return Response.json(
      body: {'error': 'Poll not found or no results available'},
      statusCode: 404,
    );
  }

  final response = {
    'pollId': parsedPollId,
    'questions': questions.map((question) {
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
