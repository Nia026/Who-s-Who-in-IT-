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

    return Scaffold(
      appBar: AppBar(title: const Text("Who's Who in IT?")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(questions[quizProvider.currentIndex].text),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (quizProvider.currentIndex > 0)
                ElevatedButton(
                  onPressed: quizProvider.prevQuestion,
                  child: const Text("←"),
                ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () => quizProvider.answerQuestion(true),
                child: const Text("BENAR"),
              ),
              ElevatedButton(
                onPressed: () => quizProvider.answerQuestion(false),
                child: const Text("SALAH"),
              ),
              const SizedBox(width: 10),
              if (quizProvider.currentIndex < questions.length - 1)
                ElevatedButton(
                  onPressed: quizProvider.nextQuestion,
                  child: const Text("→"),
                ),
              if (quizProvider.currentIndex == questions.length - 1)
                ElevatedButton(
                  onPressed: () => context.go('/result'),
                  child: const Text("LIHAT NILAI"),
                ),
            ],
          ),
        ],
      ),
    );
  }
}