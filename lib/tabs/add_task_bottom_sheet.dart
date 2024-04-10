import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/firebase/firebase_function.dart';
import 'package:todo_app/task_model.dart';

class AddTaskBottomSheet extends StatefulWidget {
  AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  DateTime choseenDate = DateTime.now();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Add New Task",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 26,
            ),
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                label: Text("Title"),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(
              height: 26,
            ),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(
                label: Text("Description"),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(
              height: 26,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Select Time",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            InkWell(
              onTap: () {
                selectDate(context);
              },
              child: Text(
                "${choseenDate.toString().substring(0, 10)}",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w100,
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    print("choseenDate");
                    TaskModel model = TaskModel(
                      title:titleController.text,
                      userId: FirebaseAuth.instance.currentUser!.uid,
                        date: DateUtils.dateOnly(choseenDate)
                            .millisecondsSinceEpoch,
                        description: descriptionController.text);


                    FirebaseFunction.addTask(model);
                    Navigator.pop(context);


                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: Text(
                    "Add Task",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        color: Colors.white),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: choseenDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 360)),
      selectableDayPredicate: (day) =>
          day != DateTime.now().add(Duration(days: 2)),
    );
    if (selectedDate != null) {
      choseenDate = selectedDate!;
      setState(() {});
    }
  }
}
