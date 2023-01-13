import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:students_app/model/data_model.dart';
import 'package:students_app/provider/provider_update.dart';

// ignore: must_be_immutable
class DisplayDetail extends StatelessWidget {
  DisplayDetail({
    Key? key,
    required this.model,
    required this.index,
  }) : super(key: key);

  final StudentModel model;
  int index;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => Provider.of<ProviderClass>(context, listen: false)
          .textControllerUpdate(model),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          'Student Details',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 23,
            letterSpacing: 1,
          ),
        ),
      ),
      body: SafeArea(
          child: Consumer<ProviderClass>(
        builder: (context, values, child) => Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextFormField(
                  controller: values.name,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Name'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: values.age,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Age'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: values.course,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'course'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: values.mobile,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'mobile'),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    update(values, context);
                  },
                  icon: Icon(
                    Icons.archive_rounded,
                    color: Colors.green.shade600,
                  ),
                  label: const Text('Update'),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }

  Future<void> update(ProviderClass values, ctx) async {
    final names = values.name.text.trim();
    final ages = values.age.text.trim();
    final courses = values.course.text.trim();
    final mobiles = values.mobile.text.trim();

    final student =
        StudentModel(name: names, age: ages, course: courses, mobile: mobiles);
    updateStudent(index, student, ctx);

    ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
        backgroundColor: Colors.grey,
        content: Text('Your data Succsesfully updated ')));
    Navigator.of(ctx).pop();
  }
}

Future<void> updateStudent(int index, StudentModel model, context) async {
  final studentDb = await Hive.openBox<StudentModel>('student_db');
  await studentDb.putAt(index, model);
  WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => Provider.of<ProviderClass>(context).getAllStudents());
  // await getAllStudents();
}
