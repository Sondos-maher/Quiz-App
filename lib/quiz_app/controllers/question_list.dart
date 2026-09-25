import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../model/question_model.dart';
import '../view/result_screen.dart';

class QuizController {
  String? selectedValue;
  int questionIndex = 0;
  String? selectedcategory;
  int score = 0;
  List<QuestionModel> currentQuestions = [];

  final List<QuestionModel> GenaralQuestions = [
    QuestionModel(
      questionTitle: "What is the capital of Egypt?",
      answers: ["Cairo", "Alexandria", "Giza"],
      correctAnswer: "Cairo",
    ),
    QuestionModel(
      questionTitle: "Which planet is known as the Red Planet?",
      answers: ["Earth", "Mars", "Jupiter"],
      correctAnswer: "Mars",
    ),
    QuestionModel(
      questionTitle: "What is the largest ocean on Earth?",
      answers: ["Atlantic Ocean", "Indian Ocean", "Pacific Ocean"],
      correctAnswer: "Pacific Ocean",
    ),
    QuestionModel(
      questionTitle: "How many days are there in a leap year?",
      answers: ["365", "366", "367"],
      correctAnswer: "366",
    ),
    QuestionModel(
      questionTitle: "Which language has the most native speakers?",
      answers: ["English", "Mandarin Chinese", "Spanish"],
      correctAnswer: "Mandarin Chinese",
    ),
    QuestionModel(
      questionTitle: "What is the currency of Japan?",
      answers: ["Yen", "Dollar", "Euro"],
      correctAnswer: "Yen",
    ),
  ];

  final List<QuestionModel> ScienceQuestions = [
    QuestionModel(
      questionTitle: "What is the chemical symbol for Water?",
      answers: ["H2O", "CO2", "O2"],
      correctAnswer: "H2O",
    ),
    QuestionModel(
      questionTitle: "What gas do plants absorb from the atmosphere?",
      answers: ["Oxygen", "Carbon Dioxide", "Nitrogen"],
      correctAnswer: "Carbon Dioxide",
    ),
    QuestionModel(
      questionTitle: "What is the hardest natural substance on Earth?",
      answers: ["Gold", "Iron", "Diamond"],
      correctAnswer: "Diamond",
    ),
    QuestionModel(
      questionTitle: "How many bones are there in the adult human body?",
      answers: ["206", "208", "210"],
      correctAnswer: "206",
    ),
    QuestionModel(
      questionTitle: "What organ is responsible for pumping blood in humans?",
      answers: ["Lungs", "Brain", "Heart"],
      correctAnswer: "Heart",
    ),
    QuestionModel(
      questionTitle: "What force keeps us on the ground?",
      answers: ["Friction", "Gravity", "Magnetism"],
      correctAnswer: "Gravity",
    ),
  ];

  final List<QuestionModel> SportQuestions = [
    QuestionModel(
      questionTitle: "Which country won the FIFA World Cup in 2022?",
      answers: ["France", "Argentina", "Brazil"],
      correctAnswer: "Argentina",
    ),
    QuestionModel(
      questionTitle: "How many players are on the field for one football team?",
      answers: ["10", "11", "12"],
      correctAnswer: "11",
    ),
    QuestionModel(
      questionTitle: "Which sport uses the term 'Love' for a score of zero?",
      answers: ["Tennis", "Basketball", "Golf"],
      correctAnswer: "Tennis",
    ),
    QuestionModel(
      questionTitle: "Who is known as the 'King of Football'?",
      answers: ["Pelé", "Maradona", "Cristiano Ronaldo"],
      correctAnswer: "Pelé",
    ),
    QuestionModel(
      questionTitle: "How long is a standard professional soccer match?",
      answers: ["80 minutes", "90 minutes", "100 minutes"],
      correctAnswer: "90 minutes",
    ),
    QuestionModel(
      questionTitle: "Which country hosts the NBA?",
      answers: ["United States", "Canada", "Spain"],
      correctAnswer: "United States",
    ),
  ];

  final List<QuestionModel> MovieQuestions = [
    QuestionModel(
      questionTitle: "Who played the leading role in the movie 'El Nazer'?",
      answers: ["Alaa Waley El Din", "Mohamed Henedi", "Ahmed Helmy"],
      correctAnswer: "Alaa Waley El Din",
    ),
    QuestionModel(
      questionTitle: "Which famous Egyptian actor played 'El Lmbi'?",
      answers: ["Mohamed Saad", "Hany Ramzy", "Ahmed Mekky"],
      correctAnswer: "Mohamed Saad",
    ),
    QuestionModel(
      questionTitle: "Who was known as the 'Universal Actor' (Al A'alamy) in Egyptian cinema?",
      answers: ["Omar Sharif", "Adel Emam", "Ahmed Zaki"],
      correctAnswer: "Omar Sharif",
    ),
    QuestionModel(
      questionTitle: "Which movie features the character 'Hazloom'?",
      answers: ["La Toga'e'ni B'edak", "La Tراجع ولا استسلام", "Tir Enta"],
      correctAnswer: "La Tراجع ولا استسلام",
    ),
    QuestionModel(
      questionTitle: "Who directed the iconic Arabic movie 'El Kit Kat'?",
      answers: ["Daoud Abdel Sayed", "Youssef Chahine", "Atef El-Tayeb"],
      correctAnswer: "Daoud Abdel Sayed",
    ),
    QuestionModel(
      questionTitle: "Which legendary actor starred in 'El Gazeera'?",
      answers: ["Ahmed El Sakka", "Karim Abdel Aziz", "Ahmad Ezz"],
      correctAnswer: "Ahmed El Sakka",
    ),
  ];

  void selectCategory(String category) {
    selectedcategory = category;
    questionIndex = 0;
    score = 0;
    selectedValue = null;

    if (category == 'general') {
      currentQuestions = GenaralQuestions;
    } else if (category == 'science') {
      currentQuestions = ScienceQuestions;
    } else if (category == 'sports') {
      currentQuestions = SportQuestions;
    } else if (category == 'movies') {
      currentQuestions = MovieQuestions;
    }
  }

  double getProgress() {
    if (currentQuestions.isEmpty) return 0.0;
    return (questionIndex + 1) / currentQuestions.length;
  }

  void checkAnswer() {
    if (selectedValue == currentQuestions[questionIndex].correctAnswer) {
      score++;
    }
  }

  void nextQuestion() {
    checkAnswer();
    selectedValue = null;

    if (questionIndex < currentQuestions.length - 1) {
      questionIndex++;
    } else {
      Get.offAll(() => ResultScreen(
        score: score,
        quizController: this,
      ));
    }
  }
}