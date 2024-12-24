import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/helper/enum.dart';
import '../helper/api_helper.dart';
import '../provider/request_provider.dart';

class EditTodo extends StatefulWidget {
  final Map todo;
  const EditTodo({super.key, required this.todo});

  @override
  State<EditTodo> createState() => _EditTodoState();
}

class _EditTodoState extends State<EditTodo> {
  ApiState state = ApiState.none;
  Future<void> editById({
    required String id,
    required BuildContext context,
    required Map<String, dynamic> data,
  }) async {
    setState(() {
      state = ApiState.loading;
    });
    try {
      final response = await ApiHelper.putData(id, data);
      if (response.statusCode == 200) {
        setState(() {
          state = ApiState.success;
        });
        Flushbar(
          message: "Successfully Updated",
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
    String title = '';
    String description = '';
    final FocusNode focusNode1 = FocusNode();
    final FocusNode focusNode2 = FocusNode();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return GestureDetector(
      onTap: () {
        focusNode1.unfocus();
        focusNode2.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Update Todo"),
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
                  onChanged: (value) {
                    title = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'you must enter anything';
                    }
                    return null;
                  },
                  initialValue: widget.todo['title'],
                  decoration: const InputDecoration(
                    hintText: 'Title',
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  focusNode: focusNode2,
                  onChanged: (value) {
                    description = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'you must enter anything';
                    }
                    return null;
                  },
                  initialValue: widget.todo['description'],
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
                      editById(
                        context: context,
                        data: {
                          "title": title == '' ? widget.todo['title'] : title,
                          "description": description == ''
                              ? widget.todo['description']
                              : description,
                          "is_completed": false
                        },
                        id: widget.todo['_id'],
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
                      : const Text("Update"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
