import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:todo_app/helper/enum.dart';
import 'package:todo_app/views/add_todo.dart';
import 'package:todo_app/views/edit_todo.dart';

import '../helper/api_helper.dart';
import '../model/todo_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TodoModel? todoModel;
  ApiState state = ApiState.none;

  Future<void> fetchData() async {
    setState(() {
      state = ApiState.loading;
    });
    try {
      final todoData = await ApiHelper.getData(
        "https://api.nstack.in/v1/todos?page=1&limit=10",
      );
      setState(() {
        todoModel = TodoModel.fromMap(todoData);
        state = ApiState.success;
      });
    } catch (e) {
      setState(() {
        state = ApiState.error;
      });
    }
  }

  Future<void> deleteById(
      {required String id, required BuildContext context}) async {
    setState(() {
      state = ApiState.loading;
    });
    try {
      final response = await ApiHelper.deleteData(id);
      if (response.statusCode == 200) {
        setState(() {
          state = ApiState.success;
          todoModel!.items =
              todoModel!.items!.where((element) => element.id != id).toList();
        });
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
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo List"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                fetchData();
              });
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: state == ApiState.loading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.white70,
              ),
            )
          : state == ApiState.error
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Error Happened",
                        style: TextStyle(
                          color: Colors.white70,
                          fontStyle: FontStyle.normal,
                          fontSize: 30,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          //requestProvider.fetchData();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white70,
                          foregroundColor: Colors.black,
                        ),
                        child: const Text("try again"),
                      ),
                    ],
                  ),
                )
              : LiquidPullToRefresh(
                  onRefresh: fetchData,
                  showChildOpacityTransition: false,
                  child: Visibility(
                    visible: todoModel!.items!.isNotEmpty,
                    replacement: const Center(
                      child: Text(
                        "No Todo found",
                        style: TextStyle(
                          color: Colors.white70,
                          fontStyle: FontStyle.normal,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    child: ListView.builder(
                      itemCount: todoModel!.items!.length,
                      itemBuilder: (context, index) {
                        final id = todoModel!.items![index].id;
                        return Padding(
                          padding: const EdgeInsets.all(3),
                          child: Dismissible(
                            onDismissed: (direction) {
                              deleteById(
                                id: id!,
                                context: context,
                              ).whenComplete(() {
                                setState(() {});
                              });
                            },
                            key: UniqueKey(),
                            child: Card(
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.blueGrey,
                                  child: Text("${index + 1}"),
                                ),
                                title:
                                    Text("${todoModel!.items![index].title}"),
                                subtitle: Text(
                                    "${todoModel!.items![index].description}"),
                                trailing: PopupMenuButton(
                                  onSelected: (value) {
                                    if (value == 'edit') {
                                      Get.to(
                                        EditTodo(
                                          todo:
                                              todoModel!.items![index].toMap(),
                                        ),
                                        transition:
                                            Transition.rightToLeftWithFade,
                                      );
                                    } else if (value == 'delete') {
                                      deleteById(
                                        id: id!,
                                        context: context,
                                      ).whenComplete(() {
                                        setState(() {});
                                      });
                                    }
                                  },
                                  itemBuilder: (context) {
                                    return [
                                      const PopupMenuItem(
                                        value: 'edit',
                                        child: Text("Edit"),
                                      ),
                                      const PopupMenuItem(
                                        value: 'delete',
                                        child: Text("Delete"),
                                      ),
                                    ];
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(
            const AddTodo(),
            transition: Transition.rightToLeftWithFade,
          );
        },
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.black,
        tooltip: 'Add Todo',
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
