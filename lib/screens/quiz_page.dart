import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../data/questions.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);
    final currentQuestion = questions[quizProvider.currentIndex];
    final userAnswer = quizProvider.userAnswers[quizProvider.currentIndex];

    return Scaffold(
      backgroundColor: const Color(0xFFD4D4F8),
      appBar: AppBar(title: const Text("HALAMAN QUIZ")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Text(
                  currentQuestion.text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _AnswerButton(
                    text: "BENAR",
                    isSelected: userAnswer == true,
                    onPressed: () {
                      quizProvider.answerQuestion(true);
                    },
                    defaultColor: const Color(0xFF81C784),
                    selectedColor: const Color(0xFF4CAF50),
                  ),
                  const SizedBox(width: 20),
                  _AnswerButton(
                    text: "SALAH",
                    isSelected: userAnswer == false,
                    onPressed: () {
                      quizProvider.answerQuestion(false);
                    },
                    defaultColor: const Color(0xFFE57373),
                    selectedColor: const Color(0xFFF44336),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (quizProvider.currentIndex > 0)
                    _NavButton(
                      icon: Icons.arrow_back,
                      onPressed: quizProvider.prevQuestion,
                    ),
                  const SizedBox(width: 20),
                  if (quizProvider.currentIndex == questions.length - 1)
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: _NavButton(
                        icon: Icons.check,
                        onPressed: userAnswer == null ? null : () => context.go('/result'),
                        label: "LIHAT JAWABAN",
                      ),
                    )
                  else
                    _NavButton(
                      icon: Icons.arrow_forward,
                      onPressed: userAnswer == null ? null : quizProvider.nextQuestion,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AnswerButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;
  final Color defaultColor;
  final Color selectedColor;

  const _AnswerButton({
    required this.text,
    required this.isSelected,
    required this.onPressed,
    required this.defaultColor,
    required this.selectedColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? selectedColor : defaultColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final String? label;

  const _NavButton({required this.icon, this.onPressed, this.label});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(15),
      ),
      child: label != null
          ? Text(
        label!,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
      )
          : Icon(icon, color: Colors.black, size: 24),
    );
  }
}