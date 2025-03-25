import 'package:flutter/material.dart';
import '../data/questions.dart';

class QuizProvider extends ChangeNotifier {
  int _currentIndex = 0;
  int _score = 0;
  List<bool?> _userAnswers = List.filled(questions.length, null);

  int get currentIndex => _currentIndex;
  int get score => _score;
  List<bool?> get userAnswers => _userAnswers;

  void answerQuestion(bool answer) {
    if (_userAnswers[_currentIndex] != null) {
      if (_userAnswers[_currentIndex] == questions[_currentIndex].answer) {
        _score -= 10;
      }
    }

    _userAnswers[_currentIndex] = answer;

    if (answer == questions[_currentIndex].answer) {
      _score += 10;
    }

    notifyListeners();
  }

  void nextQuestion() {
    if (_userAnswers[_currentIndex] != null && _currentIndex < questions.length - 1) {
      _currentIndex++;
      notifyListeners();
    }
  }

  void prevQuestion() {
    if (_currentIndex > 0) {
      _currentIndex--;
      notifyListeners();
    }
  }

  void resetQuiz() {
    _currentIndex = 0;
    _score = 0;
    _userAnswers = List.filled(questions.length, null);
    notifyListeners();
  }
}