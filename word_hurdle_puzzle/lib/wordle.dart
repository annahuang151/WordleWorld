class Wordle {
  String letter;
  bool isCorrect;
  bool existsInTarget;
  bool doesNotExistInTarget;

  Wordle({
    required this.letter,
    this.isCorrect = false,
    this.existsInTarget = false,
    this.doesNotExistInTarget = false,
  });
}