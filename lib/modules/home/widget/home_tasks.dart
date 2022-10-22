import 'package:flutter/material.dart';

import 'task.dart';

class HomeTasks extends StatelessWidget {
  const HomeTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Text("TASK\'S DE HOME"),
        Column(
          children: [
            Task(),
            Task(),
            Task(),
            Task(),
            Task(),
            Task(),
            Task(),
          ],
        ),
      ],
    );
  }
}
