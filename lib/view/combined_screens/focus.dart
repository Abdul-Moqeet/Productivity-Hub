import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

class focus_screen extends StatefulWidget {
  const focus_screen({super.key});

  @override
  State<focus_screen> createState() => _focus_screenState();
}

class _focus_screenState extends State<focus_screen> {
  final CountDownController _controller = CountDownController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: CircularCountDownTimer(
              width: 250,
              isReverse: true,
              controller: _controller,
              isReverseAnimation: true,
              height: 250,
              duration: 100,
              fillColor: Colors.blue,
              ringColor: Colors.grey,
              strokeWidth: 15,
              strokeCap: StrokeCap.round,
              textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.w600),
              autoStart: true,
            ),
          ),
          Row(
            children: [
              TextButton(
                  onPressed: () {
                    _controller.start();
                    print('worked');
                  },
                  child: const Text('Start')),
              TextButton(
                  onPressed: () {
                    _controller.pause();
                  },
                  child: const Text('Paused'))
            ],
          )
        ],
      ),
    );
  }
}
