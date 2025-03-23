import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../data/questions.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  // Fungsi untuk mendapatkan pesan motivasi sesuai skor
  String getMotivationMessage(int score) {
    if (score == 100) {
      return "Luar biasa! Kamu menguasai dunia IT dengan sempurna! 🏆";
    } else if (score >= 70) {
      return "Hebat! Kamu sudah cukup memahami konsep IT. 🎉";
    } else if (score >= 40) {
      return "Baik! Tapi masih perlu belajar lebih banyak. 📚";
    } else {
      return "Tetap semangat! Terus belajar dan tingkatkan pemahamanmu! 💪";
    }
  }

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFD4D4F8),
      appBar: AppBar(title: const Text("HASIL QUIZ")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: screenHeight * 0.1),
            // Lingkaran skor
            Container(
              width: screenWidth * 0.45,
              height: screenWidth * 0.45,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'NILAI KAMU:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${quizProvider.score}',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            // Pesan motivasi
            Text(
              getMotivationMessage(quizProvider.score),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            // List jawaban dengan ScrollView
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(questions.length, (index) {
                    bool? userAnswer = quizProvider.userAnswers[index];
                    bool correctAnswer = questions[index].answer;
                    return Card(
                      color: Colors.white,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              questions[index].text,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "Jawaban Kamu: ${userAnswer == null ? "Tidak dijawab" : userAnswer ? "Benar" : "Salah"}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: userAnswer == correctAnswer
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                            Text(
                              "Jawaban Seharusnya: ${correctAnswer ? "Benar" : "Salah"}",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
            // Tombol kembali ke beranda
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.02,
                  horizontal: screenWidth * 0.2,
                ),
              ),
              onPressed: () {
                quizProvider.resetQuiz();
                context.go('/');
              },
              child: const Text(
                "KEMBALI",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
          ],
        ),
      ),
    );
  }
}