import 'package:flutter/material.dart';
import 'package:todo_app/Auth/login.dart';
import 'package:todo_app/Auth/register.dart';

class AuthScreen extends StatelessWidget {
  static const String routeName="Auth";
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Login"),
          bottom: TabBar(
            indicatorColor: Colors.white,
            indicatorPadding: EdgeInsets.only(bottom: 4),

            tabs: [
            Tab(child:Text("Login"),),
            Tab(child:Text("Register"),),
      
          ],),
        ),
        body: TabBarView(
          children: [
            LoginTab(),
            RegisterTab()
          ],
        ),
      
      ),
    );
  }
}
