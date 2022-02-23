import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'result_page.dart';

QuizBrain quizBrain = QuizBrain();

class Quizzler extends StatelessWidget {
  //TODO : ตัวอย่างการสร้าง constructor ในภาษา dart
  //โดยในที่นี้กำหนดให้ เมื่อมีการเรียกใช้ Quizzler จะต้องมีการส่งค่า name มาให้ด้วย
  //เช่น Quizzler(name: myController.text) ในไฟล์ main.dart
  Quizzler({required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Welcome $name'),
          backgroundColor: Colors.blueGrey,
        ),
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  List<Icon> scoreKeeper = [];
  int totalScore = 0;

  void checkAnswer(bool userAns) {
    bool correctAnswer = quizBrain.getQuestionAnswer()!;
    setState(() {
      if (quizBrain.isFinished()) {
        if (correctAnswer == userAns) {
          totalScore++;
          scoreKeeper.add(const Icon(
            Icons.check,
            color: Colors.green,
          ));
        } else {
          scoreKeeper.add(const Icon(
            Icons.close,
            color: Colors.red,
          ));
        }
        quizBrain.reset();
        //TODO : ศึกษาตัวอย่างการใช้ Navigator.push ไปยัง ResultPage() โดยต้องส่งคะแนนรวมไปให้ด้วย
        Navigator.push(context, MaterialPageRoute(builder: (context) => ResultPage(score: totalScore.toString())));
      }
      else {
        if (correctAnswer == userAns) {
          totalScore++;
          scoreKeeper.add(const Icon(
            Icons.check,
            color: Colors.green,
          ));
          quizBrain.nextQuestion();
        } else {
          scoreKeeper.add(const Icon(
            Icons.close,
            color: Colors.red,
          ));
          quizBrain.nextQuestion();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                '$totalScore',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 35.0,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText()!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.green),
              child: const Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.red),
              child: const Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,

                ),
              ),
              onPressed: () {
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        ),

      ],
    );
  }
}
