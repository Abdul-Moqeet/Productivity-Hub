// import 'package:flutter/material.dart';
// import 'package:giffy_dialog/giffy_dialog.dart';

// class task_add_select extends StatelessWidget {
//   const task_add_select({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // body: Center(
//       //   child: Column(
//       //     mainAxisAlignment: MainAxisAlignment.center,
//       //     crossAxisAlignment: CrossAxisAlignment.center,
//       //     children: [
//       //       SmoothContainer(
//       //         width: 200,
//       //         child: TextButton(onPressed: () {}, child: Text('Add Task', style: TextStyle(color: Colors.black),)),
//       //         borderRadius: BorderRadius.circular(20),
//       //         color: Colors.white,
//       //       ),
//       //       SizedBox(height: 20,),
//       //       SmoothContainer(
//       //         width: 200,
//       //         child: TextButton(onPressed: () {}, child: Text('Add Habit', style: TextStyle(color: Colors.black),)),
//       //         borderRadius: BorderRadius.circular(20),
//       //         color: Colors.white,
//       //       ),
//       //     ],
//       //   ),
//       // ),
//      body: GiffyBottomSheet.image(
//        'assets/images/woman.jpg',
//        title: const Text(
//          'Image Animation',
//          textAlign: TextAlign.center,
//        ),
//        content: const Text(
//          'This is a image animation bottom sheet. This library helps you easily create fancy giffy bottom sheet.',
//          textAlign: TextAlign.center,
//        ),
//        actions: [
//          TextButton(
//            onPressed: () => Navigator.pop(context, 'CANCEL'),
//            child: const Text('CANCEL'),
//          ),
//          TextButton(
//            onPressed: () => Navigator.pop(context, 'OK'),
//            child: const Text('OK'),
//          ),
//        ],
//      )
//     );
//   }
// }
