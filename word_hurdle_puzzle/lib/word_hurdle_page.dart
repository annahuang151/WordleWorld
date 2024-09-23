import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_hurdle_puzzle/hurdle_provider.dart';
import 'package:word_hurdle_puzzle/keyboard_view.dart';
import 'package:word_hurdle_puzzle/wordle_view.dart';
import 'helper_functions.dart';
import 'home_page.dart';

class WordHurdlePage extends StatefulWidget {
  const WordHurdlePage({super.key});

  @override
  State<WordHurdlePage> createState() => _WordHurdlePageState();
}

class _WordHurdlePageState extends State<WordHurdlePage> {
  @override
  void didChangeDependencies() {
    Provider.of<HurdleProvider>(context, listen: false).init();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40.0), // Adds padding to body
            child: Center(
              child: Column(
                children: [
                  Expanded(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.70,
                      child: Consumer<HurdleProvider>(
                        builder: (context, provider, child) =>
                            GridView.builder(
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 5,
                                  mainAxisSpacing: 4,
                                  crossAxisSpacing: 4,
                                ),
                                itemCount: provider.hurdleBoard.length,
                                itemBuilder: (context, index) {
                                  final wordle = provider.hurdleBoard[index];
                                  return WordleView(wordle: wordle);
                                }
                            ),
                      ),
                    ),
                  ),
                  Consumer<HurdleProvider>(
                    builder: (context, provider, child) =>
                        KeyboardView(
                          excludedLetters: provider.excludeLetters,
                          onPressed: (value) {
                            provider.inputLetter(value);
                          },
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Consumer<HurdleProvider>(
                      builder: (context, provider, child) =>
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.grey[900],
                                  shadowColor: Colors.transparent,
                                ),
                                onPressed: () {
                                  provider.deleteLetter();
                                },
                                child: const Text('DELETE'),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.grey[900],
                                  shadowColor: Colors.transparent,
                                ),
                                onPressed: () {
                                  _handleInput(provider);
                                },
                                child: const Text('SUBMIT'),
                              )
                            ],
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Back arrow on top
          Positioned(
            top: 40,
            left: 10,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }

  _handleInput(HurdleProvider provider) {
    if (!provider.isAValidWord) {
      showMessage(context: context,
          message: 'Not a word in my dictionary');
    }
    if (provider.shouldCheckForAnswer) {
      provider.checkAnswer();
    }
    if (provider.wins) {
      showResult(
          context: context,
          title: 'You win!',
          body: 'The word is ${provider.targetWord}',
          onPlayAgain: () {
            Navigator.pop(context);
            provider.reset();
          },
          onCancel: () {
            //Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          });
    } else if (provider.noAttemptsLeft) {
      showResult(
        context: context,
        title: 'You lost!!',
        body: 'The word was ${provider.targetWord}',
        onPlayAgain: () {
          Navigator.pop(context);
          provider.reset();
        },
        onCancel: () {
          //Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        },
      );
    }
  }
}
