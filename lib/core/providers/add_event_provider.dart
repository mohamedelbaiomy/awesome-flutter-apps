import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_example/core/widgets/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AddEventProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController eventNameController = TextEditingController();
  final TextEditingController eventDescriptionController =
      TextEditingController();
  final TextEditingController eventLocationNameController =
      TextEditingController();

  DateTime eventStartDate = DateTime.now();
  DateTime eventEndDate = DateTime.now();
  bool loading = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> publishEvent(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      showError(context, 'Please fill all fields correctly.');
      return;
    }

    if (eventStartDate.isAfter(eventEndDate)) {
      showError(context, 'Start date must be before end date.');
      return;
    }

    setLoading(true);

    try {
      final eventId = const Uuid().v4();
      await _firestore.collection('events').doc(eventId).set({
        'eventName': eventNameController.text,
        'eventDescription': eventDescriptionController.text,
        'eventLocation': eventLocationNameController.text,
        'eventStartDate': eventStartDate,
        'eventEndDate': eventEndDate,
        'eventId': eventId,
        'uid': _auth.currentUser!.uid,
        'end': false,
      });

      showSuccess(context, 'Event uploaded successfully.');
      clearForm();
    } catch (e) {
      showError(context, e.toString());
    } finally {
      setLoading(false);
    }
  }

  void updateStartDate(DateTime date) {
    eventStartDate = date;
    notifyListeners();
  }

  void updateEndDate(DateTime date) {
    eventEndDate = date;
    notifyListeners();
  }

  void clearForm() {
    eventNameController.clear();
    eventDescriptionController.clear();
    eventLocationNameController.clear();
    eventStartDate = DateTime.now();
    eventEndDate = DateTime.now();
    notifyListeners();
  }

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }
}
