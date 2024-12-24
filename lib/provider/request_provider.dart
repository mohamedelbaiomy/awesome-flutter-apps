import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import '../helper/api_helper.dart';
import '../model/todo_model.dart';

class RequestProvider with ChangeNotifier {
  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  TodoModel? todoModel;
  bool isLoading = true;
  bool isError = false;

  Future<void> fetchData() async {
    try {
      isLoading = true;
      isError = false;
      notifyListeners();
      final todoData = await ApiHelper.getData(
        "https://api.nstack.in/v1/todos?page=1&limit=10",
      );
      todoModel = TodoModel.fromMap(todoData);
      isLoading = false;
      isError = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      isError = true;
      notifyListeners();
    }
  }

  Future<void> submitData({
    required BuildContext context,
  }) async {
    isLoading = true;
    isError = false;
    notifyListeners();
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
        isLoading = false;
        isError = false;
        notifyListeners();
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
        isLoading = false;
        isError = true;
        notifyListeners();
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
      isLoading = false;
      isError = true;
      notifyListeners();
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

  Future<void> deleteById(
      {required String id, required BuildContext context}) async {
    isLoading = true;
    isError = false;
    notifyListeners();
    try {
      final response = await ApiHelper.deleteData(id);
      if (response.statusCode == 200) {
        isLoading = false;
        isError = false;
        todoModel!.items =
            todoModel!.items!.where((element) => element.id != id).toList();
        Flushbar(
          message: "Successfully deleted",
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
        notifyListeners();
      } else {
        isLoading = false;
        isError = true;
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
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      isError = true;
      notifyListeners();
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

  Future<void> editById({
    required String id,
    required BuildContext context,
    required Map<String, dynamic> data,
  }) async {
    isLoading = true;
    isError = false;
    notifyListeners();
    try {
      final response = await ApiHelper.putData(id, data);
      if (response.statusCode == 200) {
        isLoading = false;
        isError = false;
        notifyListeners();
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
        isLoading = false;
        isError = true;
        notifyListeners();
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
      isLoading = false;
      isError = true;
      notifyListeners();
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
}
