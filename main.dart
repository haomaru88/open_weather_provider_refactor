// import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 110,
            color: Color(0xFFF4EDDB),
            fontFamily: MyFontFamily.glory,
            // fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class MyFontFamily {
  static const glory = "Glory";
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Timer timer;
  static const int initSeconds = 5;
  static const int sixty = 60;
  int totalPomo = 0;
  int totalSeconds = initSeconds;
  int totlaMilliSeconds = 0;
  bool isRunning = false;
  int pomodoros = 0;
  Duration duration = const Duration(milliseconds: 100); // 0.1 Second
  int minute = initSeconds ~/ sixty;
  int second = initSeconds % 60;

  void tickTimer(Timer tm) {
    setState(() {
      if (totalSeconds == 0 && totlaMilliSeconds == 0) {
        totalSeconds = initSeconds;
        totalPomo++;
      } else {
        totlaMilliSeconds--;
        if (totlaMilliSeconds < 0) {
          totalSeconds--;
          totlaMilliSeconds = 9;
        }
      }
    });
  }

  void clickStart() {
    timer = Timer.periodic(duration, tickTimer);
    isRunning = true;
    setState(() {});
  }

  void clickPause() {
    isRunning = false;
    timer.cancel();
    setState(() {});
  }

  List<String> formatTimer(int seconds) {
    var duration = Duration(seconds: seconds);
    List<String> list = duration.toString().split(".").first.split(":");
    list.remove(list.first);
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isRunning ? const Color.fromARGB(255, 16, 78, 170) : const Color.fromARGB(255, 224, 80, 92),
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  flex: 5,
                  child: Container(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      formatTimer(totalSeconds).first,
                      textAlign: TextAlign.end,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.only(
                      bottom: 8,
                    ),
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      ':',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  flex: 4,
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      formatTimer(totalSeconds).last,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  flex: 1,
                  child: Transform.translate(
                    offset: const Offset(-26, -5),
                    child: Container(
                      alignment: Alignment.bottomLeft,
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        '$totlaMilliSeconds',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.headlineLarge!.color,
                          fontSize: 35,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
              flex: 2,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: isRunning ? clickPause : clickStart,
                    color: Theme.of(context).textTheme.headlineLarge!.color,
                    iconSize: 110,
                    // splashColor: Colors.white54,
                    // splashRadius: 80,
                    // padding: const EdgeInsets.all(0),
                    icon: Icon(
                      isRunning ? Icons.pause_circle_outline : Icons.play_circle_outline,
                      // shadows: [
                      //   Shadow(
                      //     color: Colors.grey.shade500,
                      //     offset: const Offset(3, 3),
                      //     blurRadius: 16,
                      //   ),
                      // ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  IconButton(
                    onPressed: () {
                      timer.cancel();
                      totalSeconds = initSeconds;
                      totlaMilliSeconds = 0;
                      totalPomo = 0;
                      isRunning = false;
                      setState(() {});
                    },
                    color: Theme.of(context).textTheme.headlineLarge!.color!.withOpacity(0.5),
                    iconSize: 50,
                    icon: const Icon(Icons.settings_backup_restore_rounded),
                  ),
                ],
              )),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).textTheme.headlineLarge!.color,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Pomodoros',
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                        Text(
                          '$totalPomo',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
