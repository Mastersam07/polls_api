import '../../core/models/poll.dart';
import '../datasources/sqlite_datasource.dart';

class PollRepository {
  PollRepository(this.dataSource);
  final SQLiteDataSource dataSource;

  /// Fetch all polls
  List<Poll> getAllPolls() {
    final result = dataSource.db.select('SELECT * FROM polls');
    return result.map((row) {
      return Poll(
        id: row['id'] as int,
        title: row['title'] as String,
      );
    }).toList();
  }

  /// Get details of a poll by ID
  Poll? getPollById(int pollId) {
    final pollResult = dataSource.db.select(
      'SELECT * FROM polls WHERE id = ?',
      [pollId],
    );

    if (pollResult.isEmpty) return null;

    final pollRow = pollResult.first;
    final poll = Poll(
      id: pollRow['id'] as int,
      title: pollRow['title'] as String,
    );

    // Get questions for the poll
    final questionResult = dataSource.db.select(
      'SELECT * FROM questions WHERE poll_id = ?',
      [pollId],
    );

    final questions = questionResult.map((questionRow) {
      final questionId = questionRow['id'] as int;

      // Get choices for the question
      final choiceResult = dataSource.db.select(
        'SELECT * FROM choices WHERE question_id = ?',
        [questionId],
      );

      final choices = choiceResult.map((choiceRow) {
        return Choice(
          id: choiceRow['id'] as int,
          text: choiceRow['text'] as String,
          votes: choiceRow['votes'] as int,
        );
      }).toList();

      return Question(
        id: questionId,
        text: questionRow['text'] as String,
        choices: choices,
      );
    }).toList();

    return Poll(
      id: poll.id,
      title: poll.title,
      questions: questions,
    );
  }

  /// Validate if a choice belongs to a poll
  bool validateChoiceForPoll(int pollId, int choiceId) {
    final result = dataSource.db.select(
      '''
      SELECT choices.id
      FROM choices
      INNER JOIN questions ON questions.id = choices.question_id
      WHERE questions.poll_id = ? AND choices.id = ?
    ''',
      [pollId, choiceId],
    );

    return result.isNotEmpty;
  }

  /// Cast a vote on a choice
  void vote(int choiceId) {
    dataSource.db.execute(
      'UPDATE choices SET votes = votes + 1 WHERE id = ?',
      [choiceId],
    );
  }

  /// Get poll results (questions and their choices with vote counts)
  List<Question> getPollResults(int pollId) {
    final questionResult = dataSource.db.select(
      'SELECT * FROM questions WHERE poll_id = ?',
      [pollId],
    );

    return questionResult.map((questionRow) {
      final questionId = questionRow['id'] as int;

      // Get choices for the question
      final choiceResult = dataSource.db.select(
        'SELECT * FROM choices WHERE question_id = ?',
        [questionId],
      );

      final choices = choiceResult.map((choiceRow) {
        return Choice(
          id: choiceRow['id'] as int,
          text: choiceRow['text'] as String,
          votes: choiceRow['votes'] as int,
        );
      }).toList();

      return Question(
        id: questionId,
        text: questionRow['text'] as String,
        choices: choices,
      );
    }).toList();
  }
}
