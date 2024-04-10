import 'package:flutter/material.dart';
import 'package:todo_app/firebase/firebase_function.dart';
import 'package:todo_app/home.dart';

class RegisterTab extends StatelessWidget {
  RegisterTab({super.key});

  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var userNameController = TextEditingController();
  var passwordController = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: formkey,
        child: Column(
          children: [
            SizedBox(
              height: 12,
            ),
            TextFormField(
              controller: userNameController,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Username required";
                }
                return null;
              },
              decoration: InputDecoration(
                label: Text("User Name"),
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
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "email required";
                }
                bool emailValid = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.com+")
                    .hasMatch(value);
                if (!emailValid) {
                  return "please write email valid ex: xx@xx.com";
                }

                return null;
              },
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
              controller: phoneController,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "phone required";
                }
                return null;
              },
              decoration: InputDecoration(
                label: Text("Phone"),
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "password required";
                }
                if (value.length < 8) {
                  return "password should be at least 8 charcter";
                }
                return null;
              },
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
                  if (formkey.currentState!.validate()) {
                    FirebaseFunction.createUserAccount(
                      email: emailController.text,
                      password: passwordController.text,
                      phone: phoneController.text,
                      username: userNameController.text,
                      onSuccess: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, HomeScreen.routeName, (route) => false);
                      },
                      onError: (errorMessage) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Error"),
                              content: Text(errorMessage),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    }, child: Text("Cancel ")),

                              ],
                            );
                          },
                        );
                      },
                    );
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: Text(
                  "Register",
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
