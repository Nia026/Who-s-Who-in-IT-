import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../data/questions.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen ({super.key});

  String getMotivationMessage (int score) {
    if (score == 100) {
      return "Luar biasa! Kamu menguasai dunia IT dengan sempurna!";
    }
    else if (score >= 70) {
      return "Hebat! Kamu sudah cukup memahami konsep IT.";
    }
    else if (score >= 40) {
      return "Baik! Tapi masih perlu belajar lebih banyak.";
    }
    else {
      return "Tetap semangat! Terus belajar dan tingkatkan pemahamanmu!";
    }
  }

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("HASIL QUIZ")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Skor Kamu: ${quizProvider.score}",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text (
              getMotivationMessage(quizProvider.score),
              textAlign: TextAlign.center,
              style:  const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  bool? userAnswer = quizProvider.userAnswers[index];
                  bool correctAnswer = questions[index].answer;
                  return Card (
                    color: userAnswer ==  correctAnswer ? Colors.green[100] : Colors.red[100],
                    child: ListTile(
                      title: Text(questions[index].text),
                      subtitle: Text(
                        "Jawaban Kamu: ${userAnswer == null ? "Tidak dijawab" : userAnswer ? "Benar" : "Salah"}\n"
                        "Jawaban Seharusnya: ${correctAnswer ? "Benar" : "Salah"}",
                        style: TextStyle(
                          color: userAnswer == correctAnswer ? Colors.green[100] : Colors.red[100],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                quizProvider.resetQuiz();
                context.go('/');
              },
              child: const Text("Kembali ke Beranda"),
            ),
          ],
        ),
      ),
    );
  }
}