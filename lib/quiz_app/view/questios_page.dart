import 'package:flutter/material.dart';

import '../controllers/question_list.dart';

class QuestionsPage extends StatefulWidget {
  final QuizController quizController;

  const QuestionsPage({
    super.key,
    required this.quizController,
  });

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  @override
  Widget build(BuildContext context) {
    int questionIndex = widget.quizController.questionIndex;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: RichText(
          text: const TextSpan(
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Question Number & Progress Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Question ${questionIndex + 1}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                Text(
                  "${(widget.quizController.getProgress() * 100).toInt()}%",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.deepPurple.shade300,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Progress Bar
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: widget.quizController.getProgress(),
                minHeight: 10,
                color: Colors.deepPurpleAccent,
                backgroundColor: Colors.deepPurple.withOpacity(.1),
              ),
            ),

            const SizedBox(height: 30),

            // Question Title Card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.deepPurple.withOpacity(.05),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.deepPurple.withOpacity(.1),
                ),
              ),
              child: Text(
                widget.quizController
                    .currentQuestions[questionIndex]
                    .questionTitle,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  height: 1.3,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Option 1
            _buildOptionCard(index: 0, questionIndex: questionIndex),

            const SizedBox(height: 12),

            // Option 2
            _buildOptionCard(index: 1, questionIndex: questionIndex),

            const SizedBox(height: 12),

            // Option 3
            _buildOptionCard(index: 2, questionIndex: questionIndex),

            const Spacer(),

            // Next Button (Match Main Screen Button Style)
            SizedBox(
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent,
                  disabledBackgroundColor: Colors.deepPurpleAccent.withOpacity(0.4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 0,
                ),
                onPressed: widget.quizController.selectedValue == null
                    ? null
                    : () {
                  widget.quizController.nextQuestion();
                  setState(() {

                  });
                },
                child:
                Text(
                  widget.quizController.questionIndex == widget.quizController.currentQuestions.length - 1
                      ? "Finish Quiz"
                      : "Next",

                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  // WIDGET لخسارة التكرار مع الحفاظ على الكروت بنفس نمط الـ Categories
  Widget _buildOptionCard({required int index, required int questionIndex}) {
    final optionValue = widget
        .quizController
        .currentQuestions[questionIndex]
        .answers[index];

    final isSelected = widget.quizController.selectedValue == optionValue;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: isSelected
            ? Colors.deepPurple.withOpacity(.15)
            : Colors.grey.shade100,
        border: Border.all(
          color: isSelected
              ? Colors.deepPurpleAccent
              : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: RadioListTile<String>(
        activeColor: Colors.deepPurple,
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        title: Text(
          optionValue,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? Colors.deepPurple : Colors.black87,
          ),
        ),
        value: optionValue,
        groupValue: widget.quizController.selectedValue,
        onChanged: (value) {
          setState(() {
            widget.quizController.selectedValue = value;
          });
        },
      ),
    );
  }
}