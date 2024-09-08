import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:productivity_hub/components/widgets.dart';

class dashboard_page extends ConsumerWidget {
  const dashboard_page({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar:  PreferredSize(preferredSize: const Size.fromHeight(60), child: AppBar(leading: const Icon(Icons.menu), title: const Text('Logo'), centerTitle: true, forceMaterialTransparency: true,)),
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
        child: const Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                info_block(),
                info_block(),
              ],
            )
          ],
        ),
      ), 
    );
  }
}