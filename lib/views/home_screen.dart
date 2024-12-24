import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:todo_api_provider/provider/request_provider.dart';
import 'package:todo_api_provider/views/add_todo.dart';
import 'package:todo_api_provider/views/edit_todo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RequestProvider>().fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RequestProvider>(
        builder: (context, requestProvider, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Todo List"),
          centerTitle: true,
        ),
        body: requestProvider.isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.white70,
                ),
              )
            : requestProvider.isError
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
                            requestProvider.fetchData();
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
                    onRefresh: requestProvider.fetchData,
                    showChildOpacityTransition: false,
                    child: Visibility(
                      visible: requestProvider.todoModel!.items!.isNotEmpty,
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
                        itemCount: requestProvider.todoModel!.items!.length,
                        itemBuilder: (context, index) {
                          final id =
                              requestProvider.todoModel!.items![index].id;
                          return Padding(
                            padding: const EdgeInsets.all(3),
                            child: Dismissible(
                              onDismissed: (direction) {
                                requestProvider.deleteById(
                                  id: id!,
                                  context: context,
                                );
                              },
                              key: UniqueKey(),
                              child: Card(
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.blueGrey,
                                    child: Text("${index + 1}"),
                                  ),
                                  title: Text(
                                      "${requestProvider.todoModel!.items![index].title}"),
                                  subtitle: Text(
                                      "${requestProvider.todoModel!.items![index].description}"),
                                  trailing: PopupMenuButton(
                                    onSelected: (value) {
                                      if (value == 'edit') {
                                        Get.to(
                                          EditTodo(
                                            todo: requestProvider
                                                .todoModel!.items![index]
                                                .toMap(),
                                          ),
                                          transition:
                                              Transition.rightToLeftWithFade,
                                        );
                                      } else if (value == 'delete') {
                                        requestProvider.deleteById(
                                          id: id!,
                                          context: context,
                                        );
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
    });
  }
}
