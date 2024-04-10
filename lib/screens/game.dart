import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe/screens/victory.dart';
import '../constants/colors.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key, required this.firstPlayer});
  final int firstPlayer;

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool oTurn = true;
  List<String> displayX0 = ["", "", "", "", "", "", "", "", ""];
  List<int> matchesIndex = [];

  String resultDecoration = "";
  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;
  bool winnerFound = false;
  int attempts = 0;

  static const maxSeconds = 10;
  int seconds = maxSeconds;
  Timer? timer;

  static var customFontBlack = GoogleFonts.coiny(
    textStyle: const TextStyle(
      color: Colors.black,
      letterSpacing: 3,
      fontSize: 24,
    ),
  );

  @override
  void initState() {
    super.initState();
    oTurn = widget.firstPlayer == 2 ? true : false;
    StartTimer();
    clearBoard();
    attempts++;
  }

  void StartTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          StopTimer();
        }
      });
    });
  }

  void StopTimer() {
    ResetTimer();
    timer?.cancel();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const VictoryScreen(winPlayer: "")));
  }

  void ResetTimer() {
    seconds = maxSeconds;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MainColor.primaryColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          "Tic Tac Toe",
                          style: GoogleFonts.coiny(
                            textStyle: const TextStyle(
                              color: Colors.black,
                              letterSpacing: 3,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Player X",
                                  style: GoogleFonts.coiny(
                                    textStyle: TextStyle(
                                      color: MainColor.xColor,
                                      letterSpacing: 3,
                                      fontSize: 28,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Player O",
                                  style: GoogleFonts.coiny(
                                    textStyle: TextStyle(
                                      color: MainColor.oColor,
                                      letterSpacing: 3,
                                      fontSize: 28,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  flex: 4,
                  child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 9,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 3,
                        mainAxisSpacing: 3,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            _tapped(index);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 5,
                                color: MainColor.primaryColor,
                              ),
                              color: MainColor.primaryColor,
                              boxShadow: [
                                BoxShadow(
                                  color: MainColor.borderColor.withOpacity(0.2),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                displayX0[index],
                                style: GoogleFonts.coiny(
                                  textStyle: TextStyle(
                                    fontSize: 60,
                                    color: displayX0[index] == "O"
                                        ? MainColor.oColor
                                        : MainColor.xColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          resultDecoration,
                          style: customFontBlack,
                        ),
                        buildTimer(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void _tapped(int index) {
    final isRunning = timer == null ? false : timer!.isActive;

    if (isRunning) {
      setState(() {
        if (oTurn && displayX0[index] == "") {
          displayX0[index] = "O";
          filledBoxes++;
        } else if (!oTurn && displayX0[index] == "") {
          displayX0[index] = "X";
          filledBoxes++;
        }
        oTurn = !oTurn;
        checkWinner();
      });
    }
    ResetTimer();
  }

  void checkWinner() {
    if (displayX0[0] == displayX0[1] &&
        displayX0[0] == displayX0[2] &&
        displayX0[0] != "") {
      setState(() {
        resultDecoration = "Player ${displayX0[0]} Winner!";
        matchesIndex.addAll([0, 1, 2]);
        StopTimer();
        updateScore(displayX0[0]);
      });
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => VictoryScreen(winPlayer: displayX0[0])));
    }

    if (displayX0[3] == displayX0[4] &&
        displayX0[3] == displayX0[5] &&
        displayX0[3] != "") {
      setState(() {
        resultDecoration = "Player ${displayX0[3]} Winner!";
        matchesIndex.addAll([3, 4, 5]);
        StopTimer();
        updateScore(displayX0[3]);
      });
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => VictoryScreen(winPlayer: displayX0[3])));
    }

    if (displayX0[6] == displayX0[7] &&
        displayX0[6] == displayX0[8] &&
        displayX0[6] != "") {
      setState(() {
        resultDecoration = "Player ${displayX0[6]} Winner!";
        matchesIndex.addAll([6, 7, 8]);
        StopTimer();
        updateScore(displayX0[6]);
      });
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => VictoryScreen(winPlayer: displayX0[6])));
    }

    if (displayX0[0] == displayX0[3] &&
        displayX0[0] == displayX0[6] &&
        displayX0[0] != "") {
      setState(() {
        resultDecoration = "Player ${displayX0[0]} Winner!";
        matchesIndex.addAll([0, 3, 6]);
        StopTimer();
        updateScore(displayX0[0]);
      });
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => VictoryScreen(winPlayer: displayX0[0])));
    }

    if (displayX0[1] == displayX0[4] &&
        displayX0[1] == displayX0[7] &&
        displayX0[1] != "") {
      setState(() {
        resultDecoration = "Player ${displayX0[1]} Winner!";
        matchesIndex.addAll([1, 4, 7]);
        StopTimer();
        updateScore(displayX0[1]);
      });
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => VictoryScreen(winPlayer: displayX0[1])));
    }

    if (displayX0[2] == displayX0[5] &&
        displayX0[2] == displayX0[8] &&
        displayX0[2] != "") {
      setState(() {
        resultDecoration = "Player ${displayX0[2]} Winner!";
        matchesIndex.addAll([2, 5, 8]);
        StopTimer();
        updateScore(displayX0[2]);
      });
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => VictoryScreen(winPlayer: displayX0[2])));
    }

    if (displayX0[0] == displayX0[4] &&
        displayX0[0] == displayX0[8] &&
        displayX0[0] != "") {
      setState(() {
        resultDecoration = "Player ${displayX0[0]} Winner!";
        matchesIndex.addAll([0, 4, 8]);
        StopTimer();
        updateScore(displayX0[0]);
      });
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => VictoryScreen(winPlayer: displayX0[0])));
    }

    if (displayX0[2] == displayX0[4] &&
        displayX0[2] == displayX0[6] &&
        displayX0[2] != "") {
      setState(() {
        resultDecoration = "Player ${displayX0[2]} Winner!";
        matchesIndex.addAll([2, 4, 6]);
        StopTimer();
        updateScore(displayX0[2]);
      });
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => VictoryScreen(winPlayer: displayX0[2])));
    }

    if (!winnerFound && filledBoxes == 9) {
      setState(() {
        resultDecoration = "Nobody Wins!";
      });
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const VictoryScreen(winPlayer: "")));
    }
  }

  void updateScore(String winner) {
    if (winner == "O") {
      oScore++;
    } else if (winner == "X") {
      xScore++;
    }
    winnerFound = true;
  }

  void clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayX0[i] = "";
      }
      resultDecoration = "";
    });
    filledBoxes = 0;
  }

  Widget buildTimer() {
    final isRunning = timer == null ? false : timer!.isActive;

    return isRunning
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 100,
              height: 100,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CircularProgressIndicator(
                    value: 1 - seconds / maxSeconds,
                    valueColor: const AlwaysStoppedAnimation(Colors.white),
                    strokeWidth: 8,
                    backgroundColor: Colors.blue,
                  ),
                  Center(
                    child: Text(
                      "$seconds",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 50),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(25.0),
            child: SizedBox(
              width: 180,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: MainColor.borderColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  StartTimer();
                  clearBoard();
                  attempts++;
                },
                child: Text(
                  attempts == 0 ? "Start" : "Play Again!",
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
  }
}
