import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EventsProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final int _perPage = 10;
  DocumentSnapshot? _lastDocument;
  bool _isLoading = false;
  bool _hasMore = true;
  final List<DocumentSnapshot> _events = [];

  List<DocumentSnapshot> get events => _events;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;
  void removeEvent(String eventId) {
    _events.removeWhere((event) => event.id == eventId);
    notifyListeners(); // Notify listeners to update the UI
  }

  void updateEvent(
    String eventId,
    String eventName,
    String eventDescription,
    String eventLocation,
    DateTime eventStartDate,
    DateTime eventEndDate,
  ) {
    final eventIndex = _events.indexWhere((event) => event.id == eventId);
    if (eventIndex != -1) {
      _events[eventIndex].reference.update({
        'eventName': eventName,
        'eventDescription': eventDescription,
        'eventLocation': eventLocation,
        'eventStartDate': eventStartDate,
        'eventEndDate': eventEndDate,
      });
      notifyListeners();
    }
  }

  Future<void> fetchEvents() async {
    if (!_hasMore || _isLoading) {
      return;
    }

    _isLoading = true;
    notifyListeners();

    Query query = _firestore
        .collection('events')
        .orderBy('eventStartDate', descending: true)
        .limit(_perPage);

    if (_lastDocument != null) {
      query = query.startAfterDocument(_lastDocument!);
    }

    QuerySnapshot snapshot = await query.get();

    if (snapshot.docs.isNotEmpty) {
      _lastDocument = snapshot.docs.last;
      _events.addAll(snapshot.docs);
    } else {
      _hasMore = false;
    }

    _isLoading = false;
    notifyListeners();
  }

  void reset() {
    _events.clear(); // Clear the cached events
    _lastDocument = null; // Reset pagination
    _isLoading = false; // Reset loading state
    _hasMore = true; // Reset hasMore flag
    notifyListeners(); // Notify listeners to update the UI
  }
}
