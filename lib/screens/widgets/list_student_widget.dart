import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:students_app/functions/db_functions.dart';
import 'package:students_app/screens/widgets/update.dart';

import '../../provider/provider_update.dart';

class ListStudentWidget extends StatelessWidget {
  const ListStudentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) =>
          Provider.of<ProviderClass>(context, listen: false).getAllStudents(),
    );
    return Consumer<ProviderClass>(builder: (context, value, child) {
      return value.studentListNotifier.isEmpty
          ? const Center(
              child: Text('No Student data..!'),
            )
          : ListView.separated(
              itemBuilder: (ctx, index) {
                final data = value.studentListNotifier[index];
                return Card(
                  color: Colors.green.shade300,
                  margin: const EdgeInsets.only(
                    right: 10,
                    left: 10,
                    top: 10,
                  ),
                  shadowColor: Colors.grey[50],
                  elevation: 10,
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DisplayDetail(
                            index: index,
                            model: data,
                          ),
                        ),
                      );
                    },
                    title: Text(
                      data.name,
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        letterSpacing: 1,
                      ),
                    ),
                    trailing: IconButton(
                        color: Colors.red.shade700,
                        onPressed: () {
                          showAlertDialog(context, index);
                        },
                        icon: const Icon(
                          Icons.delete_rounded,
                        )),
                  ),
                );
              },
              separatorBuilder: (ctx, index) {
                return const Divider();
              },
              itemCount: value.studentListNotifier.length,
            );
    });
  }

  showAlertDialog(BuildContext context, int index) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Continue"),
      onPressed: () {
        deleteStudent(context, index);
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Delete?"),
      content: const Text("Are you sure you wan't to delete"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
