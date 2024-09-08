import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:productivity_hub/models/To-do/task_type_model.dart';
import 'package:productivity_hub/models/To-do/Tasks_model.dart';
import 'package:productivity_hub/providers/to_do_provider.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:smooth_corner/smooth_corner.dart';

final selectedTaskTypeProvider = StateProvider<task_type_model?>((ref) => null);
final titleProvider = StateProvider<String>((ref) => '');
final descriptionProvider = StateProvider<String>((ref) => '');
final dueDateProvider = StateProvider<DateTime>((ref) => DateTime.now());
final endDateProvider = StateProvider<DateTime>((ref) => DateTime.now());
final priorityProvider = StateProvider<String>((ref) => 'Low');

class NewTask extends ConsumerStatefulWidget {
  const NewTask({super.key});

  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends ConsumerState<NewTask> {
  final formKey = GlobalKey<FormState>();
  final DateFormat dateFormat = DateFormat('d MMM');

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Set initial provider values here
      ref.read(titleProvider.notifier).state = '';
      ref.read(descriptionProvider.notifier).state = '';
      ref.read(dueDateProvider.notifier).state = DateTime.now();
      ref.read(endDateProvider.notifier).state = DateTime.now();
      ref.read(selectedTaskTypeProvider.notifier).state = null;
    });
  
  }

  @override
  void dispose() {
   ref.read(titleProvider.notifier).state = '';
  ref.read(descriptionProvider.notifier).state = '';

  // Clear the date providers
  ref.read(dueDateProvider.notifier).state = DateTime.now();
  ref.read(endDateProvider.notifier).state = DateTime.now();

  // Clear the selected task type provider
  ref.read(selectedTaskTypeProvider.notifier).state = null;

  // Dispose text controllers
  _titleController.dispose();
  _descriptionController.dispose();

  super.dispose();

  }

  Future<void> _selectDueDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: ref.read(dueDateProvider),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            primaryColor: const Color(0xFF5F33E1),
            colorScheme: const ColorScheme.dark(primary: Color.fromARGB(255, 197, 131, 255)),
            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.accent),
            dialogBackgroundColor: Colors.black,
            textTheme: GoogleFonts.lexendDecaTextTheme(
              ThemeData.dark().textTheme.apply(bodyColor: Colors.white, displayColor: Colors.white),
            ),
            inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != ref.read(dueDateProvider)) {
      ref.read(dueDateProvider.notifier).state = picked;
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: ref.read(endDateProvider),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            primaryColor: const Color(0xFF5F33E1),
            colorScheme: const ColorScheme.dark(primary: Color.fromARGB(255, 197, 131, 255)),
            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.accent),
            dialogBackgroundColor: Colors.black,
            textTheme: GoogleFonts.lexendDecaTextTheme(
              ThemeData.dark().textTheme.apply(bodyColor: Colors.white, displayColor: Colors.white),
            ),
            inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != ref.read(endDateProvider)) {
      ref.read(endDateProvider.notifier).state = picked;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final selectedTask = ref.watch(selectedTaskTypeProvider);
    final title = ref.watch(titleProvider);
    final description = ref.watch(descriptionProvider);
    final dueDate = ref.watch(dueDateProvider);
    final endDate = ref.watch(endDateProvider);

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const Text('Add Task'),
        centerTitle: true,
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          child: IconButton(
            onPressed: () =>
            Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
           decoration: const BoxDecoration(
                // gradient: LinearGradient(
                //   colors: [
                //     Color.fromARGB(255, 19, 19, 19),
                //     Color.fromARGB(201, 10, 10, 10),
                //     Color.fromARGB(170, 6, 6, 6),
                //     Color.fromARGB(122, 10, 10, 10),
                //   ],
                //   // stops: [,  1],
                //   begin: Alignment.bottomCenter,
                //   end: Alignment.topCenter,
                // ),
              ),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, bottom: 3),
                        child: Text(
                          'Title',
                          style: GoogleFonts.lexendDeca(fontSize: 18),
                        ),
                      ),
                    ),
                    Container(
                      width: size.width,
                      height: 70,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: TextFormField(
                            controller: _titleController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Project Name cannot be empty';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              // helperText:'Meeting at 7pm with James' ,
                              hintText: 'Meeting at 7pm with James',
                              border: InputBorder.none,
                              
                              labelStyle: GoogleFonts.lexendDeca(),
                            ),
                            onChanged: (value) {
                              ref.read(titleProvider.notifier).state = value;
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0, bottom: 3),
                            child: Text(
                              'Description',
                              style: GoogleFonts.lexendDeca(fontSize: 18),
                            ),
                          ),
                        ),
                        Container(
                          width: size.width,
                          height: 150,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: TextFormField(
                                maxLines: 5,
                                controller: _descriptionController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Description cannot be empty';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: 'Plan the upcoming marketing strategy, review recent social media performance, set campaign goals, and discuss new content ideas.',
                                  border: InputBorder.none,
                                  labelStyle: GoogleFonts.lexendDeca(),
                                ),
                                onChanged: (value) {
                                  ref.read(descriptionProvider.notifier).state = value;
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
                              onPressed: () => _selectDueDate(context),
                              child: SizedBox(
                                width: 120,
                                child: ListTile(
                                  leading: Text(
                                    dateFormat.format(dueDate),
                                    style: const TextStyle(fontSize: 15, color: Colors.grey),
                                  ),
                                  trailing: const Icon(Icons.calendar_month),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Column(
                        //   children: [
                        //     Align(
                        //       alignment: Alignment.centerLeft,
                        //       child: Padding(
                        //         padding: const EdgeInsets.only(left: 0.0, bottom: 3),
                        //         child: Text(
                        //           'End Date',
                        //           style: GoogleFonts.lexendDeca(fontSize: 16),
                        //         ),
                        //       ),
                        //     ),
                        //     ElevatedButton(
                        //       onPressed: () => _selectEndDate(context),
                        //       child: SizedBox(
                        //         width: 120,
                        //         child: ListTile(
                        //           leading: Text(
                        //             dateFormat.format(endDate),
                        //             style: const TextStyle(fontSize: 15, color: Colors.grey),
                        //           ),
                        //           trailing: const Icon(Icons.calendar_month),
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: size.width,
                height: 100,
                child: PullDownButton(
                  routeTheme: PullDownMenuRouteTheme(
                    width: size.width - 70,
                  ),
                  itemBuilder: (BuildContext context) {
                    return List.generate(task_type_list.length, (index) {
                      task_type_model taskType = task_type_list[index];
                      return PullDownMenuItem(
                        iconWidget: Icon(taskType.icon),
                        title: taskType.type,
                        onTap: () {
                          ref.read(selectedTaskTypeProvider.notifier).state = taskType;
                        },
                        icon: taskType.icon,
                      );
                    });
                  },
                  buttonBuilder: (BuildContext context, Future<void> Function() showButtonMenu) {
                    return GestureDetector(
                      onTap: showButtonMenu,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0, bottom: 3),
                                child: Text(
                                  'WorkSpace',
                                  style: GoogleFonts.lexendDeca(fontSize: 18),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 70,
                              width: size.width,
                              child: Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                                child: Row(
                                  children: [
                                    const SizedBox(width: 20),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                        selectedTask?.image ?? 'assets/icons/task_category/work.png',
                                        height: 30,
                                        width: 30,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text('Task Group', style: TextStyle(fontSize: 12)),
                                        Text(
                                          selectedTask?.type ?? 'Select Workspace',
                                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const Expanded(child: SizedBox()),
                                    const Icon(Icons.arrow_downward_outlined),
                                    const SizedBox(width: 20),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 30),
              TextButton(
                
                // style: ButtonStyle(backgroundColor: WidgetStateColor.transparent),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    final newTask = Task(
                      endDate: endDate,
                      task_type: selectedTask?.type,
                      title: title,
                      description: description,
                      dueDate: dueDate,
                      priority: ref.read(priorityProvider),
                    );
                    ref.read(todoListProvider.notifier).addTask(newTask);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Task added successfully!')),
                    );
                    if (mounted) {
                      Navigator.pop(context);
                    }
                  }
                },
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
