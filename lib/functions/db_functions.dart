import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:students_app/model/data_model.dart';
import 'package:students_app/provider/provider_update.dart';

Future<void> addStudent(StudentModel value) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  // ignore: no_leading_underscores_for_local_identifiers

  final id = await studentDB.add(value);
  value.id = id;
}

Future<void> deleteStudent(context, int index) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  await studentDB.deleteAt(index);
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) =>
      Provider.of<ProviderClass>(context, listen: false).getAllStudents());
}
