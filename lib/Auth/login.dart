import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/firebase/firebase_function.dart';
import 'package:todo_app/home.dart';
import 'package:todo_app/provider/my_provider.dart';

class LoginTab extends StatelessWidget {
  LoginTab({super.key});

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(
            height: 12,
          ),
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              label: Text("Email"),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          TextFormField(
            controller: passwordController,
            obscureText: true,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              label: Text("Password"),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                FirebaseFunction.login(
                    emailController.text, passwordController.text, () {
                  provider.initUser();
                  Navigator.pushNamedAndRemoveUntil(
                      context, HomeScreen.routeName, (route) => false);
                }, (error) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Error"),
                        content: Text(error),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              }, child: Text("Cancel ")),

                        ],
                      );
                    },
                  );
                });
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: Text(
                "Login",
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
