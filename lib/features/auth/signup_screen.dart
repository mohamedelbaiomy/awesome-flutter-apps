import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_example/core/constants/check_email.dart';
import 'package:firebase_example/core/widgets/flushbar.dart';
import 'package:firebase_example/features/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../core/repo/auth_repo.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool password = true;
  bool loading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusNode focusNode3 = FocusNode();

  clearFocusNode() {
    focusNode1.unfocus();
    focusNode2.unfocus();
    focusNode3.unfocus();
  }

  showFlushBarError(String data) {
    showError(context, data);
  }

  showFlushBarSuccess(String data) {
    showSuccess(context, data);
  }

  signUp() async {
    setState(() {
      loading = true;
    });
    clearFocusNode();

    if (formKey.currentState!.validate()) {
      try {
        await AuthRepo.signUpWithEmailAndPassword(
            emailController.text, passwordController.text);
        AuthRepo.sendEmailVerification();
        AuthRepo.updateUserName(nameController.text);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({
          'name': nameController.text,
          'email': emailController.text,
          'password': passwordController.text,
          'uid': FirebaseAuth.instance.currentUser!.uid,
        });

        formKey.currentState!.reset();

        showFlushBarSuccess("Successfully Sign up");
        await Future.delayed(const Duration(seconds: 2)).whenComplete(
          () => Get.offAll(
            const LoginScreen(),
            transition: Transition.fadeIn,
          ),
        );

        setState(() {
          loading = false;
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          setState(() {
            loading = false;
          });
          showFlushBarError('The password provided is too weak');
        } else if (e.code == 'email-already-in-use') {
          setState(() {
            loading = false;
          });
          showFlushBarError('The account already exists for that email');
        } else if (e.code == 'network-request-failed') {
          setState(() {
            loading = false;
          });
          showFlushBarError('make sure you are connected to internet');
        } else {
          setState(() {
            loading = false;
          });
          showFlushBarError(e.toString());
        }
      } catch (e) {
        setState(() {
          loading = false;
        });
        showFlushBarError(e.toString());
      }
    } else {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        clearFocusNode();
      },
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
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
                      "Sign up",
                      style: TextStyle(fontSize: 40),
                    ),
                    SizedBox(height: 30),
                    // TextField
                    TextFormField(
                      focusNode: focusNode1,
                      controller: nameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'you must enter your name';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        labelText: 'Username',
                        hintText: 'enter your username',
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
                    TextFormField(
                      focusNode: focusNode2,
                      controller: emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter your email ';
                        } else if (value.isValidEmail() == false) {
                          return 'invalid email';
                        } else if (value.isValidEmail() == true) {
                          return null;
                        }
                        return null;
                      },
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
                    TextFormField(
                      focusNode: focusNode3,
                      controller: passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter your password';
                        }
                        if (value.contains("-")) {
                          return "can't include -";
                        }
                        if (value.length < 5) {
                          return 'weak password';
                        }
                        return null;
                      },
                      obscureText: password,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.password),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              password = !password;
                            });
                          },
                          icon: Icon(Icons.visibility),
                        ),
                        labelText: 'Password',
                        hintText: 'enter your password',
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text("Already have an account? Login"),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: loading
                          ? null
                          : () {
                              signUp();
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
                          : Text("Signup"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Sql - Table - Colums - Rows - data

// Firestore - Collection - documents - Field
