class Poll {
  Poll({
    required this.id,
    required this.title,
    this.questions = const [],
  });

  final int id;
  final String title;
  final List<Question> questions;
}

class Question {
  Question({
    required this.id,
    required this.text,
    this.choices = const [],
  });

  final int id;
  final String text;
  final List<Choice> choices;
}

class Choice {
  Choice({
    required this.id,
    required this.text,
    required this.votes,
  });

  final int id;
  final String text;
  final int votes;
}
