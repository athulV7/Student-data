import 'package:flutter/material.dart';
import 'package:students_app/screens/home/student_input.dart';

import '../widgets/list_student_widget.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: const Color.fromARGB(255, 255, 162, 1),
        title: const Text(
          'Student List',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1,
          ),
        ),
        actions: [
          IconButton(
            padding: const EdgeInsets.only(right: 20),
            iconSize: 30,
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: const SafeArea(
        child: ListStudentWidget(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 10, bottom: 18),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const StudentInput()),
            );
          },
          backgroundColor: Colors.green,
          child: const Icon(
            Icons.add_card_rounded,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
