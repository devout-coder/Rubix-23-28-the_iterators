import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:csi_hackathon/navigationpages/screens/Breathing.dart';
import 'package:csi_hackathon/navigationpages/screens/Rewards.dart';
import 'package:csi_hackathon/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class Mindfulness extends StatefulWidget {
  const Mindfulness({super.key});

  @override
  State<Mindfulness> createState() => _MindfulnessState();
}

class _MindfulnessState extends State<Mindfulness> {
  States states = GetIt.I.get();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AnimatedTextKit(
          onFinished: () {
            Random rnd;
            int min = 100;
            int max = 1000;
            rnd = new Random();
            int r = min + rnd.nextInt(max - min);
            states.points += r;

            DateTime today = DateTime(
                DateTime.now().year, DateTime.now().month, DateTime.now().day);
            if (states.activities.containsKey(today)) {
              states.activities[today]!["Mindfulness"] = r;
            } else {
              states.activities[today] = {"Mindfulness": r};
            }

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Rewards(points: r)),
            );
          },
          totalRepeatCount: 1,
          stopPauseOnTap: false,
          animatedTexts: [
            animeText("Sit in a quiet and comfortable place."),
            animeText(
                "Put one of your hands on your chest and the other on your stomach."),
            animeText(
                "Your stomach should move more than your chest when you breathe in deeply"),
            animeText("Take a slow and regular breath in through your nose."),
            animeText("Watch and sense your hands as you breathe in."),
            animeText(
                "The hand on your chest should remain still while the hand on your stomach will move slightly"),
            animeText("Breathe out through your mouth slowly"),
          ],
        ),
      ),
    );
  }
}
