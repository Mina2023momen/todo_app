import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Auth/auth.dart';
import 'package:todo_app/firebase/firebase_function.dart';
import 'package:todo_app/provider/my_provider.dart';
import 'package:todo_app/tabs/add_task_bottom_sheet.dart';
import 'package:todo_app/tabs/settings_tab.dart';
import 'package:todo_app/tabs/tasks_tabs.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home";

  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<MyProvider>(context);
    return Scaffold(
      extendBody: true,
      backgroundColor: Color(0xFFDFECDB),
      appBar: AppBar(
        title: Center(
          child: Text(
            "ToDo ${provider.userModel?.username}",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(onPressed: () {
          FirebaseFunction.logOut();
          Navigator.pushNamedAndRemoveUntil(context, AuthScreen.routeName,
                  (route) => false);
          }, icon: Icon(Icons.logout))
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return Container(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: AddTaskBottomSheet());
            },
          );
        },
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(color: Colors.white, width: 3)),
        child: Icon(
          Icons.add,

          color: Colors.white,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          onTap: (value) {
            index = value;
            setState(() {});
          },
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey.shade300,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          backgroundColor: Colors.white,
          iconSize: 30,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.task,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                ),
                label: ""),
          ]),
      body: tabs[index],
    );
  }

  List<Widget> tabs = [TasksTab(), SettingsTab()];
}
