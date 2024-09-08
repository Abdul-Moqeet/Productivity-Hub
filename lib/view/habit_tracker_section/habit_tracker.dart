import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:productivity_hub/constants/colors.dart';
import 'package:productivity_hub/view/To-do_section/To-Do_page.dart';
import 'package:productivity_hub/view/habit_tracker_section/category_habits.dart';
import 'package:smooth_corner/smooth_corner.dart';

class HabitTrackerScreen extends ConsumerWidget {
  const HabitTrackerScreen({super.key});

  


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    return  Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(80), child: custom_appBar(),),
      body: Container(
         decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 19, 19, 19),
                    Color.fromARGB(201, 10, 10, 10),
                    Color.fromARGB(170, 6, 6, 6),
                    Color.fromARGB(122, 10, 10, 10),
                  ],
                  // stops: [,  1],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
        child: Column(children: [
          
                      const Padding(
                        padding: EdgeInsets.only(left: 30.0, bottom: 10),
                        child: Text('Your Timeline',
                            style:
                                TextStyle(fontSize: 25, fontWeight: FontWeight.w600)),
                      ),
                      SizedBox(
                        height: 80,
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          clipBehavior: Clip.none,
                          scrollDirection: Axis.horizontal,
                          reverse: true,
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
                                    ? color_orange
                                    : const Color.fromARGB(255, 43, 42, 42),
                                borderRadius: BorderRadius.circular(15),
                                smoothness: .2,
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
        ],),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
         Navigator.push(context, MaterialPageRoute(builder: (context)=> const NewHabitScreen()));
      }, child: Container(
        // color: Colors.white,
        child: const Icon(Icons.add),),),
    );
  }
}