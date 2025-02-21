import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_example/features/auth/login_screen.dart';
import 'package:firebase_example/features/details/event_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart' as date;
import 'package:provider/provider.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import '../../../core/providers/id_provider.dart';
import '../../../core/providers/read_events_provider.dart';
import '../../../core/repo/auth_repo.dart';
import '../../../core/widgets/flushbar.dart';

class ReadEvents extends StatefulWidget {
  const ReadEvents({super.key});

  @override
  State<ReadEvents> createState() => _ReadEventsState();
}

class _ReadEventsState extends State<ReadEvents>
    with AutomaticKeepAliveClientMixin<ReadEvents> {
  bool shouldKeepAlive = true;

  @override
  bool get wantKeepAlive => shouldKeepAlive;

  final ScrollController _scrollController = ScrollController();

  showFlushBarError(String data) {
    showError(context, data);
  }

  showFlushBarSuccess(String data) {
    showSuccess(context, data);
  }

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<EventsProvider>(context, listen: false);
    provider.fetchEvents();

    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !Provider.of<EventsProvider>(context, listen: false).isLoading) {
      Provider.of<EventsProvider>(context, listen: false).fetchEvents();
    }
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  Future<void> _onRefresh(BuildContext context) async {
    final provider = context.read<EventsProvider>();
    provider.reset();
    await provider.fetchEvents();

    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final provider = Provider.of<EventsProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Read from Firebase"),
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.red,
            ),
            onPressed: () {
              showCupertinoDialog(
                context: context,
                builder: (_) {
                  return CupertinoAlertDialog(
                    title: Text("Log out"),
                    content: Text("Are you sure to log out ?"),
                    actions: [
                      CupertinoDialogAction(
                        child: Text("No"),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                      CupertinoDialogAction(
                        isDestructiveAction: true,
                        onPressed: () async {
                          await AuthRepo.logOut();
                          context.read<IdProvider>().clearCustomerId();
                          await Future.delayed(
                            const Duration(
                              microseconds: 50,
                            ),
                          ).whenComplete(
                            () {
                              Get.offAll(
                                const LoginScreen(),
                                transition: Transition.fadeIn,
                              );
                            },
                          );
                        },
                        child: Text("Yes"),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: provider.events.isEmpty && !provider.isLoading
          ? const Center(child: Text('No events found.'))
          : SmartRefresher(
              controller: _refreshController,
              onRefresh: () async => await _onRefresh(context),
              child: ListView.builder(
                controller: _scrollController,
                itemCount: provider.events.length + (provider.hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == provider.events.length) {
                    return SpinKitThreeBounce(
                      color: Colors.black,
                      size: 25,
                    );
                  }

                  final event =
                      provider.events[index].data() as Map<String, dynamic>;
                  return _buildEventItem(event);
                },
              ),
            ),
    );
  }

  Widget _buildEventItem(Map<String, dynamic> event) {
    return Consumer<EventsProvider>(builder: (context, provider, child) {
      return GestureDetector(
        onTap: () {
          Get.to(
            EventDetails(data: event),
            transition: Transition.fadeIn,
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          margin: EdgeInsets.all(5),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              spacing: 15,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      event['eventName'] ?? 'No Name',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    event['uid'] == FirebaseAuth.instance.currentUser!.uid
                        ? Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  showCupertinoDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (_) => CupertinoAlertDialog(
                                      title: Text("Delete Event"),
                                      content: Text(
                                          "Are you sure you want to delete this event ?"),
                                      actions: [
                                        CupertinoDialogAction(
                                          child: Text("No"),
                                          onPressed: () {
                                            Get.back();
                                          },
                                        ),
                                        CupertinoDialogAction(
                                          child: Text("Yes"),
                                          onPressed: () => _deleteEvent(
                                              context, event['eventId']),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                icon: Icon(Icons.delete),
                              ),
                              IconButton(
                                onPressed: () =>
                                    _openEditBottomSheet(context, event),
                                icon: Icon(Icons.edit),
                              ),
                            ],
                          )
                        : Text(""),
                  ],
                ),
                Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  height: MediaQuery.sizeOf(context).height * 0.07,
                  padding: EdgeInsets.only(
                    top: 7,
                    bottom: 7,
                    left: 10,
                    right: 10,
                  ),
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: CountdownTimer(
                    textStyle: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                    endWidget: Text(
                      "Time out",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        letterSpacing: 1,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onEnd: () async {
                      await FirebaseFirestore.instance.runTransaction(
                        (transaction) async {
                          DocumentReference documentReference =
                              FirebaseFirestore.instance
                                  .collection('events')
                                  .doc(
                                    event['eventId'],
                                  );
                          transaction.update(
                            documentReference,
                            {
                              'end': true,
                            },
                          );
                        },
                      );
                    },
                    endTime: DateTime.now().millisecondsSinceEpoch +
                        ((event['eventStartDate'] as Timestamp)
                                .toDate()
                                .difference(DateTime.now())
                                .inSeconds) *
                            1 *
                            1000,
                  ),
                ),
                Text('Location: ${event['eventLocation'] ?? 'No Location'}'),
              ],
            ),
          ),
        ),
      );
    });
  }

  bool loading = false;
  void _deleteEvent(BuildContext context, String eventId) async {
    final provider = Provider.of<EventsProvider>(context, listen: false);
    try {
      await FirebaseFirestore.instance
          .collection('events')
          .doc(eventId)
          .delete()
          .whenComplete(() {
        Get.back();
      });
      provider.removeEvent(eventId); // Remove the event from the cached list

      showFlushBarSuccess('Event deleted successfully');
    } catch (e) {
      showFlushBarError('Failed to delete event: $e');
    }
  }

  void _openEditBottomSheet(BuildContext context, Map<String, dynamic> event) {
    final provider = Provider.of<EventsProvider>(context, listen: false);
    final formKey = GlobalKey<FormState>();

    final eventNameController = TextEditingController(text: event['eventName']);
    final eventDescriptionController =
        TextEditingController(text: event['eventDescription']);
    final eventLocationController =
        TextEditingController(text: event['eventLocation']);
    DateTime eventStartDate = event['eventStartDate'].toDate();
    DateTime eventEndDate = event['eventEndDate'].toDate();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: eventNameController,
                    decoration: const InputDecoration(labelText: 'Event Name'),
                    validator: (value) {
                      if (value!.isEmpty) return 'Event name is required';
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: eventDescriptionController,
                    decoration:
                        const InputDecoration(labelText: 'Event Description'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Event description is required';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: eventLocationController,
                    decoration:
                        const InputDecoration(labelText: 'Event Location'),
                    validator: (value) {
                      if (value!.isEmpty) return 'Event location is required';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text('Start Date'),
                  SizedBox(
                    height: 100,
                    child: date.DatePicker(
                      DateTime.now(),
                      initialSelectedDate: eventStartDate,
                      selectionColor: Colors.black,
                      onDateChange: (date) {
                        eventStartDate = date;
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text('End Date'),
                  SizedBox(
                    height: 100,
                    child: date.DatePicker(
                      DateTime.now(),
                      initialSelectedDate: eventEndDate,
                      selectionColor: Colors.black,
                      onDateChange: (date) {
                        eventEndDate = date;
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: loading
                        ? null
                        : () async {
                            setState(() {
                              loading = true;
                            });
                            if (formKey.currentState!.validate()) {
                              try {
                                await FirebaseFirestore.instance
                                    .collection('events')
                                    .doc(event['eventId'])
                                    .update({
                                  'eventName': eventNameController.text,
                                  'eventDescription':
                                      eventDescriptionController.text,
                                  'eventLocation': eventLocationController.text,
                                  'eventStartDate': eventStartDate,
                                  'eventEndDate': eventEndDate,
                                });
                                provider.updateEvent(
                                  event['eventId'],
                                  eventNameController.text,
                                  eventDescriptionController.text,
                                  eventLocationController.text,
                                  eventStartDate,
                                  eventEndDate,
                                );
                                Get.back(); // Close the bottom sheet
                                showFlushBarSuccess(
                                    'Event updated successfully');
                                setState(() {
                                  loading = false;
                                });
                              } catch (e) {
                                setState(() {
                                  loading = false;
                                });
                                showFlushBarError('Failed to update event: $e');
                              }
                            } else {
                              setState(() {
                                loading = false;
                              });
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      backgroundColor: Colors.black,
                      disabledForegroundColor: Colors.black,
                      disabledBackgroundColor: Colors.grey,
                      foregroundColor: Colors.white,
                    ),
                    child: loading
                        ? SpinKitThreeBounce(
                            color: Colors.white,
                          )
                        : const Text('Update Event'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
