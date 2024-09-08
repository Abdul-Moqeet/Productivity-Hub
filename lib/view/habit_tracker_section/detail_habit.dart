import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:productivity_hub/models/habit_tracker/habits_model.dart';
import 'package:productivity_hub/models/habit_tracker/icons_list.dart';
import 'package:productivity_hub/providers/habit_tracker/habit_tracker_provider.dart';
import 'package:productivity_hub/view/habit_tracker_section/habit_screen.dart';
import 'package:smooth_corner/smooth_corner.dart';

final currentHabitProvider = StateProvider<Habit?>((ref) => null);
final habitTitleProvider = StateProvider<String>((ref) => '');
final habitDescriptionProvider = StateProvider<String>((ref) => '');
final StartDate = StateProvider<DateTime>((ref) => DateTime.now());
final habitColor = StateProvider<Color>((ref) => Colors.white);

class DetailHabit extends ConsumerStatefulWidget {
  const DetailHabit({super.key, required this.habit});
  final Habit habit;

  @override
  _DetailHabitState createState() => _DetailHabitState();
}

class _DetailHabitState extends ConsumerState<DetailHabit> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _repetitionsController;
  late TextEditingController _timeOfDayController;
  late TextEditingController _repeatDaysController;
  TimeOfDay? _reminderTime;
  bool _isCompleted = false;
  Color? _textColor;

  

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.habit.name);
    _descriptionController = TextEditingController(text: widget.habit.description);
    _repetitionsController = TextEditingController(text: widget.habit.repetitions.toString());
    _timeOfDayController = TextEditingController(text: widget.habit.timeOfDay.join(', '));
    _repeatDaysController = TextEditingController(text: widget.habit.repeatDays.join(', '));
    _reminderTime = widget.habit.reminderTime;
    _isCompleted = widget.habit.isCompleted;
    _textColor = widget.habit.textColor;
    
    

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(habitTitleProvider.notifier).state = widget.habit.name;
      ref.read(currentHabitProvider.notifier).state = widget.habit;
      ref.read(StartDate.notifier).state = widget.habit.startDate ?? DateTime.now();
      ref.read(habitColor.notifier).state = widget.habit.color ?? Colors.white;
    });
  }

  void _saveHabit() {
   
    final updatedHabit = widget.habit.copyWith(
      name: ref.read(habitTitleProvider),
      description: _descriptionController.text,
      repetitions: int.parse(_repetitionsController.text),
      timeOfDay: _timeOfDayController.text.split(', '),
      reminderTime: _reminderTime,
      repeatDays: _repeatDaysController.text.split(', '),
      isCompleted: _isCompleted,
     color: ref.watch(habitColor),
      textColor: _textColor,
      startDate: ref.read(StartDate),
    );

    ref.read(habitProvider.notifier).updateHabit(updatedHabit);
    ref.read(currentHabitProvider.notifier).state = updatedHabit;

    ref.read(selectedHabitsProvider.notifier).addHabit(updatedHabit);

    Navigator.of(context).pushAndRemoveUntil(
  MaterialPageRoute(builder: (context) => const HabitListScreen()), 
  (Route<dynamic> route) => false
);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _reminderTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _reminderTime) {
      setState(() {
        _reminderTime = picked;
      });
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: ref.watch(StartDate) ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != ref.watch(StartDate)) {
      
        ref.watch(StartDate.notifier).state = picked;
      
    }
  }

  Future<void> _pickColor(bool isTextColor) async {

    // if (pickedColor != null) {
    //   setState(() {
    //     if (isTextColor) {
    //       _textColor = pickedColor;
    //     } else {
    //        = pickedColor;
    //     }
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    
    final startDate = ref.watch(StartDate);
    final color = ref.watch(habitColor);
    final formattedStartDate = DateFormat('dd MMM').format(startDate);
    return Scaffold(
     backgroundColor: const Color.fromARGB(255, 60, 60, 60),
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          //  decoration: const BoxDecoration(
          //       gradient: LinearGradient(
          //         colors: [
          //           Color.fromARGB(255, 19, 19, 19),
          //           Color.fromARGB(201, 10, 10, 10),
          //           Color.fromARGB(170, 6, 6, 6),
          //           Color.fromARGB(122, 10, 10, 10),
          //         ],
          //         // stops: [,  1],
          //         begin: Alignment.bottomCenter,
          //         end: Alignment.topCenter,
          //       ),
          //     ),
          child: Column(
            children: [
              
              Column(
                children: [
                 
                  SizedBox(
                    width: double.infinity,
                    height: 330,
                    
                    // color: Colors.pink,
                    child: SmoothCard(
                      margin: EdgeInsets.zero,
                      smoothness: 1,
                      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(35), bottomRight: Radius.circular(35)),
                      // color: const Color.fromARGB(255, 73, 73, 73),
                      child: Column(
                        children: [
                           const SizedBox(height: 60),
                           const Padding(
                             padding: EdgeInsets.only(left: 20.0, bottom: 10),
                             child: Align(
                              alignment: Alignment.centerLeft,
                              child: Icon(Icons.close_outlined, size: 35,)),
                           ),
                           const SizedBox(height: 5),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text('Create a Habit', style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w500, letterSpacing: 1.7,),))),
                            const SizedBox(height: 20),
                          // Align(
                          //   alignment: Alignment.centerLeft,
                          //   child: Padding(
                          //     padding: const EdgeInsets.only(left: 10.0, bottom: 3),
                          //     child: Text(
                          //       'Title',
                          //       style: GoogleFonts.lexendDeca(fontSize: 18),
                          //     ),
                          //   ),
                          // ),
                           Row(
                      children: [
                        Expanded(
                          child: Container(
                            
                            height: 35,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0, top: 0),
                              child: TextFormField(
                                controller: _titleController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Habit Name cannot be empty';
                                  }
                                  return null;
                                },
                                style: const TextStyle(fontSize: 23),
                                decoration: InputDecoration(
                                  // helperText:'Meeting at 7pm with James' ,
                                  hintText: 'Habit Title',
                                  hintStyle: GoogleFonts.inter(
                                    fontSize: 28
                                  ),
                                  border: InputBorder.none,
                                  
                                  labelStyle: GoogleFonts.lexendDeca(),
                                ),
                                onChanged: (value) {
                                  ref.read(habitTitleProvider.notifier).state = value;
                                },
                              ),
                            ),
                          ),
                        ),
                        
                        GestureDetector(
                          onTap: () => _pickColor(false),
                          child: SmoothContainer(
                            margin: const EdgeInsets.only(right: 10),
                            color: const Color.fromARGB(255, 31, 31, 31),
                            height: 50,
                            borderRadius: BorderRadius.circular(20),
                            padding: const EdgeInsets.all(11),
                            child: SmoothContainer(
                                              borderRadius: BorderRadius.circular(50),
                                              width: 30,
                                              height: 30,
                                              color: color,
                                            ),
                          ),
                        ),
                      ],
                                      ),
                                      const SizedBox(height: 10),
                                      Container(
                        width: size.width,
                        height: 70,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 0, right: 20),
                          child: TextFormField(
                            maxLines: 5,
                            controller: _descriptionController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Description cannot be empty';
                              }
                              return null;
                            },
                            style: GoogleFonts.inter(fontSize: 19),
                            decoration: InputDecoration(
                              hintText: 'Add habit details',
                              
                              hintStyle: const TextStyle(color: Colors.grey, fontSize: 19),
                              border: InputBorder.none,
                              labelStyle: GoogleFonts.lexendDeca(),
                            ),
                            onChanged: (value) {
                              ref.read(habitDescriptionProvider.notifier).state = value;
                            },
                          ),
                        ),
                      ),
                        ],
                      ),
                    ),
                  ),
                 
                  const SizedBox(height: 20),
                  
                  Text('Choose an icon', style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w500,),),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: iconList.length,
                      itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                        child: Icon(iconList[index], size: 40, ),
                      );
                    },),
                  ),
                  const SizedBox(height: 20),
                //   ListTile(
                //   title: Text('Start Date: ${formattedStartDate}'),
                //   trailing: const Icon(Icons.calendar_today),
                //   onTap: _pickDate,
                // ),
                  
                  
                 const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 0.0, bottom: 3),
                              child: Text(
                                'Due Date',
                                style: GoogleFonts.lexendDeca(fontSize: 16),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () => _pickDate(),
                            child: SizedBox(
                              width: 120,
                              child: ListTile(
                                
                                leading: Text(
                                  formattedStartDate,
                                  style: const TextStyle(fontSize: 15, color: Colors.grey),
                                ),
                                trailing: const Icon(Icons.calendar_month),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 0.0, bottom: 3),
                              child: Text(
                                'End Date',
                                style: GoogleFonts.lexendDeca(fontSize: 16),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () => _pickDate(),
                            child: SizedBox(
                              width: 120,
                              child: ListTile(
                                
                                leading: Text(
                                  formattedStartDate,
                                  style: const TextStyle(fontSize: 15, color: Colors.grey),
                                ),
                                trailing: const Icon(Icons.calendar_month),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              
              const SizedBox(height: 30),
              TextButton(
                
                // style: ButtonStyle(backgroundColor: WidgetStateColor.transparent),
                onPressed: _saveHabit,
                child: SmoothContainer(
                  height: 60,
                  width: size.width,
                  
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(255, 253, 99, 27),
                  smoothness: 1,
                  child: const Center(
                    child: Text(
                      'Create',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
