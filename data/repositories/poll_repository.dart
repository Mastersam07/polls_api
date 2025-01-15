// ignore_for_file: avoid_dynamic_calls

import '../../core/models/poll.dart';
import '../datasources/json_datasource.dart';

class PollRepository {
  PollRepository(this.dataSource);
  final JSONDataSource dataSource;

  /// Fetch all polls
  List<Poll> getAllPolls() {
    final polls = dataSource.getPolls();
    return polls.map((poll) {
      return Poll(
        id: poll['id'] as int,
        title: poll['title'] as String,
      );
    }).toList();
  }

  /// Get details of a poll by ID
  Poll? getPollById(int pollId) {
    final polls = dataSource.getPolls();
    final pollData = polls.firstWhere((poll) => poll['id'] == pollId, orElse: () => null);
    if (pollData == null) return null;

    final questions = dataSource.getQuestions().where((q) => q['poll_id'] == pollId).map((question) {
      final questionId = question['id'] as int;

      final choices = dataSource.getChoices().where((c) => c['question_id'] == questionId).map((choice) {
        return Choice(
          id: choice['id'] as int,
          text: choice['text'] as String,
          votes: choice['votes'] as int,
        );
      }).toList();

      return Question(
        id: questionId,
        text: question['text'] as String,
        choices: choices,
      );
    }).toList();

    return Poll(
      id: pollData['id'] as int,
      title: pollData['title'] as String,
      questions: questions,
    );
  }

  /// Validate if a choice belongs to a poll
  bool validateChoiceForPoll(int pollId, int choiceId) {
    final questions = dataSource.getQuestions().where((q) => q['poll_id'] == pollId);
    for (final question in questions) {
      final choices = dataSource.getChoices().where((c) => c['question_id'] == question['id']);
      if (choices.any((c) => c['id'] == choiceId)) {
        return true;
      }
    }
    return false;
  }

  /// Cast a vote on a choice
  void vote(int choiceId) {
    final choices = dataSource.getChoices();
    final choice = choices.firstWhere((c) => c['id'] == choiceId, orElse: () => null);
    if (choice != null) {
      choice['votes'] = (choice['votes'] as int) + 1;
      dataSource.saveData();
    }
  }

  /// Get poll results (questions and their choices with vote counts)
  List<Question> getPollResults(int pollId) {
    final questions = dataSource.getQuestions().where((q) => q['poll_id'] == pollId).map((question) {
      final questionId = question['id'] as int;

      final choices = dataSource.getChoices().where((c) => c['question_id'] == questionId).map((choice) {
        return Choice(
          id: choice['id'] as int,
          text: choice['text'] as String,
          votes: choice['votes'] as int,
        );
      }).toList();

      return Question(
        id: questionId,
        text: question['text'] as String,
        choices: choices,
      );
    }).toList();

    return questions;
  }
}
