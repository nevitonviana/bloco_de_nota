import 'package:flutter/material.dart';

import '/core/ui/theme_extensions.dart';

class CalendarButton extends StatelessWidget {
  const CalendarButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.today_outlined),
          const SizedBox(
            width: 10,
          ),
          Text(
            "SELECIONE UMA DATA",
            style: context.titleStyle,
          ),
        ],
      ),
    );
  }
}
