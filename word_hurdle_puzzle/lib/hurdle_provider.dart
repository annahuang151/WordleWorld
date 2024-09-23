import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:english_words/english_words.dart' as words;
import 'package:word_hurdle_puzzle/wordle.dart';
class HurdleProvider extends ChangeNotifier{
  final random = Random.secure();
  List<String> totalWords = [];
  List<String> rowInputs = [];
  List<String> excludeLetters = [];
  List<Wordle> hurdleBoard = [];
  String targetWord = '';
  int count = 0;
  int index = 0;
  final lettersPerRow = 5;
  bool wins = false;
  final totalAttempts = 6;
  int attempts = 0;

  bool get shouldCheckForAnswer => rowInputs.length == lettersPerRow;

  bool get noAttemptsLeft => attempts == totalAttempts;

  init(){
    totalWords = words.all.where((element)=>element.length==5).toList();
    generateBoard();
    generateRandomWord();
  }

  bool get isAValidWord => totalWords.contains(rowInputs.join('').toLowerCase());

  generateBoard(){
    hurdleBoard = List.generate(30, (index) => Wordle(letter: ''));
  }

  generateRandomWord(){
    if (totalWords.isNotEmpty) {
      targetWord = totalWords[random.nextInt(totalWords.length)].toUpperCase();
    } else {
      targetWord = 'ERROR';
    }
  }

  inputLetter(String letter){
    if(count < lettersPerRow){
      rowInputs.add(letter);
      count++;
      hurdleBoard[index] = Wordle(letter: letter);
      index++;
      notifyListeners();
    }
  }

  void deleteLetter(){
    if(rowInputs.isNotEmpty){
      rowInputs.removeAt(rowInputs.length - 1);
    }

    if(count > 0){
      hurdleBoard[index - 1] = Wordle(letter: '');
      count--;
      index--;
    }

    notifyListeners();
  }

  void checkAnswer() {
    final input = rowInputs.join('');
    if(targetWord == input){
      wins = true;
    } else{
      _markLetterOnBoard();
      if(attempts < totalAttempts){
        _goToNextRow();
      }
    }
  }

  void _markLetterOnBoard() {
    for (int i = 0; i < rowInputs.length; i++) {
      String currentLetter = rowInputs[i].toUpperCase();
      String targetLetter = targetWord[i];

      if (currentLetter == targetLetter) {
        // Letter is in the correct position
        hurdleBoard[index - lettersPerRow + i].isCorrect = true;
      } else if (targetWord.contains(currentLetter)) {
        // Letter exists in the target word but in the wrong position
        hurdleBoard[index - lettersPerRow + i].existsInTarget = true;
      } else {
        // Letter does not exist in the target word
        hurdleBoard[index - lettersPerRow + i].doesNotExistInTarget = true;
        excludeLetters.add(currentLetter);
      }
    }
    notifyListeners();
  }

  void _goToNextRow() {
    attempts++;
    count = 0;
    rowInputs.clear();
  }

  reset(){
    count = 0;
    index = 0;
    rowInputs.clear();
    hurdleBoard.clear();
    excludeLetters.clear();
    attempts = 0;
    wins = false;
    targetWord = '';
    generateBoard();
    generateRandomWord();
    notifyListeners();
  }

}
