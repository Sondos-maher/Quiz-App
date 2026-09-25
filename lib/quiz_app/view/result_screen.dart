import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'home_screen.dart';
import '../controllers/question_list.dart';

class ResultScreen extends StatefulWidget {
  final int score;
  final QuizController quizController;

  const ResultScreen({
    super.key,
    required this.score,
    required this.quizController,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    final totalQuestions = widget.quizController.currentQuestions.length;
    final percentage = (widget.score / totalQuestions) * 100;
    final bool isPassed = percentage >= 50;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: RichText(
          text: const TextSpan(
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            children: [
              TextSpan(
                text: 'Quiz',
                style: TextStyle(color: Colors.deepPurple),
              ),
              TextSpan(
                text: 'App',
                style: TextStyle(color: Colors.deepPurpleAccent),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            children: [
              const Spacer(),

              // كارت النتيجة الرئيسي
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepPurple.withOpacity(0.08),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // آيقونة ديناميكية تتغير حسب النتيجة
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isPassed
                            ? Colors.amber.withOpacity(0.12)
                            : Colors.deepPurple.withOpacity(0.08),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isPassed
                            ? Icons.emoji_events_rounded
                            : Icons.sentiment_dissatisfied_rounded,
                        color: isPassed ? Colors.amber : Colors.deepPurpleAccent,
                        size: 64,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // عنوان التهنئة بناءً على النتيجة
                    Text(
                      isPassed ? "Great Job!" : "Better Luck Next Time!",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    const SizedBox(height: 6),

                    Text(
                      "You completed the quiz successfully",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // استايل السكور الدائري
                    CircleAvatar(
                      backgroundColor: Colors.deepPurple.withOpacity(.2),
                      radius: 95,
                      child: CircleAvatar(
                        backgroundColor: Colors.deepPurple,
                        radius: 82,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Your Score",
                              style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "${widget.score} / $totalQuestions",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 28,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // زر إعادة الاختبار
              SizedBox(
                height: 56,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    elevation: 4,
                    shadowColor: Colors.deepPurpleAccent.withOpacity(0.4),
                  ),
                  onPressed: () {
                    Get.offAll(() => const HomeScreen());
                  },
                  child: const Text(
                    "Restart Quiz",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}