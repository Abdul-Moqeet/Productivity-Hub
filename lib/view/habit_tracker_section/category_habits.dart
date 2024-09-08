import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:productivity_hub/models/habit_tracker/habits_category_model.dart';
import 'package:productivity_hub/view/habit_tracker_section/select_habits.dart';
import 'package:smooth_corner/smooth_corner.dart';

class NewHabitScreen extends ConsumerWidget {
  const NewHabitScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitCategories = ref.watch(habitCategoriesProvider);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 60, 60, 60),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(62),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10.0,
            right: 10,
          ),
          child: AppBar(
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.all(4),
                height: 30,
                width: 10,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 81, 81, 81),
                    borderRadius: BorderRadius.circular(100)),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Image.asset('assets/icons/menu/back.png'),
                ),
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
                      style: GoogleFonts.lexendDeca(
                          fontSize: 18, color: Colors.grey),
                    ),
                    const SizedBox(width: 2),
                    Image.asset(
                      'assets/icons/menu/cloud.png',
                      height: 12,
                    )
                  ],
                ),
                Text('Michael Drogba',
                    style: GoogleFonts.lexendDeca(fontSize: 18)),
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
        ),
      ),
      body: ListView.builder(
        itemCount: habitCategories.length,
        itemBuilder: (context, index) {
          final category = habitCategories[index];
        return GestureDetector(
          onTap: () {
             Navigator.push(context, MaterialPageRoute(builder: (context)=> habit_selection(category: category.name,)));
          },
          child: Stack(
            children: [SmoothContainer(
              
              smoothness: 1,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5,),
              height: 100,
              width: size.width,
              
              child: SmoothCard(
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 20, right: 100),
                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(category.name, style: GoogleFonts.roboto(fontSize: 19, fontWeight: FontWeight.bold, letterSpacing: .5, height: 1),),
                       Text(category.description,)
                    ],
                  ),
                ),
              ),), 
              Positioned(right: -10, bottom: -5,child: Image.asset(category.image, height: 120, width: 130,),),
               ]
          ),
        );
      },)
              
           
       
    );
  }
}
