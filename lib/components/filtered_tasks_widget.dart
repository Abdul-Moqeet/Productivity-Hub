import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:productivity_hub/providers/filtered_tasks_provider.dart';
import 'package:productivity_hub/providers/to_do_provider.dart';
import 'package:smooth_corner/smooth_corner.dart';

class tasks_widget extends ConsumerWidget {
  const tasks_widget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    // final tasks = ref.watch(todoListProvider);
    final filteredList = ref.watch(filteredTasksProvider);
    return SizedBox(
      height: 200,
      child: ListView.builder(
        itemCount: filteredList.length,
        itemBuilder: (context, index) {
          final task = filteredList[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 5),
            height: 100,
            width: size.width,
            child: SmoothCard(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              smoothness: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // const SizedBox(width: 40,),
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            task.title,
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            task.description,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 15, color: Colors.black),
                          )
                        ],
                      ),
                    ),
                    // const Icon(Icons.done)
                    MSHCheckbox(
                      value: task.isCompleted,
                      onChanged: (bool? value) {
                        ref
                            .read(todoListProvider.notifier)
                            .toggleTaskCompletion(task.title);
                      },
                      colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                          checkedColor: Colors.black,
                          // disabledColor: Colors.black,
                          uncheckedColor: Colors.black),
                      size: 20,
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
