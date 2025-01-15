import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';

import '../../../data/repositories/poll_repository.dart';

Future<Response> onRequest(RequestContext context, String pollId) async {
  final repository = context.read<PollRepository>();

  if (context.request.method != HttpMethod.post) {
    return Response.json(body: {'error': 'Method not allowed'}, statusCode: 405);
  }

  final body = await context.request.body();
  final data = jsonDecode(body) as Map<String, dynamic>;

  final choiceId = data['choiceId'] as int?;
  if (choiceId == null) {
    return Response.json(body: {'error': 'Choice ID is required'}, statusCode: 400);
  }

  final parsedPollId = int.tryParse(pollId) ?? -1;
  if (parsedPollId < 0) {
    return Response.json(body: {'error': 'Invalid poll ID'}, statusCode: 400);
  }

  final isValidChoice = repository.validateChoiceForPoll(parsedPollId, choiceId);
  if (!isValidChoice) {
    return Response.json(body: {'error': 'Invalid choice for the poll'}, statusCode: 400);
  }

  repository.vote(choiceId);

  return Response.json(body: {'message': 'Vote recorded successfully'});
}
