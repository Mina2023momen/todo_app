import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/firebase/firebase_function.dart';
import 'package:todo_app/tabs/edit_task.dart';
import 'package:todo_app/task_model.dart';

class TaskItem extends StatefulWidget {
  TaskModel tasksModel;

  TaskItem({required this.tasksModel, super.key});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(18)),
      child: Slidable(
        startActionPane: ActionPane(
          motion: DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                FirebaseFunction.deleteTask(widget.tasksModel.id ?? "");
              },
              backgroundColor: Colors.red,
              autoClose: true,
              icon: Icons.delete,
              label: "Delete",
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            SlidableAction(
              onPressed: (context) {
                Navigator.pushNamed(context, EditTaskScreen.routeName,arguments:widget.tasksModel );
              },
              backgroundColor: Colors.blue,
              autoClose: true,
              icon: Icons.edit,
              label: "Edit",
            )
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                height: 80,
                width: 8,
                decoration: BoxDecoration(
                  color: widget.tasksModel.isDone! ? Colors.green : Colors.blue,
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.tasksModel.title ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 25),
                    ),
                    Text(
                      widget.tasksModel.description ?? "",
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 12,
              ),
              InkWell(
                onTap: () {
                  widget.tasksModel.isDone = ! widget.tasksModel.isDone!;
                  FirebaseFunction.updateTask(widget.tasksModel);
                  setState(() {

                  });
                },
                child:widget.tasksModel.isDone!?Text("Done!",style: TextStyle(
                  color: Colors.green,fontSize: 25,fontWeight: FontWeight.bold,
                ),): Container(
                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color:  Colors.blue,
                  ),
                  child: Icon(
                    Icons.done,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
