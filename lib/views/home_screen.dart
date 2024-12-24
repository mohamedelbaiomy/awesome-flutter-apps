import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glowy_borders/glowy_borders.dart';
import 'package:provider/provider.dart';

import '../logic/notes_todo_provider.dart';
import '../logic/sqlhelper.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes & Todo"),
        actions: [
          IconButton(
            onPressed: () {
              context.read<DatabaseProvider>().deleteAllNotes();
              context.read<DatabaseProvider>().deleteAllTodos();
            },
            icon: const Icon(Icons.delete_forever),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Notes",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: Consumer<DatabaseProvider>(
                  builder: (context, provider, child) {
                return FutureBuilder(
                  future: context.read<DatabaseProvider>().loadNotes(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Map>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return FadeInRight(
                            animate: true,
                            child: Dismissible(
                              key: UniqueKey(),
                              onDismissed: (direction) => context
                                  .read<DatabaseProvider>()
                                  .deleteNote(snapshot.data![index]['id']),
                              child: AnimatedGradientBorder(
                                borderSize: 1,
                                gradientColors: [
                                  Colors.black,
                                  Colors.white,
                                  Colors.red,
                                  Colors.purple.shade50
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                child: Card(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          spacing: 5,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Text(
                                                snapshot.data![index]['title'],
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                            SingleChildScrollView(
                                              child: Text(
                                                snapshot.data![index]
                                                    ['content'],
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            String newTitle = '';
                                            String newContent = '';
                                            showCupertinoDialog<void>(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  Material(
                                                color: Colors.transparent,
                                                child: CupertinoAlertDialog(
                                                  title:
                                                      const Text('Edit  Note'),
                                                  content: Column(
                                                    children: [
                                                      TextFormField(
                                                        initialValue: snapshot
                                                                .data![index]
                                                            ['title'],
                                                        onChanged: (value) {
                                                          newTitle = value;
                                                        },
                                                      ),
                                                      TextFormField(
                                                        initialValue: snapshot
                                                                .data![index]
                                                            ['content'],
                                                        onChanged: (value) {
                                                          newContent = value;
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                  actions: <CupertinoDialogAction>[
                                                    CupertinoDialogAction(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text('No'),
                                                    ),
                                                    CupertinoDialogAction(
                                                      isDestructiveAction: true,
                                                      onPressed: () {
                                                        context
                                                            .read<
                                                                DatabaseProvider>()
                                                            .updateNote(
                                                              Note(
                                                                id: snapshot
                                                                        .data![
                                                                    index]['id'],
                                                                title: newTitle ==
                                                                        ''
                                                                    ? snapshot.data![
                                                                            index]
                                                                        [
                                                                        'title']
                                                                    : newTitle,
                                                                content: newContent ==
                                                                        ''
                                                                    ? snapshot.data![
                                                                            index]
                                                                        [
                                                                        'content']
                                                                    : newContent,
                                                              ),
                                                            );

                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text('Yes'),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                          icon:
                                              const Icon(Icons.edit, size: 30),
                                        ),
                                        Text(
                                          snapshot.data![index]['id']
                                              .toString(),
                                          style: const TextStyle(
                                            fontSize: 50,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );
              }),
            ),
            const Text(
              "To do",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: Consumer<DatabaseProvider>(
                  builder: (context, provider, child) {
                return FutureBuilder(
                  future: SQLHelper().loadTodos(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Map>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            bool isDone = snapshot.data![index]['value'] == 0
                                ? false
                                : true;
                            return FadeInLeft(
                              animate: true,
                              child: Card(
                                color:
                                    isDone == false ? Colors.red : Colors.green,
                                child: GestureDetector(
                                  onTap: () {
                                    context
                                        .read<DatabaseProvider>()
                                        .updateTodoChecked(
                                          snapshot.data![index]['id'],
                                          snapshot.data![index]['value'],
                                        );
                                  },
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        activeColor: Colors.red,
                                        value: isDone,
                                        onChanged: null,
                                      ),
                                      Text(
                                        snapshot.data![index]['title'],
                                        style: TextStyle(
                                          color: isDone == false
                                              ? Colors.black
                                              : Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.redAccent,
            onPressed: () {
              TextEditingController titleController = TextEditingController();

              TextEditingController contentController = TextEditingController();
              showCupertinoDialog<void>(
                context: context,
                builder: (BuildContext context) => Material(
                  color: Colors.transparent,
                  child: CupertinoAlertDialog(
                    title: const Text('Add New Note'),
                    content: Column(
                      children: [
                        TextField(
                          controller: titleController,
                        ),
                        TextField(
                          controller: contentController,
                        ),
                      ],
                    ),
                    actions: <CupertinoDialogAction>[
                      CupertinoDialogAction(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('No'),
                      ),
                      CupertinoDialogAction(
                        isDestructiveAction: true,
                        onPressed: () {
                          context
                              .read<DatabaseProvider>()
                              .insertNote(
                                Note(
                                  title: titleController.text,
                                  content: contentController.text,
                                ),
                              )
                              .whenComplete(() {
                            titleController.clear();
                            contentController.clear();
                          });
                          Navigator.pop(context);
                        },
                        child: const Text('Yes'),
                      ),
                    ],
                  ),
                ),
              );
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: FloatingActionButton(
              backgroundColor: Colors.black,
              onPressed: () {
                TextEditingController titleController = TextEditingController();

                showCupertinoDialog<void>(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) => Material(
                    color: Colors.transparent,
                    child: CupertinoAlertDialog(
                      title: const Text('Add New Todo'),
                      content: TextField(
                        controller: titleController,
                      ),
                      actions: <CupertinoDialogAction>[
                        CupertinoDialogAction(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('No'),
                        ),
                        CupertinoDialogAction(
                          isDestructiveAction: true,
                          onPressed: () {
                            context
                                .read<DatabaseProvider>()
                                .insertTodo(
                                  Todo(
                                    title: titleController.text,
                                  ),
                                )
                                .whenComplete(() {
                              titleController.clear();
                            });
                            Navigator.pop(context);
                          },
                          child: const Text('Yes'),
                        )
                      ],
                    ),
                  ),
                );
              },
              tooltip: 'Increment',
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
