import 'package:flutter_riverpod/flutter_riverpod.dart';

// Define the HabitCategory class
class HabitCategory {
  final String name;
  final String description;
  final String image;

  HabitCategory({required this.name, required this.description, required this.image});
}

// Define the list of habit categories
final List<HabitCategory> habitCategories = [
  HabitCategory(name: 'Exercise', description: 'Stay fit and active with regular exercise.', image: 'assets/images/habit_tracker/good_habits/excercise1.png',),
  HabitCategory(name: 'Stay Healthy', description: 'Maintain your health with good habits.', image: 'assets/images/habit_tracker/good_habits/health1.png'),
  HabitCategory(name: 'Productivity Boost', description: 'Enhance your productivity with effective routines.',image: 'assets/images/habit_tracker/good_habits/meditation.png'),
  HabitCategory(name: 'Strengthen Relationships', description: 'Build and strengthen',image: 'assets/images/habit_tracker/good_habits/friends.png'),
  HabitCategory(name: 'Improve Diet', description: 'Improve your diet for better health.',image: 'assets/images/habit_tracker/good_habits/excercise1.png'),
];

// Create a provider for the list of habit categories
final habitCategoriesProvider = Provider<List<HabitCategory>>((ref) {
  return habitCategories;
});
