import 'package:flutter/material.dart';

class Habit {
  final String name;
  Color? textColor;

  int repetitions;
  List<String> timeOfDay; // morning, afternoon, evening
  TimeOfDay? reminderTime; // nullable time for reminder
  List<String> repeatDays; // days to repeat on
  bool isCompleted;
  Color? color;
  String? description;
  DateTime? startDate;
  final String category;
  final int completedRepetitions;

  Habit({
    required this.name,
    this.description,
    
    this.textColor = Colors.black,
    this.completedRepetitions = 0,
    this.repetitions = 1,
    this.timeOfDay = const ['morning', 'afternoon', 'evening'],
    this.reminderTime,
    this.repeatDays = const ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'],
    this.isCompleted = false,
    this.color = Colors.blue,
    this.startDate,
    required this.category,
  });
Habit copyWith({
    String? name,
    String? category,
    String? description,
    int? completedRepetitions,
    int? repetitions,
    List<String>? timeOfDay,
    TimeOfDay? reminderTime,
    List<String>? repeatDays,
    bool? isCompleted,
    Color? color,
    Color? textColor,
    DateTime? startDate,
  }) {
    return Habit(
      name: name ?? this.name,
      category: category ?? this.category,
      completedRepetitions: completedRepetitions ?? this.completedRepetitions,
      repetitions: repetitions ?? this.repetitions,
      timeOfDay: timeOfDay ?? this.timeOfDay,
      reminderTime: reminderTime ?? this.reminderTime,
      repeatDays: repeatDays ?? this.repeatDays,
      isCompleted: isCompleted ?? this.isCompleted,
      color: color ?? this.color,
      textColor: textColor ?? this.textColor,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
    );
  }

}

final List<Habit> stayFitHabits = [
  Habit(name: 'Quick Stretch', category: 'Stay Fit', color: Colors.pinkAccent.shade100, textColor: Colors.white),
  Habit(name: 'Hit the Gym', category: 'Stay Fit', color: Colors.purpleAccent.shade100, textColor: Colors.yellowAccent.shade700),
  Habit(name: 'Swimming', category: 'Stay Fit', color: Colors.yellowAccent.shade100, textColor: Colors.blueGrey.shade800),
  Habit(name: 'Gym', category: 'Stay Fit', color: Colors.greenAccent.shade100, textColor: Colors.brown.shade700),
  Habit(name: 'Yoga', category: 'Stay Fit', color: Colors.orangeAccent.shade100, textColor: Colors.deepPurple.shade600),
  Habit(name: 'Cardio', category: 'Stay Fit', color: Colors.cyanAccent.shade100, textColor: Colors.indigo.shade900),
  Habit(name: 'Cycling', category: 'Stay Fit', color: Colors.blueAccent.shade100, textColor: Colors.amber.shade700),
];

final List<Habit> stayHealthyHabits = [
  Habit(name: 'Walk', category: 'Stay Healthy', color: Colors.pinkAccent.shade100, textColor: Colors.white),
  Habit(name: 'Sleep', category: 'Stay Healthy', color: Colors.purpleAccent.shade100, textColor: Colors.orangeAccent.shade700),
  Habit(name: 'Cold Shower', category: 'Stay Healthy', color: Colors.yellowAccent.shade100, textColor: Colors.blueGrey.shade800),
  Habit(name: 'Power naps', category: 'Stay Healthy', color: Colors.greenAccent.shade100, textColor: Colors.brown.shade700),
  Habit(name: 'Deep breaths', category: 'Stay Healthy', color: Colors.orangeAccent.shade100, textColor: Colors.deepPurple.shade600),
  Habit(name: 'Drink water', category: 'Stay Healthy', color: Colors.cyanAccent.shade100, textColor: Colors.indigo.shade900),
];

final List<Habit> productivityBoostHabits = [
  Habit(name: 'Go through Articles', category: 'Productivity Boost', color: Colors.pinkAccent.shade100, textColor: Colors.white),
  Habit(name: 'Review your day', category: 'Productivity Boost', color: Colors.purpleAccent.shade100, textColor: Colors.yellowAccent.shade700),
  Habit(name: 'Check mails', category: 'Productivity Boost', color: Colors.yellowAccent.shade100, textColor: Colors.blueGrey.shade800),
  Habit(name: 'Journal', category: 'Productivity Boost', color: Colors.greenAccent.shade100, textColor: Colors.brown.shade700),
];

final List<Habit> strengthenRelationshipsHabits = [
  Habit(name: 'Talk to parents', category: 'Strengthen Relationships', color: Colors.pinkAccent.shade100, textColor: Colors.white),
  Habit(name: 'Family time', category: 'Strengthen Relationships', color: Colors.purpleAccent.shade100, textColor: Colors.orangeAccent.shade700),
  Habit(name: 'Compliment someone', category: 'Strengthen Relationships', color: Colors.yellowAccent.shade100, textColor: Colors.blueGrey.shade800),
  Habit(name: 'Visit a friend', category: 'Strengthen Relationships', color: Colors.greenAccent.shade100, textColor: Colors.brown.shade700),
  Habit(name: 'Be grateful', category: 'Strengthen Relationships', color: Colors.orangeAccent.shade100, textColor: Colors.deepPurple.shade600),
  Habit(name: 'Embrace yourself', category: 'Strengthen Relationships', color: Colors.cyanAccent.shade100, textColor: Colors.indigo.shade900),
];

final List<Habit> dietHabits = [
  Habit(name: 'Vitamins', category: 'Diet', color: Colors.pinkAccent.shade100, textColor: Colors.white),
  Habit(name: 'Fruits', category: 'Diet', color: Colors.purpleAccent.shade100, textColor: Colors.yellowAccent.shade700),
  Habit(name: 'Limit caffeine', category: 'Diet', color: Colors.yellowAccent.shade100, textColor: Colors.blueGrey.shade800),
  Habit(name: 'Limit sugar', category: 'Diet', color: Colors.greenAccent.shade100, textColor: Colors.brown.shade700),
];
