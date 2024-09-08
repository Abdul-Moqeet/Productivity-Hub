import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:productivity_hub/models/habit_tracker/habits_model.dart';
import 'package:productivity_hub/view/To-do_section/To-Do_page.dart';
import 'package:productivity_hub/view/combined_screens/focus.dart';
import 'package:productivity_hub/view/habit_tracker_section/category_habits.dart';
import 'package:smooth_corner/smooth_corner.dart';
import 'package:productivity_hub/providers/habit_tracker/habit_tracker_provider.dart';

class HabitListScreen extends ConsumerStatefulWidget {
  const HabitListScreen({super.key});

  @override
  ConsumerState<HabitListScreen> createState() => _HabitListScreenState();
}

class _HabitListScreenState extends ConsumerState<HabitListScreen> {
  void _toggleCompletion(Habit habit) {
    ref.read(selectedHabitsProvider.notifier).toggleCompleted(habit);
  }

  @override
  Widget build(BuildContext context) {
    final timeline = ['Daily', 'Weekly'];
    ref.watch(selectedHabitsProvider);
    final completedHabits = ref.watch(selectedHabitsProvider.notifier).completedHabits;
    final incompletedHabits = ref.watch(selectedHabitsProvider.notifier).incompleteHabits;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 60, 60, 60),
      // backgroundColor: const Color.fromARGB(255, 244, 225, 248),
      body: SingleChildScrollView(
       
          child: Stack(
            children: [
             
              SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 80),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        children: [
                          Text(
                            'Habits',
                            style: GoogleFonts.inter(
                              fontSize: 40,
                              fontWeight: FontWeight.w500,
                              letterSpacing: -1,
                              height: 0.1
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 50.0, left: 0),
                            child: Text(
                              '(${incompletedHabits.length.toString()})',
                              style: GoogleFonts.inter(
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                                height: 0.1
                              ),
                            ),
                          ),
                           Center(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> const NewHabitScreen()));
                              },
                              child: const Icon(
                                Icons.add_circle_outline,
                                size: 40,
                                color: Color.fromARGB(255, 200, 200, 200)
                              ),
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                          const CircleAvatar(
                            backgroundImage: AssetImage('assets/images/woman.jpg'),
                            radius: 28,
                          ),
                        ],
                      ),
                    ),
                    // SingleChildScrollView(
                    //   scrollDirection: Axis.horizontal,
                    //   child: Row(
                    //     children: [
                    //       const SizedBox(width: 20),
                    //       Text(
                    //         'Daily',
                    //         style: GoogleFonts.lato(
                    //           fontSize: 65,
                    //           fontWeight: FontWeight.w700,
                    //           letterSpacing: -2,
                    //           height: 1.4
                    //         ),
                    //       ),
                    //       const SizedBox(width: 13),
                    //       Text(
                    //         'Weekly',
                    //         style: GoogleFonts.lato(
                    //           fontSize: 60,
                    //           fontWeight: FontWeight.w600,
                    //           color: const Color.fromARGB(255, 134, 130, 130),
                    //           height: 1.4
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // const Padding(
                    //   padding: EdgeInsets.only(left: 30.0, bottom: 10),
                    //   child: Text('Your Timeline',
                    //       style:
                    //           TextStyle(fontSize: 25, fontWeight: FontWeight.w600)),
                    // ),
                    const SizedBox(height: 20,),
                    SizedBox(
                      height: 80,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        clipBehavior: Clip.none,
                        scrollDirection: Axis.horizontal,
                        itemCount: dates.length,
                        itemBuilder: (context, index) {
                          final date = dates[index];
                          return GestureDetector(
                            onTap: () {
                              ref.read(selectedDateProvider.notifier).state = date;
                            },
                            child: SmoothContainer(
                              width: 58,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 3, vertical: 4),
                              padding: const EdgeInsets.all(10),
                              color: DateFormat('yyyy-MM-dd').format(date) ==
                                      DateFormat('yyyy-MM-dd')
                                          .format(DateTime.now())
                                  ? const Color.fromARGB(255, 94, 79, 111)
                                  : const Color.fromARGB(255, 43, 42, 42),
                              borderRadius: BorderRadius.circular(15),
                              smoothness: 1,
                              child: Center(
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      DateFormat('d').format(date),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 17),
                                    ),
                                    Text(
                                      DateFormat('EEE').format(date),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      height: 300,
                      child: SmoothCard(
                        borderRadius: BorderRadius.circular(25),
                        smoothness: 1,
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                          itemCount: incompletedHabits.length,
                          itemBuilder: (context, index) {
                            final habit = incompletedHabits[index];
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    // MSHCheckbox(
                                    //   style: MSHCheckboxStyle.stroke,
                                    //   size: 20,
                                      
                                    //   colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(uncheckedColor: const Color.fromARGB(255, 171, 170, 170), checkedColor: const Color.fromARGB(255, 255, 255, 255),),
                                    //   value: habit.isCompleted,
                                    //   onChanged: (value) {
                                    //     setState(() {
                                    //       _toggleCompletion(habit);
                                    //     });
                                    //   },
                                    // ),
                                    const SizedBox(width: 10,),
                                    IconButton(icon: const Icon(Icons.timer_outlined, color: Colors.blue,), onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const focus_screen()));
                                    },),
                                    const SizedBox(width: 5,),
                                    Flexible(
                                      child: Text(
                                        habit.name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    // Flexible(child: SizedBox()),
                                    TextButton(onPressed: (){
                                    ref.watch(selectedHabitsProvider.notifier).toggleCompleted(habit);
                                    }, child: Container(
                                      height: 30,
                                      width: 60,
                                      decoration: BoxDecoration(color: const Color.fromARGB(255, 49, 49, 49),
                                      borderRadius: BorderRadius.circular(30)),
                                      child: Center(child: Text('${habit.completedRepetitions} / ${habit.repetitions}', style: const TextStyle(color: Colors.white),))))
                                  ],
                                ), 
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 2),
                                  child: Divider(
                                    color: Color.fromARGB(125, 158, 158, 158),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Completed', style: GoogleFonts.lato(fontSize: 30, fontWeight: FontWeight.w600),)),
                  ),
                    completedHabits.isNotEmpty
                    ? ListView.builder(
                       
                        shrinkWrap: true,
                        // physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        itemCount: completedHabits.length,
                        itemBuilder: (context, index) {
                          final habit = completedHabits[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 5),
                            height: 100,
                            child: SmoothCard(
                              color: const Color.fromARGB(192, 255, 255, 255),
                              borderRadius: BorderRadius.circular(20),
                              smoothness: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20, right: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            habit.name,
                                            style: const TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            habit.description ?? '',
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(fontSize: 15, color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    MSHCheckbox(
                                      value: habit.isCompleted,
                                      onChanged: (bool? value) {
                                        ref.read(selectedHabitsProvider.notifier).toggleCompleted(habit);
                                      },
                                      colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                                        checkedColor: Colors.black,
                                        uncheckedColor: Colors.black,
                                      ),
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ) :
                    
                    // SizedBox(height: 70,),
                    const Text('Hurry Up! Time is running out!', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                 
                  ],
                  
                ),
              ),
            ],
          ),
        ),
      );
    
  }
}
