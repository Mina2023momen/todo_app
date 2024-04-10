import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/firebase/firebase_function.dart';
import 'package:todo_app/task_model.dart';

class EditTaskScreen extends StatefulWidget {
  static const String routeName = "edit";

  const EditTaskScreen({super.key});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  @override
  Widget build(BuildContext context) {
    var task = ModalRoute.of(context)!.settings.arguments as TaskModel;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("Edit Task"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Edit Task"),
                ),
                Spacer(),
                TextFormField(
                  initialValue: task.title,
                  onChanged: (value) {
                    task.title = value;
                  },
                  decoration: InputDecoration(
                    label: Text("Title"),
                  ),
                ),
                Spacer(),
                TextFormField(
                  initialValue: task.description,
                  onChanged: (value) {
                    task.description = value;
                  },
                  decoration: InputDecoration(
                    label: Text("Description"),
                  ),
                ),
                Spacer(),
                InkWell(
                    onTap: () async {
                     task.date=await selectDate(context,task.date??0);
                   setState(() {
                     
                   });
                    },
                    child: Text("Selected Date")),
                Text(DateFormat.yMd().format(DateUtils.dateOnly(
                    DateTime.fromMillisecondsSinceEpoch(task.date ?? 0)))),
                Spacer(),
                ElevatedButton(
                    onPressed: () async {
                      await FirebaseFunction.updateTask(task);
                      Navigator.pop(context);
                    },
                    child: Text("Save changes")),
                Spacer(
                  flex: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  selectDate(BuildContext context,int time) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.fromMillisecondsSinceEpoch(time),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 360)),
      selectableDayPredicate: (day) =>
          day != DateTime.now().add(Duration(days: 2)),


    );
    time=DateUtils.dateOnly(selectedDate!).millisecondsSinceEpoch;
    return time;
  }
}
