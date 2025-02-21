import 'package:firebase_example/features/home/views/add_event.dart';
import 'package:firebase_example/features/home/views/read_events.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/providers/screen_index_provider.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen>
    with AutomaticKeepAliveClientMixin<BottomNavigationScreen> {
  bool shouldKeepAlive = true;

  @override
  bool get wantKeepAlive => shouldKeepAlive;
  List<Widget> pages = [
    ReadEvents(),
    AddEvent(),
  ];

  late PageController pageController;
  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<ScreenIndexProvider>(
        builder: (context, screenIndexProvider, child) {
      return Scaffold(
        body: PageView(
          controller: pageController,
          padEnds: true,
          onPageChanged: (value) =>
              screenIndexProvider.updateScreenIndex(value),
          children: pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: screenIndexProvider.currentIndex,
          onTap: (index) {
            screenIndexProvider.updateScreenIndex(index);
            setState(() {
              pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'View Events',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle),
              label: 'Add Event',
            ),
          ],
        ),
      );
    });
  }
}
