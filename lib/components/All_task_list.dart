import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:productivity_hub/providers/to_do_provider.dart';

class AllTaskList extends ConsumerWidget {
  const AllTaskList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(todoListProvider);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 500,
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return SizedBox(
                  height: 100,
                  width: size.width,
                  
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(width: 40,),
                        Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(task.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),),
                          const SizedBox(height: 5,),
                          Text(task.description, style: const TextStyle(fontSize: 15, color: Colors.black),)
                        ],
                      ),
                      const Icon(Icons.done)
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}