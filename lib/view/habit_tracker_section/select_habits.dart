import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:productivity_hub/models/habit_tracker/habits_model.dart';
import 'package:productivity_hub/view/habit_tracker_section/detail_habit.dart';

class habit_selection extends ConsumerWidget {
  const habit_selection({super.key, required this.category});
final String category;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Use category name to fetch the relevant habits list
    final List<Habit> relevantHabits;
    switch (category) {
      case 'Exercise':
        relevantHabits = stayFitHabits;
        break;
      case 'Stay Healthy':
        relevantHabits = stayHealthyHabits;
        break;
      case 'Productivity Boost':
        relevantHabits = productivityBoostHabits;
        break;
      case 'Strengthen Relationships':
        relevantHabits = strengthenRelationshipsHabits;
        break;
      case 'Improve Diet':
        relevantHabits = dietHabits;
        break;
      default:
        relevantHabits = [];
        break;
    }

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(category),
        
      ),
      body: Container(
         
        child: ListView.builder(
          itemCount: relevantHabits.length,
          itemBuilder: (context, index) {
            final habit = relevantHabits[index];
            return ListTile(
              title: Text(habit.name),
              subtitle: Text(habit.description ?? ''),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailHabit(habit: habit),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}