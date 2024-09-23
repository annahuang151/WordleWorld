import 'package:flutter/material.dart';
import 'package:word_hurdle_puzzle/wordle.dart';

class WordleView extends StatelessWidget {
  final Wordle wordle;
  const WordleView({super.key, required this.wordle});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: wordle.isCorrect ?
              Colors.greenAccent
            : wordle.existsInTarget
            ? Colors.yellow
            : wordle.doesNotExistInTarget
            ? Colors.red
            : Colors.grey, // Default color when no condition is met
        border: Border.all(
          color: Colors.white,
          width: 1.5,
        ),
      ),
      child: Text(
        wordle.letter,
        style: TextStyle(
          fontSize: 16,
          color: wordle.existsInTarget
              ? Colors.black
              : wordle.doesNotExistInTarget
              ? Colors.white54
              : Colors.white, // Default text color
        ),
      ),
    );
  }
}
