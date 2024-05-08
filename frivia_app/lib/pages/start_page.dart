// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_element, no_leading_underscores_for_local_identifiers, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:frivia_app/pages/home_page.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  double? _deviceHeight, _deviceWidth;
  double _currentDiffultyLevel = 0;
  List <String> _difficulties = ['easy' , 'meduim' ,'hard'];
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.06),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            _appTitle(),
            _difficultySlider(),
            _startButton()
          ],
        ),
      )),
    );
  }

  Widget _appTitle() {
    return Column(
      children: [
        Text(
          "Frivia ",
          style: TextStyle(
              color: Colors.white, fontSize: 50, fontWeight: FontWeight.w500),
        ),
        Text(
          _difficulties[_currentDiffultyLevel.toInt()],
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.w500),
        ),

      ],
    );
  }

  Widget _difficultySlider() {
    return Slider(
      label: "Difficulty",
        min: 0,
        max: 2,
        divisions: 2,
        value: _currentDiffultyLevel,
        onChanged: (_value) {
          setState(() {
            _currentDiffultyLevel = _value;
            //print(_currentDiffultyLevel);
          });
        });
  }
  Widget _startButton(){
    return MaterialButton(
      onPressed: () {
        //_pageProvider?.answerQuestion("False");
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext _context){
          return HomePage(difficulty: _difficulties[_currentDiffultyLevel.toInt()],);
        }));
      },
      color: Colors.purple,
      minWidth: _deviceWidth! * 0.8,
      height: _deviceHeight! * 0.1,
      child: Text(
        "Start",
        style: TextStyle(color: Colors.white, fontSize: 25),
      ),
    ); 
  }
}
