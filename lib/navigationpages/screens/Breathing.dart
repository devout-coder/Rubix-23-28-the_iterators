import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:csi_hackathon/navigationpages/screens/Rewards.dart';
import 'package:csi_hackathon/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get_it/get_it.dart';
// import 'package:flutter_tts/flutter_tts.dart';

class Breathing extends StatefulWidget {
  const Breathing({Key? key}) : super(key: key);

  @override
  State<Breathing> createState() => _BreathingState();
}

RotateAnimatedText animeText(String text) {
  return RotateAnimatedText(
    text,
    transitionHeight: 200,
    alignment: AlignmentDirectional.center,
    textAlign: TextAlign.center,
    textStyle: TextStyle(
      fontSize: 30,
      fontFamily: 'EuclidCircular',
      fontWeight: FontWeight.w600,
    ),
    duration: Duration(milliseconds: 4500),
  );
}

class _BreathingState extends State<Breathing> with WidgetsBindingObserver {
  States states = GetIt.I.get();
  FlutterTts ftts = FlutterTts();

  void speak() async {
    debugPrint("started speaking");
    ftts.setSpeechRate(0.3);
    var result = await ftts.speak(
        "Sit in a quiet and comfortable place. Put one of your hands on your chest and the other on your stomach. Your stomach should move more than your chest when you breathe in deeply. Take a slow and regular breath in through your nose. Watch and sense your hands as you breathe in. The hand on your chest should remain still while the hand on your stomach will move slightly. Breathe out through your mouth slowly.");
  }

  @override
  // void initState() {
  //   // const platform = MethodChannel('alarms');
  //   // platform.invokeMethod("speak", {
  //   //   "text":
  //   //       "Sit in a quiet and comfortable place. Put one of your hands on your chest and the other on your stomach."
  //   // });
  //   speak();
  //   super.initState();
  // }

  @override
  void initState() {
    speak();
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    print("InitState");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("DidChangeDependencies");
  }

  @override
  void setState(fn) {
    print("SetState");
    super.setState(fn);
  }

  @override
  void deactivate() {
    print("Deactivate");
    super.deactivate();
  }

  @override
  void dispose() {
    print("Dispose");
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        print('appLifeCycleState inactive');
        ftts.pause();
        break;
      case AppLifecycleState.resumed:
        print('appLifeCycleState resumed');
        setState(() {});
        speak();
        break;
      case AppLifecycleState.paused:
        print('appLifeCycleState paused');
        break;
      case AppLifecycleState.detached:
        print('appLifeCycleState detached');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("build again");
    return WillPopScope(
      onWillPop: () async {
        ftts.pause();
        return true;
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AnimatedTextKit(
            key: UniqueKey(),
            onFinished: () {
              Random rnd;
              int min = 100;
              int max = 1000;
              rnd = new Random();
              int r = min + rnd.nextInt(max - min);
              states.points += r;

              DateTime today = DateTime(DateTime.now().year,
                  DateTime.now().month, DateTime.now().day);
              if (states.activities.containsKey(today)) {
                states.activities[today]!["Breathing"] = r;
              } else {
                states.activities[today] = {"Breathing": r};
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
      ),
    );
  }
}
