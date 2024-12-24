import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_api_provider/provider/request_provider.dart';

class AddTodo extends StatelessWidget {
  const AddTodo({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final FocusNode focusNode1 = FocusNode();
    final FocusNode focusNode2 = FocusNode();
    return Consumer<RequestProvider>(
        builder: (context, requestProvider, child) {
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
                    controller: requestProvider.titleController,
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
                    controller: requestProvider.descriptionController,
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
                        requestProvider.submitData(
                          context: context,
                        );
                        context.read<RequestProvider>().fetchData();
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
                    child: requestProvider.isLoading == true
                        ? const CircularProgressIndicator(color: Colors.white70)
                        : const Text("Submit"),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
