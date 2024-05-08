// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class HomePageProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  final int _maxQuestions = 10;
  List? questions;
  BuildContext context;
  int _currentQuestionCount = 0;
  int _total = 0;
  final String diffulty;
  HomePageProvider({required this.context , required this.diffulty}) {
    _dio.options.baseUrl = 'https://opentdb.com/api.php';
    _getQuestionsFromAPI();
  }

  Future<void> _getQuestionsFromAPI() async {
    // print(diffulty);
    var response = await _dio.get('', queryParameters: {
      'amount': _maxQuestions,
      'type': 'boolean',
      'difficulty': diffulty,
    });

    var _data = jsonDecode(response.toString());
    questions = _data["results"];
    // print(questions);
    notifyListeners();
  }

  String getCurrentQuestionText() {
    return questions![_currentQuestionCount]["question"];
  }

  int getCurrentQuestionIndex() {
    return _currentQuestionCount;
  }

  void answerQuestion(String _aswer) async {
    bool isCorrect =
        questions![_currentQuestionCount]["correct_answer"] == _aswer;
    _currentQuestionCount++;
    if (isCorrect) {
      _total++;
    }
    showDialog(
        context: context,
        builder: (BuildContext _context) {
          return AlertDialog(
            backgroundColor: isCorrect ? Colors.green : Colors.red,
            title: Icon(isCorrect ? Icons.check_circle : Icons.cancel_sharp),
          );
        });
    await Future.delayed(Duration(seconds: 1));
    Navigator.pop(context);
    if (_currentQuestionCount == _maxQuestions) {
      endGame();
    } else {
      notifyListeners();
    }
  }

  Future<void> endGame() async {
    showDialog(
        context: context,
        builder: (BuildContext _context) {
          return AlertDialog(
            backgroundColor: Colors.blue,
            title: Text(
              "End Game !",
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
            content: Text("Score $_total /$_maxQuestions"),
          );
        });
    await Future.delayed(Duration(seconds: 3));
    Navigator.pop(context);
    _currentQuestionCount =0;
    Navigator.pop(context);
  }
}
