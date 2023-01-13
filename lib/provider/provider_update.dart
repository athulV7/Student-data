import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:students_app/model/data_model.dart';

class ProviderClass with ChangeNotifier {
  List<StudentModel> studentListNotifier = [];
  late TextEditingController name;
  late TextEditingController age;
  late TextEditingController course;
  late TextEditingController mobile;

  Future<void> getAllStudents() async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    studentListNotifier.clear();
    studentListNotifier.addAll(studentDB.values);
    notifyListeners();
  }

  void textControllerUpdate(StudentModel model) {
    name = TextEditingController(text: model.name);
    age = TextEditingController(text: model.age);
    course = TextEditingController(text: model.course);
    mobile = TextEditingController(text: model.mobile);
    notifyListeners();
  }
}
