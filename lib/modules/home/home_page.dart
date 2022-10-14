import 'package:flutter/material.dart';

import 'widget/home_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Todo List")),
      drawer:  HomeDrawer(),
      body: Container(),
    );
  }
}
