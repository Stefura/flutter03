import 'package:flutter/material.dart';

void main() {
  runApp(PsychologicalTestApp());
}

class PsychologicalTestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TestScreen(
        testConfig: TestConfig(
          questions: [
            'Чи ви задоволені своєю роботою?',
            'Чи ви любите подорожувати?',
            'Чи легко вам довіряти людям?',
            'Чи ви зазвичай плануєте свій день заздалегідь?',
            'Чи вам подобається спілкуватися з новими людьми?',
            'Чи ви любите читати книги?',
            'Чи ви вірите у долю?',
          ],
          answers: ['Так', 'Ні'],
          scores: [5, 1], // Бали за "Так" та "Ні"
        ),
      ),
    );
  }
}

class TestConfig {
  final List<String> questions;
  final List<String> answers;
  final List<int> scores;

  TestConfig({
    required this.questions,
    required this.answers,
    required this.scores,
  });
}

class TestScreen extends StatefulWidget {
  final TestConfig testConfig;

  TestScreen({required this.testConfig});

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  late List<String> questions;
  late List<String> answers;
  late List<int> scores;
  int currentQuestionIndex = 0;
  int totalScore = 0;

  @override
  void initState() {
    super.initState();
    questions = widget.testConfig.questions;
    answers = widget.testConfig.answers;
    scores = widget.testConfig.scores;
  }

  void answerQuestion(String answer) {
    setState(() {
      if (answer == answers[0]) {
        totalScore += scores[0];
      } else {
        totalScore += scores[1];
      }

      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
      } else {
        // Після завершення тесту тут можна реалізувати аналіз результатів
        analyzeResults();
      }
    });
  }

  void analyzeResults() {
    String resultType = 'Не визначено'; // Тип людини

    // Реалізуйте логіку визначення типу людини відповідно до набраних балів
    if (totalScore >= 20) {
      resultType = 'Тип A: Амбітійний і зорієнтований на успіх';
    } else if (totalScore >= 15) {
      resultType = 'Тип B: Спокійний і рівноважний';
    } else if (totalScore >= 10) {
      resultType = 'Тип C: Спрямований на людей і співпрацю';
    }

    // Вивести результати у діалоговому вікні
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Результати тесту'),
          content: Column(
            children: [
              Text('Ваші відповіді: ${totalScore} балів'),
              SizedBox(height: 10.0),
              Text('Тип людини: $resultType'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                resetTest();
              },
              child: Text('Закрити'),
            ),
          ],
        );
      },
    );
  }

  void resetTest() {
    setState(() {
      currentQuestionIndex = 0;
      totalScore = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Психологічний тест'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              questions[currentQuestionIndex],
              style: TextStyle(fontSize: 18.0),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => answerQuestion(answers[0]),
              child: Text(answers[0]),
            ),
            ElevatedButton(
              onPressed: () => answerQuestion(answers[1]),
              child: Text(answers[1]),
            ),
          ],
        ),
      ),
    );
  }
}
