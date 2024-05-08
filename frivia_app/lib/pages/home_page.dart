// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, no_leading_underscores_for_local_identifiers, unused_field, use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:frivia_app/providers/game_page_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  double? _deviceHeight, _deviceWidth;
  String difficulty;

  HomePage({required this.difficulty});
  HomePageProvider? _pageProvider;
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
      create: (_context) => HomePageProvider(context: context , diffulty: difficulty),
      child: _buildUi(),
    );
  }

  Widget _buildUi() {
    return Builder(
      builder: (_context) {
        _pageProvider = _context.watch<HomePageProvider>();
        if(_pageProvider!.questions != null){
        return Scaffold(
          body: SafeArea(
              child: Container(
            padding: EdgeInsets.symmetric(horizontal: _deviceHeight! * 0.05),
            child: _gameUI(),
          )),
        );
      }else{
        return Center(
          child: CircularProgressIndicator(color: Colors.white ,),
        );
      }
      }
    );
  }

  Widget _gameUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        _questionText(),
        Column(
          children: [
            _trueButton(),
            SizedBox(
              height: _deviceHeight! * 0.01,
            ),
            _falseButton(),
          ],
        )
      ],
    );
  }

  Widget _questionText() {
    return Column(
      children: [
        Text(
          "Question ${_pageProvider!.getCurrentQuestionIndex()+1}",
          style: TextStyle(
              color: Colors.deepOrangeAccent,
              fontSize: 25,
              fontWeight: FontWeight.w400),
        ),
        Text(
          _pageProvider!.getCurrentQuestionText(),
          style: TextStyle(
              color: Colors.deepOrangeAccent,
              fontSize: 25,
              fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  Widget _trueButton() {
    return MaterialButton(
      onPressed: () {
        _pageProvider?.answerQuestion("True");
      },
      color: Colors.green,
      minWidth: _deviceWidth! * 0.8,
      height: _deviceHeight! * 0.05,
      child: Text(
        "True",
        style: TextStyle(color: Colors.white, fontSize: 25),
      ),
    );
  }

  Widget _falseButton() {
    return MaterialButton(
      onPressed: () {
        _pageProvider?.answerQuestion("False");
      },
      color: Colors.red,
      minWidth: _deviceWidth! * 0.8,
      height: _deviceHeight! * 0.05,
      child: Text(
        "False",
        style: TextStyle(color: Colors.white, fontSize: 25),
      ),
    );
  }
}
