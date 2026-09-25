import 'package:flutter/material.dart';
import 'package:quiz_app_repo/quiz_app/view/questios_page.dart';

import '../controllers/question_list.dart';
import 'gridview_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedcategory;
  final cat = QuizController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: const TextSpan(
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
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
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: CircleAvatar(
              backgroundColor: Colors.deepPurple.withOpacity(.1),
              child: const Icon(Icons.settings, color: Colors.deepPurple),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(
              "Test Your Knowledge,\nOne Question at a Time!",
              style: TextStyle(
                color: Colors.deepPurple.shade300,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: Image.asset(
                'assets/images/led.webp',
                height: 170,
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    if (selectedcategory == null) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Please select a category"),
                            content: const Text(
                              "Please select a question category first.",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("OK"),
                              ),
                            ],
                          );
                        },
                      );
                      return;
                    }

                    cat.selectCategory(selectedcategory!);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuestionsPage(
                          quizController: cat,
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    "Start Quiz",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Categories",
              style: TextStyle(
                color: Colors.deepPurple,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.only(bottom: 16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 1.1,
                ),
                itemCount: categories.length,
                itemBuilder: (BuildContext context, int index) {
                  return buildContainer(
                    title: categories[index]['title'],
                    icon: categories[index]['icon'],
                    icon_text_color: categories[index]['color'],
                    type: categories[index]['type'],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildContainer({
    required Color icon_text_color,
    required IconData icon,
    required String title,
    required String type,
  }) {
    final bool isSelected = selectedcategory == type;

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {
        setState(() {
          selectedcategory = type;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: isSelected
              ? icon_text_color.withOpacity(.22)
              : icon_text_color.withOpacity(.08),
          border: Border.all(
            color: isSelected ? icon_text_color : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: icon_text_color.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: icon_text_color,
                size: 30,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: icon_text_color,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: icon_text_color,
                  size: 14,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}