import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:productivity_hub/view/To-do_section/To-Do_page.dart';
import 'package:productivity_hub/view/habit_tracker_section/category_habits.dart';


void main() {
    
  runApp(
  
    const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      
      theme: ThemeData(
        
        scaffoldBackgroundColor: const Color.fromARGB(255, 223, 220, 223),
        brightness: Brightness.light,
      
        // cardColor: Colors.white,
        cardTheme: const CardTheme(color: Color.fromARGB(255, 246, 246, 246), elevation: 3,),
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      //
      //Change screen here
      //
      home: const TO_DO_page(),
      //
      //Change screen here
      //
      themeMode: ThemeMode.dark,

      darkTheme: ThemeData(
        primaryColor: Colors.white,
        
        brightness: Brightness.dark,
        cardTheme: const CardTheme(color: Color.fromARGB(121, 27, 27, 27),),
          scaffoldBackgroundColor: const Color.fromARGB(255, 60, 60, 60),
      ),
    );
  }
}

