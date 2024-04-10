// Create the state for the RadioListTile example
// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe/constants/colors.dart';
import 'package:tictactoe/screens/game.dart';

class ChoosePlayer extends StatefulWidget {
  const ChoosePlayer({super.key});

  @override
  _ChoosePlayerState createState() => _ChoosePlayerState();
}

class _ChoosePlayerState extends State<ChoosePlayer> {
  int _selectedValue = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 100,
            ),
            Text(
              "Choose the first site",
              style: GoogleFonts.coiny(
                textStyle: const TextStyle(fontSize: 34, color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "X",
                        style: GoogleFonts.coiny(
                          textStyle:
                              TextStyle(fontSize: 100, color: MainColor.xColor),
                        ),
                      ),
                      RadioListTile(
                        fillColor: MaterialStatePropertyAll(MainColor.xColor),
                        title: const Text(
                            'Player X'), // Display the title for option 1
                        value: 1, // Assign a value of 1 to this option
                        groupValue:
                            _selectedValue, // Use _selectedValue to track the selected option
                        onChanged: (value) {
                          setState(() {
                            _selectedValue =
                                value!; // Update _selectedValue when option 1 is selected
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "O",
                        style: GoogleFonts.coiny(
                          textStyle:
                              TextStyle(fontSize: 100, color: MainColor.oColor),
                        ),
                      ),
                      RadioListTile(
                        fillColor: MaterialStatePropertyAll(MainColor.oColor),
                        title: const Text(
                            'Player O'), // Display the title for option 2
                        value: 2, // Assign a value of 2 to this option
                        groupValue:
                            _selectedValue, // Use _selectedValue to track the selected option
                        onChanged: (value) {
                          setState(() {
                            _selectedValue =
                                value!; // Update _selectedValue when option 2 is selected
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 100,
            ),
            SizedBox(
              height: 60,
              width: 280,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            GameScreen(firstPlayer: _selectedValue)));
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(MainColor.borderColor),
                  ),
                  child: Text(
                    "Continue",
                    style: GoogleFonts.coiny(
                      textStyle:
                          const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
