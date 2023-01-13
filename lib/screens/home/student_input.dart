import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:students_app/functions/db_functions.dart';

import '../../provider/provider_update.dart';
import '../widgets/add_student_widget.dart';

class StudentInput extends StatelessWidget {
  const StudentInput({super.key});

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback(
    //   (timeStamp) =>
    //       Provider.of<ProviderClass>(context, listen: false).getAllStudents(),
    // );
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          AddStudentWidget(),
        ],
      )),
    );
  }
}
