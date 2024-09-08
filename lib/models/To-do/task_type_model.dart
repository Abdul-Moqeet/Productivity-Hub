import 'package:flutter/material.dart';

class task_type_model {
  final String type;
  final String image;
  final IconData icon;
  

  task_type_model({required this.type, required this.image, required this.icon});
}

List<task_type_model> task_type_list = [
  task_type_model(type: 'Work', image: 'assets/icons/task_category/work.png', icon: Icons.work),
  task_type_model(type: 'Grocery', image: 'assets/icons/task_category/grocery.png', icon: Icons.store),
  task_type_model(type: 'Sport', image: 'assets/icons/task_category/sport.png', icon: Icons.sports),
  task_type_model(type: 'Design', image: 'assets/icons/task_category/design.png', icon: Icons.design_services),
  task_type_model(type: 'Study', image: 'assets/icons/task_category/study.png', icon: Icons.book),
  task_type_model(type: 'Social', image: 'assets/icons/task_category/social.png', icon: Icons.speaker),
  task_type_model(type: 'Music', image: 'assets/icons/task_category/music.png', icon: Icons.music_note),
  task_type_model(type: 'Health', image: 'assets/icons/task_category/health.png', icon: Icons.heat_pump_sharp),
  task_type_model(type: 'Home', image: 'assets/icons/task_category/home.png', icon: Icons.home),
];
