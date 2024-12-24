import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glowy_borders/glowy_borders.dart';
import 'package:notes_app/sql_helper.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
        actions: [
          IconButton(
            onPressed: () {
              SqlHelper().deleteAllNotes().whenComplete(() {
                setState(() {});
              });
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          TextEditingController title = TextEditingController();
          TextEditingController content = TextEditingController();
          showCupertinoDialog(
              context: context,
              builder: (_) {
                return CupertinoAlertDialog(
                  title: Text("Insert Note"),
                  content: Material(
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: title,
                        ),
                        TextFormField(
                          controller: content,
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    CupertinoDialogAction(
                      child: Text("No"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    CupertinoDialogAction(
                      child: Text("Yes"),
                      onPressed: () {
                        SqlHelper()
                            .addNote(
                                Note(title: title.text, content: content.text))
                            .whenComplete(() {
                          setState(() {});
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              });
        },
        backgroundColor: Colors.red,
        child: Icon(Icons.add),
      ),
      body: FutureBuilder<List<Map>>(
          future: SqlHelper().loadData(),
          builder: (context, AsyncSnapshot<List<Map>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return FadeInRight(
                    animate: true,
                    child: Dismissible(
                      key: UniqueKey(),
                      onDismissed: (direction) {
                        SqlHelper()
                            .deleteNote(snapshot.data![index]['id'])
                            .whenComplete(() {
                          setState(() {});
                        });
                      },
                      child: AnimatedGradientBorder(
                        borderSize: 1,
                        gradientColors: [
                          Colors.black,
                          Colors.white,
                          Colors.red,
                          Colors.purple.shade50
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        child: Card(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Text(
                                            "${snapshot.data![index]['title']}")),
                                    Text(
                                        " ${snapshot.data![index]['content']}"),
                                  ],
                                ),
                                IconButton(
                                  onPressed: () {
                                    String title = '';
                                    String content = '';
                                    showCupertinoDialog(
                                        context: context,
                                        builder: (_) {
                                          return CupertinoAlertDialog(
                                            title: Text("Update Note"),
                                            content: Material(
                                              color: Colors.transparent,
                                              child: Column(
                                                children: [
                                                  TextFormField(
                                                    initialValue: snapshot
                                                        .data![index]['title'],
                                                    onChanged: (value) {
                                                      title = value;
                                                    },
                                                  ),
                                                  TextFormField(
                                                    initialValue:
                                                        snapshot.data![index]
                                                            ['content'],
                                                    onChanged: (value) {
                                                      content = value;
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                            actions: [
                                              CupertinoDialogAction(
                                                child: Text("No"),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              CupertinoDialogAction(
                                                child: Text("Yes"),
                                                onPressed: () {
                                                  SqlHelper()
                                                      .updateNote(Note(
                                                    title: title == '' ? snapshot.data![index]['title'] : title,
                                                    content: content == '' ? snapshot.data![index]['content'] : content,
                                                    id: snapshot.data![index]
                                                        ['id'],
                                                  ))
                                                      .whenComplete(() {
                                                    setState(() {});
                                                  });
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  icon: Icon(Icons.edit),
                                ),
                                Text(
                                  "$index",
                                  style: TextStyle(fontSize: 40),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
