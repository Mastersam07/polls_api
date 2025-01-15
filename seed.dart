import 'dart:convert';
import 'dart:io';

void main() {
  const filePath = 'data/polls.json';
  final file = File(filePath);

  if (!file.existsSync()) {
    file.createSync(recursive: true);
  }

  final data = {
    'polls': [
      {'id': 1, 'title': 'Favorite Programming Language'},
      {'id': 2, 'title': 'Best Framework'},
    ],
    'questions': [
      {'id': 1, 'text': 'What is your favorite programming language?', 'poll_id': 1},
      {'id': 2, 'text': 'Which programming language do you dislike most?', 'poll_id': 1},
    ],
    'choices': [
      {'id': 1, 'text': 'Dart', 'votes': 0, 'question_id': 1},
      {'id': 2, 'text': 'Python', 'votes': 0, 'question_id': 1},
      {'id': 3, 'text': 'JavaScript', 'votes': 0, 'question_id': 1},
      {'id': 4, 'text': 'PHP', 'votes': 0, 'question_id': 2},
      {'id': 5, 'text': 'Perl', 'votes': 0, 'question_id': 2},
      {'id': 6, 'text': 'C++', 'votes': 0, 'question_id': 2},
    ],
  };

  file.writeAsStringSync(jsonEncode(data));
  print('Data seeded to $filePath');
}
