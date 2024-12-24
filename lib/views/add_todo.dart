import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/helper/enum.dart';

import '../helper/api_helper.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FocusNode focusNode1 = FocusNode();
  final FocusNode focusNode2 = FocusNode();

  ApiState state = ApiState.none;

  Future<void> submitData({
    required BuildContext context,
  }) async {
    setState(() {
      state = ApiState.loading;
    });
    try {
      final response = await ApiHelper.postData(
        "https://api.nstack.in/v1/todos",
        {
          "title": titleController.text,
          "description": descriptionController.text,
          "is_completed": false,
        },
        // options: Options(
        //   contentType: 'application/json',
        // ),
      );
      if (response.statusCode == 201) {
        titleController.clear();
        descriptionController.clear();
        setState(() {
          state = ApiState.success;
        });
        Flushbar(
          message: "Successfully added",
          icon: const Icon(
            Icons.check_circle,
            size: 28,
            color: Colors.green,
          ),
          duration: const Duration(seconds: 3),
          leftBarIndicatorColor: Colors.green,
          borderRadius: BorderRadius.circular(20),
          isDismissible: true,
        ).show(context);
      } else {
        setState(() {
          state = ApiState.error;
        });
        Flushbar(
          message: "error happened",
          icon: const Icon(
            Icons.error,
            size: 28,
            color: Colors.red,
          ),
          duration: const Duration(seconds: 3),
          leftBarIndicatorColor: Colors.red,
          borderRadius: BorderRadius.circular(20),
          isDismissible: true,
        ).show(context);
      }
    } catch (e) {
      setState(() {
        state = ApiState.error;
      });
      Flushbar(
        message: "error happened",
        icon: const Icon(
          Icons.error,
          size: 28,
          color: Colors.red,
        ),
        duration: const Duration(seconds: 3),
        leftBarIndicatorColor: Colors.red,
        borderRadius: BorderRadius.circular(20),
        isDismissible: true,
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        focusNode1.unfocus();
        focusNode2.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add Todo"),
          centerTitle: true,
        ),
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: ListView(
              children: [
                TextFormField(
                  focusNode: focusNode1,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'you must enter anything';
                    }
                    return null;
                  },
                  controller: titleController,
                  decoration: const InputDecoration(
                    hintText: 'Title',
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  focusNode: focusNode2,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'you must enter anything';
                    }
                    return null;
                  },
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    hintText: 'Description',
                  ),
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    focusNode1.unfocus();
                    focusNode2.unfocus();
                    if (formKey.currentState!.validate()) {
                      submitData(
                        context: context,
                      );
                    } else {
                      Flushbar(
                        message: "you must enter anything",
                        icon: const Icon(
                          Icons.error,
                          size: 28,
                          color: Colors.red,
                        ),
                        duration: const Duration(seconds: 3),
                        leftBarIndicatorColor: Colors.red,
                        borderRadius: BorderRadius.circular(20),
                        isDismissible: true,
                      ).show(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.white12,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: state == ApiState.loading
                      ? const CircularProgressIndicator(color: Colors.white70)
                      : const Text("Submit"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
