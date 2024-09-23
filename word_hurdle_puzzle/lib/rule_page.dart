import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'hurdle_provider.dart';
import 'word_hurdle_page.dart'; // Import the WordHurdlePage

class RulesPage extends StatelessWidget {
  const RulesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center, // Align content to the center
              children: <Widget>[
                // Custom Back Arrow Button
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context); // Go back to the previous screen
                    },
                  ),
                ),
                const SizedBox(height: 20), // Space after back arrow

                // Centered Title Text
                const Center(
                  child: Text(
                    'Game Rules',
                    style: TextStyle(
                      fontSize: 30, // Large font size for title
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // White text color
                    ),
                  ),
                ),
                const SizedBox(height: 20), // Space between title and content

                // Rules Content with padding
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0), // Add horizontal padding
                  child: Text(
                    '''1. You have 5 attempts to guess the correct word.
2. After each guess, the color of the tiles will change to show how close your guess was to the word.
3. A green tile means the letter is in the correct spot.
4. A yellow tile means the letter is in the word but in the wrong spot.
5. A red tile means the letter is not in the word at all.
6. Use the on-screen keyboard to input your guesses and click "Submit" to check your guess.
7. If you run out of attempts, you lose the game.''',
                    style: TextStyle(
                      fontSize: 18, // Standard font size for content
                      color: Colors.white, // White text color
                    ),
                    textAlign: TextAlign.left, // Align the text to the left
                  ),
                ),
                const SizedBox(height: 50), // Space between content and button

                // Button to navigate to WordHurdlePage
                Container(
                  width: 150,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.grey[900],
                      shadowColor: Colors.transparent, // Remove button shadow
                    ),
                    onPressed: () {
                      // Access the HurdleProvider and reset the game
                      Provider.of<HurdleProvider>(context, listen: false).reset();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const WordHurdlePage()),
                      );
                    },
                    child: const Text('Play', style: TextStyle(fontSize: 18)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
