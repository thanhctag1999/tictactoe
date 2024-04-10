import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe/constants/colors.dart';
import 'package:tictactoe/screens/choose_player.dart';

class VictoryScreen extends StatefulWidget {
  const VictoryScreen({super.key, required this.winPlayer});
  final String winPlayer;

  @override
  State<VictoryScreen> createState() => _VictoryScreenState();
}

class _VictoryScreenState extends State<VictoryScreen> {
  final controller = ConfettiController();
  bool isPlaying = true;
  double pi = 3.14;

  @override
  void initState() {
    super.initState();
    controller.play();
    controller.addListener(() {
      isPlaying = controller.state == ConfettiControllerState.playing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          ConfettiWidget(
            confettiController: controller,
            shouldLoop: true,
            blastDirection: -pi / 2,
          ),
          const SizedBox(
            height: 250,
          ),
          Center(
            child: widget.winPlayer != ""
                ? Text(
                    "Player ${widget.winPlayer} Winner!",
                    style: GoogleFonts.coiny(
                      textStyle: TextStyle(
                          fontSize: 34,
                          color: widget.winPlayer == "X"
                              ? MainColor.xColor
                              : MainColor.oColor),
                    ),
                  )
                : Text(
                    "Match Draw",
                    style: GoogleFonts.coiny(
                      textStyle: const TextStyle(
                          fontSize: 34, color: Colors.amberAccent),
                    ),
                  ),
          ),
          const SizedBox(
            height: 200,
          ),
          SizedBox(
            height: 60,
            width: 280,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ChoosePlayer()));
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(MainColor.borderColor),
                ),
                child: Text(
                  "Re Play",
                  style: GoogleFonts.coiny(
                    textStyle:
                        const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                )),
          )
        ],
      ),
    ));
  }
}
