import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_example/core/constants/check_email.dart';
import 'package:firebase_example/core/widgets/flushbar.dart';
import 'package:firebase_example/features/auth/signup_screen.dart';
import 'package:firebase_example/features/home/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import '../../core/repo/auth_repo.dart';
import '../../core/providers/id_provider.dart';
import 'forget_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool password = true;
  bool loading = false;
  bool docExists = false;

  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();

  clearFocusNode() {
    focusNode1.unfocus();
    focusNode2.unfocus();
  }

  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<bool> checkIfDocExists(String docId) async {
    try {
      var doc = await users.doc(docId).get();
      return doc.exists;
    } catch (e) {
      return false;
    }
  }

  signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        showFlushBarError("Google Sign-In was canceled");
      }
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential user =
          await FirebaseAuth.instance.signInWithCredential(credential);
      docExists = await checkIfDocExists(user.user!.uid);
      if (docExists == false) {
        await users.doc(user.user!.uid).set({
          'uid': user.user!.uid,
          'name': user.user!.displayName,
          'email': user.user!.email,
          'password': '',
        }).whenComplete(
          () {
            User user = FirebaseAuth.instance.currentUser!;
            setUserId(user);
            Get.offAll(
              BottomNavigationScreen(),
              curve: Curves.easeInOut,
              transition: Transition.fadeIn,
            );
          },
        );
      } else {
        User user = FirebaseAuth.instance.currentUser!;
        setUserId(user);
        Get.offAll(
          BottomNavigationScreen(),
          curve: Curves.easeInOut,
          transition: Transition.fadeIn,
        );
      }
    } catch (e) {
      showFlushBarError(e.toString());
    }
  }

  setUserId(User user) {
    context.read<IdProvider>().setCustomerId(user);
  }

  showFlushBarError(String data) {
    showError(context, data);
  }

  showFlushBarSuccess(String data) {
    showSuccess(context, data);
  }

  void login() async {
    setState(() {
      loading = true;
    });

    Future.delayed(const Duration(milliseconds: 500), () async {
      if (formKey.currentState!.validate()) {
        try {
          await AuthRepo.signInWithEmailAndPassword(
            emailController.text,
            passwordController.text,
          );
          await AuthRepo.reloadUserData();

          if (await AuthRepo.checkEmailVerification()) {
            setState(() {
              loading = false;
            });
            formKey.currentState!.reset();
            User user = FirebaseAuth.instance.currentUser!;
            setUserId(user);

            Get.offAll(
              BottomNavigationScreen(),
              transition: Transition.fadeIn,
            );
          } else {
            setState(() {
              loading = false;
            });
            showFlushBarError("Check your email first");
          }
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            setState(() {
              loading = false;
            });
            showFlushBarError('password or email is incorrect');
          } else if (e.code == 'wrong-password') {
            setState(() {
              loading = false;
            });
            showFlushBarError('password is incorrect');
          } else if (e.code == 'invalid-credential') {
            setState(() {
              loading = false;
            });
            showFlushBarError('password or email is incorrect');
          } else if (e.code == 'network-request-failed') {
            setState(() {
              loading = false;
            });
            showFlushBarError('make sure you are connected to internet');
          } else {
            setState(() {
              loading = false;
            });
            showFlushBarError('error occurred, try again');
          }
        } catch (e) {
          setState(() {
            loading = false;
          });
          showFlushBarError(e.toString());
        }
      }
    });
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
                      "Login",
                      style: TextStyle(fontSize: 40),
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      focusNode: focusNode1,
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
                    TextFormField(
                      focusNode: focusNode2,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'you must enter your password';
                        }
                        return null;
                      },
                      controller: passwordController,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Get.to(
                              ForgetPassword(),
                              transition: Transition.fadeIn,
                              duration: Duration(milliseconds: 500),
                            );
                          },
                          child: Text("Forget Password"),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(
                              SignupScreen(),
                              transition: Transition.fadeIn,
                              duration: Duration(milliseconds: 500),
                            );
                          },
                          child: Text("Don't have an account? Sign up"),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: loading
                          ? null
                          : () {
                              login();
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
                          : Text("Login"),
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Or Continue with"),
                        IconButton(
                          onPressed: () {
                            signInWithGoogle();
                          },
                          icon: Icon(FontAwesomeIcons.google),
                        ),
                      ],
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

//
