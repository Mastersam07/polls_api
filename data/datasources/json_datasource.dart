// ignore_for_file: avoid_dynamic_calls, inference_failure_on_collection_literal

import 'dart:convert';
import 'dart:io';

class JSONDataSource {
  JSONDataSource(String filePath) {
    jsonFile = File(filePath);
    if (!jsonFile.existsSync()) {
      jsonFile
        ..createSync(recursive: true)
        ..writeAsStringSync(
          jsonEncode({
            'polls': [],
            'questions': [],
            'choices': [],
          }),
        );
    }
    _loadData();
  }
  late final File jsonFile;
  late Map<String, dynamic> _data;

  void _loadData() {
    final content = jsonFile.readAsStringSync();
    _data = jsonDecode(content) as Map<String, dynamic>;
  }

  void saveData() {
    jsonFile.writeAsStringSync(jsonEncode(_data));
  }

  List<dynamic> _getCollection(String collectionName) {
    return _data[collectionName] as List<dynamic>;
  }

  void addPoll(Map<String, dynamic> poll) {
    final polls = _getCollection('polls');
    poll['id'] = polls.isEmpty ? 1 : polls.last['id'] + 1;
    polls.add(poll);
    saveData();
  }

  void addQuestion(Map<String, dynamic> question) {
    final questions = _getCollection('questions');
    question['id'] = questions.isEmpty ? 1 : questions.last['id'] + 1;
    questions.add(question);
    saveData();
  }

  void addChoice(Map<String, dynamic> choice) {
    final choices = _getCollection('choices');
    choice['id'] = choices.isEmpty ? 1 : choices.last['id'] + 1;
    choices.add(choice);
    saveData();
  }

  List<dynamic> getPolls() => _getCollection('polls');
  List<dynamic> getQuestions() => _getCollection('questions');
  List<dynamic> getChoices() => _getCollection('choices');

  void close() {}
}
