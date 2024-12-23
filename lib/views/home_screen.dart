import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messenger_ui/views/chat_details.dart';
import 'package:messenger_ui/views/story_details.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map> stories = [
      {
        'name': 'Mohamed',
        'image': 'assets/photo1.png',
      },
      {
        'name': 'Elbaiomy',
        'image': 'assets/photo2.jpg',
      },
      {
        'name': 'Ahmed',
        'image': 'assets/photo3.jpg',
      },
      {
        'name': 'Mohamed',
        'image': 'assets/photo1.png',
      },
      {
        'name': 'Elbaiomy',
        'image': 'assets/photo2.jpg',
      },
      {
        'name': 'Ahmed',
        'image': 'assets/photo3.jpg',
      },
      {
        'name': 'Mohamed',
        'image': 'assets/photo1.png',
      },
      {
        'name': 'Elbaiomy',
        'image': 'assets/photo2.jpg',
      },
      {
        'name': 'Ahmed',
        'image': 'assets/photo3.jpg',
      },
      {
        'name': 'Mohamed',
        'image': 'assets/photo1.png',
      },
      {
        'name': 'Elbaiomy',
        'image': 'assets/photo2.jpg',
      },
      {
        'name': 'Ahmed',
        'image': 'assets/photo3.jpg',
      },
      {
        'name': 'Mohamed',
        'image': 'assets/photo1.png',
      },
      {
        'name': 'Elbaiomy',
        'image': 'assets/photo2.jpg',
      },
      {
        'name': 'Ahmed',
        'image': 'assets/photo3.jpg',
      },
      {
        'name': 'Mohamed',
        'image': 'assets/photo1.png',
      },
      {
        'name': 'Elbaiomy',
        'image': 'assets/photo2.jpg',
      },
      {
        'name': 'Ahmed',
        'image': 'assets/photo3.jpg',
      },
      {
        'name': 'Mohamed',
        'image': 'assets/photo1.png',
      },
      {
        'name': 'Elbaiomy',
        'image': 'assets/photo2.jpg',
      },
      {
        'name': 'Ahmed',
        'image': 'assets/photo3.jpg',
      },
    ];

    List<Map> chats = [
      {
        'name': 'Mohamed',
        'image': 'assets/photo1.png',
        'message': 'Hello',
        'date': '12/2024',
      },
      {
        'name': 'Ahmed',
        'image': 'assets/photo2.jpg',
        'message': 'How are you',
        'date': '8/2024',
      },
      {
        'name': 'Elbaiomy',
        'image': 'assets/photo3.jpg',
        'message': 'Are you well ?',
        'date': '3/2024',
      },
      {
        'name': 'Mohamed',
        'image': 'assets/photo1.png',
        'message': 'Hello',
        'date': '12/2024',
      },
      {
        'name': 'Ahmed',
        'image': 'assets/photo2.jpg',
        'message': 'How are you',
        'date': '8/2024',
      },
      {
        'name': 'Elbaiomy',
        'image': 'assets/photo3.jpg',
        'message': 'Are you well ?',
        'date': '3/2024',
      },
      {
        'name': 'Mohamed',
        'image': 'assets/photo1.png',
        'message': 'Hello',
        'date': '12/2024',
      },
      {
        'name': 'Ahmed',
        'image': 'assets/photo2.jpg',
        'message': 'How are you',
        'date': '8/2024',
      },
      {
        'name': 'Elbaiomy',
        'image': 'assets/photo3.jpg',
        'message': 'Are you well ?',
        'date': '3/2024',
      },
      {
        'name': 'Mohamed',
        'image': 'assets/photo1.png',
        'message': 'Hello',
        'date': '12/2024',
      },
      {
        'name': 'Ahmed',
        'image': 'assets/photo2.jpg',
        'message': 'How are you',
        'date': '8/2024',
      },
      {
        'name': 'Elbaiomy',
        'image': 'assets/photo3.jpg',
        'message': 'Are you well ?',
        'date': '3/2024',
      },
      {
        'name': 'Mohamed',
        'image': 'assets/photo1.png',
        'message': 'Hello',
        'date': '12/2024',
      },
      {
        'name': 'Ahmed',
        'image': 'assets/photo2.jpg',
        'message': 'How are you',
        'date': '8/2024',
      },
      {
        'name': 'Elbaiomy',
        'image': 'assets/photo3.jpg',
        'message': 'Are you well ?',
        'date': '3/2024',
      },
      {
        'name': 'Mohamed',
        'image': 'assets/photo1.png',
        'message': 'Hello',
        'date': '12/2024',
      },
      {
        'name': 'Ahmed',
        'image': 'assets/photo2.jpg',
        'message': 'How are you',
        'date': '8/2024',
      },
      {
        'name': 'Elbaiomy',
        'image': 'assets/photo3.jpg',
        'message': 'Are you well ?',
        'date': '3/2024',
      },
      {
        'name': 'Mohamed',
        'image': 'assets/photo1.png',
        'message': 'Hello',
        'date': '12/2024',
      },
      {
        'name': 'Ahmed',
        'image': 'assets/photo2.jpg',
        'message': 'How are you',
        'date': '8/2024',
      },
      {
        'name': 'Elbaiomy',
        'image': 'assets/photo3.jpg',
        'message': 'Are you well ?',
        'date': '3/2024',
      },
      {
        'name': 'Mohamed',
        'image': 'assets/photo1.png',
        'message': 'Hello',
        'date': '12/2024',
      },
      {
        'name': 'Ahmed',
        'image': 'assets/photo2.jpg',
        'message': 'How are you',
        'date': '8/2024',
      },
      {
        'name': 'Elbaiomy',
        'image': 'assets/photo3.jpg',
        'message': 'Are you well ?',
        'date': '3/2024',
      },
      {
        'name': 'Mohamed',
        'image': 'assets/photo1.png',
        'message': 'Hello',
        'date': '12/2024',
      },
      {
        'name': 'Ahmed',
        'image': 'assets/photo2.jpg',
        'message': 'How are you',
        'date': '8/2024',
      },
      {
        'name': 'Elbaiomy',
        'image': 'assets/photo3.jpg',
        'message': 'Are you well ?',
        'date': '3/2024',
      },
    ];

    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        title: Text("Chats"),
        actions: [
          Icon(Icons.edit),
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 100,
            child: ListView.builder(
                padding: EdgeInsets.all(8),
                scrollDirection: Axis.horizontal,
                itemCount: stories.length,
                itemBuilder: (context, i) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(
                        StoryDetails(
                          image: stories[i]['image'],
                          name: stories[i]['name'],
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(7),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage(stories[i]['image']),
                          ),
                          Text(stories[i]['name']),
                        ],
                      ),
                    ),
                  );
                }),
          ),
          for (int i = 0; i < chats.length; i++)
            ListTile(
              onTap: () {
                Get.to(
                  ChatDetails(
                    name: chats[i]['name'],
                    image: chats[i]['image'],
                    message: chats[i]['message'],
                    date: chats[i]['date'],
                  ),
                );
              },
              leading: CircleAvatar(
                backgroundImage: AssetImage(chats[i]['image']),
              ),
              title: Text(chats[i]['name']),
              subtitle: Text(chats[i]['message']),
              trailing: Text(chats[i]['date']),
            ),
        ],
      ),
    );
  }
}
