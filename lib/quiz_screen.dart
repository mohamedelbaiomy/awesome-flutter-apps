import 'package:flutter/material.dart';
import 'package:quiz_app/animated_button.dart';

import 'models.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  // define data
  List<Question> questionList = getQuestions();
  int currentQuestionIndex = 0;
  int score = 0;
  Answer? selectedAnswer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(height: 10),
            const Text(
              "Simple Quiz App",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontStyle: FontStyle.italic,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Question ${currentQuestionIndex + 1} / ${questionList.length.toString()}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 50),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        questionList[currentQuestionIndex].questionText,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Positioned(
                      left: -22,
                      top: 20,
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                      ),
                    ),
                    const Positioned(
                      right: -22,
                      top: 20,
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      top: -27,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.green,
                          size: 50,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                for (Answer answer
                    in questionList[currentQuestionIndex].answerList)
                  _answerButton(answer)
              ],
            ),
            nextButton(),
          ],
        ),
      ),
    );
  }

  Widget _answerButton(Answer answer) {
    bool isSelected = answer == selectedAnswer;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedButton(
        height: 50,
        onPressed: () {
          setState(() {
            selectedAnswer = answer;
          });
        },
        color: isSelected ? Colors.orange.shade400 : Colors.grey.shade300,
        child: Text(
          answer.answerText,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  nextButton() {
    bool isLastQuestion = false;
    if (currentQuestionIndex == questionList.length - 1) {
      isLastQuestion = true;
    }
    return AnimatedButton(
      onPressed: () {
        if (selectedAnswer!.isCorrect) {
          score++;
        }
        if (selectedAnswer == null) {
        } else {
          if (isLastQuestion) {
            showDialog(
              context: context,
              // عشان لو عملتها true كل ما يقفل ويدوس تانى هيغير قيمه ال score
              barrierDismissible: false,
              builder: (_) {
                return AlertDialog(
                  clipBehavior: Clip.none,
                  title: Text(
                    "${score >= questionList.length * 0.5 ? "Passed" : "Failed"} | Score is $score",
                    style: TextStyle(
                      color: score >= questionList.length * 0.5
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                  // score = score
                  content: SizedBox(
                    height: 60,
                    child: Center(
                      child: AnimatedButton(
                        color: Colors.black,
                        height: 50,
                        width: 100,
                        onPressed: () {
                          Navigator.pop(context);
                          setState(() {
                            currentQuestionIndex = 0;
                            score = 0;
                            selectedAnswer = null;
                          });
                        },
                        child: const Text(
                          "Restart",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            setState(() {
              selectedAnswer = null;
              currentQuestionIndex++;
            });
          }
        }
      },
      width: 300,
      height: 50,
      color: Colors.white,
      child: Text(
        isLastQuestion ? "Submit" : "Next",
        style: const TextStyle(
          color: Colors.black,
          fontSize: 25,
          letterSpacing: 10,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}
