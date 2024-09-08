import 'package:flutter/material.dart';

class info_block extends StatelessWidget {
  const info_block({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: SizedBox(
          height: 140,
          child: Card(child: Column(),),
        ),
      ),
    );
  }
}