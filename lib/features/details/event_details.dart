import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:intl/intl.dart';

class EventDetails extends StatelessWidget {
  final Map<String, dynamic> data;
  const EventDetails({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Event Details"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                data['eventName'],
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                data['eventDescription'],
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                  'Ends At: ${DateFormat('dd MMMM yyyy').format(data['eventEndDate'].toDate()).toString()}'),
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
                          FirebaseFirestore.instance.collection('events').doc(
                                data['eventId'],
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
                    ((data['eventStartDate'] as Timestamp)
                            .toDate()
                            .difference(DateTime.now())
                            .inSeconds) *
                        1 *
                        1000,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
