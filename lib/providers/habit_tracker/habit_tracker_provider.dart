import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/habit_tracker/habits_model.dart';

class HabitNotifier extends StateNotifier<Map<String, List<Habit>>> {
  HabitNotifier() : super({
    'Stay Fit': stayFitHabits,
    'Stay Healthy': stayHealthyHabits,
    'Productivity Boost': productivityBoostHabits,
    'Strengthen Relationships': strengthenRelationshipsHabits,
    'Diet': dietHabits,
  });

  void updateHabit(Habit updatedHabit) {
    final category = updatedHabit.category;
    final updatedList = state[category]!.map((habit) {
      return habit.name == updatedHabit.name ? updatedHabit : habit;
    }).toList();
    state = {
      ...state,
      category: updatedList,
    };
  }

  List<Habit> get completedHabits {
    return state.values.expand((list) => list).where((h) => h.isCompleted).toList();
  }


  void toggleCompletion(Habit habit) {
    updateHabit(habit.copyWith(isCompleted: !habit.isCompleted));
  }

  void setReminderTime(Habit habit, TimeOfDay time) {
    updateHabit(habit.copyWith(reminderTime: time));
  }

  void setStartDate(Habit habit, DateTime date) {
    updateHabit(habit.copyWith(startDate: date));
  }

  void setRepeatDays(Habit habit, List<String> days) {
    updateHabit(habit.copyWith(repeatDays: days));
  }

  void setHabitColor(Habit habit, Color color) {
    updateHabit(habit.copyWith(color: color));
  }

  void addHabitToCategory(Habit habit) {
    final category = habit.category;
    final updatedList = [...state[category]!, habit];
    state = {
      ...state,
      category: updatedList,
    };
  }
}

final habitProvider = StateNotifierProvider<HabitNotifier, Map<String, List<Habit>>>((ref) {
  return HabitNotifier();
});


// Provider for the list of habit categories


// Provider for the selected habits
final selectedHabitsProvider = StateNotifierProvider<SelectedHabitsNotifier, List<Habit>>((ref) {
  return SelectedHabitsNotifier();
});

class SelectedHabitsNotifier extends StateNotifier<List<Habit>> {
  SelectedHabitsNotifier() : super([]);

  void addHabit(Habit habit) {
    state = [...state, habit];
  }
    void updateHabit(Habit updatedHabit) {
    state = [
      for (final habit in state)
        if (habit.name == updatedHabit.name) updatedHabit else habit,
    ];
   
  }

   void resetCompletedRepetitions(Habit habit) {
    updateHabit(habit.copyWith(completedRepetitions: 0));
  }

   List<Habit> get incompleteHabits {
    return state.where((h) => !h.isCompleted).toList();
  }

    List<Habit> get completedHabits {
    return state.where((h) => h.isCompleted).toList();
  }
 void update_repetitions(Habit habit) {
    updateHabit(
      habit.copyWith(
        completedRepetitions: habit.completedRepetitions + 1,
        isCompleted: habit.completedRepetitions + 1 >= habit.repetitions,
      ),
    );
  }

 
     void toggleCompleted(Habit habit) {
    state = [
      for (final h in state)
        if (h.name == habit.name)
          h.copyWith(isCompleted: !h.isCompleted,
          completedRepetitions: habit.isCompleted
          ? habit.completedRepetitions - 1
          : habit.completedRepetitions + 1,
          )
          
        else
          h
    ];
  }

  void removeHabit(Habit habit) {
    state = state.where((h) => h.name != habit.name).toList();
  }
}

