import 'package:firebase_example/core/widgets/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../core/repo/auth_repo.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  bool password = true;

  bool loading = false;

  FocusNode focusNode1 = FocusNode();

  TextEditingController emailController = TextEditingController();

  sendResetPassword() async {
    setState(() {
      loading = true;
    });
    focusNode1.unfocus();

    try {
      AuthRepo.sendPasswordResetEmail(
        emailController.text.trim(),
        context,
      );
      setState(() {
        loading = false;
      });

      showSuccess(context, 'Check your email');
    } catch (e) {
      setState(() {
        loading = false;
      });
      showError(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        focusNode1.unfocus();
      },
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image(
                      height: 200,
                      width: 200,
                      image: AssetImage("assets/login.gif"),
                    ),
                  ),
                  Text(
                    "Forget Password",
                    style: TextStyle(fontSize: 40),
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    focusNode: focusNode1,
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      labelText: 'Email Address',
                      hintText: 'enter your email',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          width: 2,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: loading
                        ? null
                        : () {
                            sendResetPassword();
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: loading == true
                        ? SpinKitThreeBounce(
                            color: Colors.black,
                          )
                        : Text("Send email verification"),
                  ),
                  SizedBox(height: 50),
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text("Back to Login"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//
