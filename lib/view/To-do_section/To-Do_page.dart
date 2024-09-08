import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:productivity_hub/components/filtered_tasks_widget.dart';
import 'package:productivity_hub/constants/colors.dart';
import 'package:productivity_hub/models/To-do/Tasks_model.dart';
import 'package:productivity_hub/providers/filtered_tasks_provider.dart';
import 'package:productivity_hub/providers/to_do_provider.dart';
import 'package:productivity_hub/view/To-do_section/new_task.dart';
import 'package:productivity_hub/view/habit_tracker_section/category_habits.dart';
import 'package:smooth_corner/smooth_corner.dart';

final selectedDateProvider = StateProvider<DateTime>((ref) => DateTime.now());
final dates = List.generate(30, (index) => DateTime.now().subtract(Duration(days: index)));


class TO_DO_page extends ConsumerWidget {
  const TO_DO_page({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(todoListProvider);
    // final selectedDate = ref.watch(selectedDateProvider);
    final filteredTask = ref.watch(filteredTasksProvider);

    return Container(
      
      child: Scaffold(
        // backgroundColor: Color.fromARGB(109, 216, 216, 216),
backgroundColor: const Color.fromARGB(255, 60, 60, 60),

appBar: PreferredSize(preferredSize: Size.fromHeight(70), child: custom_appBar()),
        body: tasks.isEmpty
            ? Container(
              
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   
                    Center(child: Image.asset('assets/images/bg_todo.png')),
                    const SizedBox(height: 10),
                    const Text('What do you want to do today?'),
                    const SizedBox(height: 10),
                    const Text('Tap + button at the bottom to add tasks'),
                  ],
                ),
            )
            : SingleChildScrollView(
                child: SizedBox(
                  
                  height: 1000,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0, bottom: 10),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          height: 60,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 43, 42, 42),
                              borderRadius: BorderRadius.circular(40)),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: Center(
                              child: TextField(
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.search),
                                    contentPadding: EdgeInsets.only(top: 12),
                                    hintText: 'Search your task...',
                                    hintStyle: TextStyle(
                                        fontFamily:
                                            'SFProRounded-Rectangular.ttf',
                                        fontSize: 18),
                                    border: InputBorder.none),
                              ),
                            ),
                          ),
                        ),
                      ),
      //
      //
                      /// Below is the working code for Timeline
      //
      //
      
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
      
      //
      //
      // Above is the working code for Timeline
      //
      //
      
                      // TextButton(
                      //     onPressed: () {
                      //       Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //               builder: (context) => const AllTaskList()));
                      //     },
                      //     child: Container(
                      //       child: const Text('View All'),
                      //     )),
      
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10),
                        child: Row(
                          children: [
                            Expanded(child: Sidebar(filteredTask: filteredTask)),
                            Expanded(
                              child: SmoothContainer(
                                margin: const EdgeInsets.only(left: 5),
                                padding: const EdgeInsets.only(
                                    left: 20, top: 20, right: 20),
                                color: color_orange,
                                // width: 220,
                                height: 280,
                                borderRadius: BorderRadius.circular(30),
                                smoothness: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Today',
                                        style: GoogleFonts.lexendDeca(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(
                                      height: 150,
                                      child: Center(child: Text('All Done For Today!', textAlign: TextAlign.center,style: TextStyle(color: Colors.white, fontSize: 17),),),
                                      // child: ListView.builder(
                                      //   itemCount: filteredTask.length,
                                      //   itemBuilder: (context, index) {
                                      //     final task = filteredTask[index];
                                      //     return Column(
                                      //       crossAxisAlignment:
                                      //           CrossAxisAlignment.start,
                                      //       children: [
                                      //         Row(
                                      //           mainAxisAlignment:
                                      //               MainAxisAlignment
                                      //                   .spaceBetween,
                                      //           children: [
                                      //             Flexible(
                                      //               child: Text(
                                      //                 task.title,
                                      //                 style:
                                      //                     GoogleFonts.lexendDeca(
                                      //                         fontSize: 16,
                                      //                         color:
                                      //                             Colors.white),
                                      //                 overflow:
                                      //                     TextOverflow.ellipsis,
                                      //               ),
                                      //             ),
                                      //             MSHCheckbox(
                                      //               value: task.isCompleted,
                                      //               onChanged: (bool? value) {
                                      //                 ref
                                      //                     .read(todoListProvider
                                      //                         .notifier)
                                      //                     .toggleTaskCompletion(
                                      //                         task.id);
                                      //               },
                                      //               colorConfig: MSHColorConfig
                                      //                   .fromCheckedUncheckedDisabled(
                                      //                       checkedColor:
                                      //                           Colors.black,
                                      //                       uncheckedColor:
                                      //                           Colors.black),
                                      //             )
                                      //           ],
                                      //         ),
                                      //       ],
                                      //     );
                                      //   },
                                      // ),
                                    )
                                    // SizedBox(height: 80,),
                                    // Text('Tomorrow',  style: GoogleFonts.lexendDeca(fontSize: 18, color: Colors.black))
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20.0, bottom: 10),
                        child: Text("Today's task",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w600)),
                      ),
                      const Expanded(
                          child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: tasks_widget(),
                      )),
                    ],
                  ),
                ),
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
     Dialogs.bottomMaterialDialog(
          msg: 'Are you sure? you can\'t undo this action',
          title: 'Select to add', color: const Color.fromARGB(255, 51, 50, 50),
          context: context,
          actions: [
            IconsOutlineButton(
              onPressed: () {
                 Navigator.push(context,
                MaterialPageRoute(builder: (context) => const NewTask()));
              },
              text: 'Add Task',
                // color: const Color.fromARGB(255, 255, 167, 27),
              // iconData: Icons.cancel_outlined,
              textStyle: TextStyle(color: Colors.white),
              iconColor: Colors.white,
            ),
            IconsOutlineButton(
              onPressed: () {
                 Navigator.push(context,
                MaterialPageRoute(builder: (context) => const NewHabitScreen()));
              },
              text: 'Add Habit',
              // iconData: Icons.delete,
              // color: const Color.fromARGB(255, 255, 167, 27),
              textStyle: TextStyle(color: Colors.white),
              iconColor: Colors.white,
            ),
          ]);
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => const NewTask()));x
          },
          child: const Icon(Icons.add),
        ),

        // bottom navigation bar

      
      ),
    );
  }
}

class Sidebar extends ConsumerWidget {
  const Sidebar({
    super.key,
    required this.filteredTask,
  });

  final List<Task> filteredTask;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completedTasks = ref.read(todoListProvider.notifier).completedTasks;
    double progress = filteredTask == 0
        ? 0
        : (completedTasks.length / filteredTask.length) * 100;
    int IntProgress = progress.toInt();
    return Column(
      children: [
        SmoothContainer(
          margin: const EdgeInsets.only(bottom: 20, right: 5),
          padding: const EdgeInsets.only(left: 5, top: 20, right: 10),
          color: Colors.white,
          // width: 150,
          height: 180,
          borderRadius: BorderRadius.circular(30),
          smoothness: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Today',
                  style: GoogleFonts.lexendDeca(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: 134,
                child: ListView.builder(
                  itemCount: filteredTask.length,
                  itemBuilder: (context, index) {
                    final task = filteredTask[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            MSHCheckbox(
                              value: task.isCompleted,
                              onChanged: (bool? value) {
                                ref
                                    .read(todoListProvider.notifier)
                                    .toggleTaskCompletion(task.title);
                              },
                              colorConfig:
                                  MSHColorConfig.fromCheckedUncheckedDisabled(
                                      checkedColor: Colors.black,
                                      uncheckedColor: Colors.black),
                            ),
                            const SizedBox(width: 5),
                            Flexible(
                              child: Text(
                                task.title,
                                maxLines: 2,
                                style: GoogleFonts.lexendDeca(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Divider(
                            color: Color.fromARGB(151, 201, 199, 199),
                            height: 4,
                          ),
                        )
                      ],
                    );
                  },
                ),
              )
              // SizedBox(height: 80,),
              // Text('Tomorrow',  style: GoogleFonts.lexendDeca(fontSize: 18, color: Colors.black))
            ],
          ),
        ),
        SmoothContainer(
          margin: const EdgeInsets.only(right: 5),
          padding: const EdgeInsets.only(left: 15, right: 10),
          color: const Color.fromARGB(255, 25, 24, 24),
          // width: 220,
          height: 70,
          borderRadius: BorderRadius.circular(20),
          smoothness: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Daily Task',
                    style: GoogleFonts.lexendDeca(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${completedTasks.length}/${filteredTask.length} done',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              CircularPercentIndicator(
                radius: 25,
                progressColor: Colors.white,
                percent: completedTasks.isEmpty
                    ? 0
                    : completedTasks.length / filteredTask.length,
                // arcBackgroundColor: Colors.amber,
                center: Text(
                  '$IntProgress%',
                  style: GoogleFonts.lexendDeca(
                      fontSize: 13, fontWeight: FontWeight.bold),
                ),
                startAngle: 400,
                lineWidth: 6,
                animation: true,
                animationDuration: 1000,
                rotateLinearGradient: true,
                backgroundColor: Colors.transparent,
              )
            ],
          ),
        ),
      ],
    );
  }
}

class custom_appBar extends StatelessWidget {
  custom_appBar({
    super.key,
    this.icon = const Icon(Icons.menu, color: Colors.black,),
  });
  final icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10, top: 18),
      child: AppBar(
  
        leading: Container(
          padding: const EdgeInsets.all(6),
          height: 40,
          width: 10,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 81, 81, 81),
              borderRadius: BorderRadius.circular(100)),
          // child: CircleAvatar(
          //   backgroundColor: Colors.white,
          //   child: Image.asset('assets/icons/menu/back.png'),
          // ),
          // child: IconButton(onPressed: (){}, icon: Icon(Icons.menu, color: Colors.black,)),
          child:  Container(
          
          height: 10,
          width: 10,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100)),
          // child: CircleAvatar(
          //   backgroundColor: Colors.white,
          //   child: Image.asset('assets/icons/menu/back.png'),
          // ),
          child: IconButton(onPressed: (){}, icon: icon),
        ),
        ),
        forceMaterialTransparency: true,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Good Morning',
                  style:
                      GoogleFonts.lexendDeca(fontSize: 18, color: Colors.grey),
                ),
                const SizedBox(width: 2),
                Image.asset(
                  'assets/icons/menu/cloud.png',
                  height: 12,
                )
              ],
            ),
            Text('Michael Drogba', style: GoogleFonts.lexendDeca(fontSize: 18)),
          ],
        ),
        centerTitle: true,
        actions: [
          Container(
            padding: const EdgeInsets.all(5),
            height: 65,
            width: 55,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 81, 81, 81),
                borderRadius: BorderRadius.circular(100)),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Image.asset('assets/icons/menu/notification.png'),
            ),
          ),
        ],
      ),
    );
  }
}
