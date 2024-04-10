import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/firebase/firebase_function.dart';
import 'package:todo_app/tabs/task_item.dart';
import 'package:todo_app/task_model.dart';

class TasksTab extends StatefulWidget {
   TasksTab({super.key});

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
DateTime selectedDate=DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DatePicker(
          DateTime.now(),
          initialSelectedDate: selectedDate,
          selectionColor: Colors.blue,
          selectedTextColor: Colors.white,
          height: 90,
          locale: "en",
          deactivatedColor: Colors.blue,
          onDateChange: (date) {
            selectedDate=date;
            setState(() {

            });

          },
        ),
        Expanded(
          child:StreamBuilder<QuerySnapshot<TaskModel>>(
            stream: FirebaseFunction.getTasks(selectedDate),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Column(
                  children: [
                    Text("Something went wrong"),
                    ElevatedButton(onPressed: () {}, child: Text("Try Again"))
                  ],
                );
              }
              var tasks =
                  snapshot.data?.docs.map((e) => e.data()).toList() ?? [];
              if (tasks.isEmpty) {
                return Center(child: Text("No Tasks"));
              }
              return ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  height: 12,
                ),
                itemBuilder: (context, index) {
                  return TaskItem(
                    tasksModel: tasks[index],
                  );
                },
                itemCount: tasks.length,
              );
            },
          ),
        )
      ],
    );
  }
}
