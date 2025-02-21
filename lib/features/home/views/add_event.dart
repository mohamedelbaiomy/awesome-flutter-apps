import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart' as date;
import '../../../core/providers/add_event_provider.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent>
    with AutomaticKeepAliveClientMixin<AddEvent> {
  bool shouldKeepAlive = true;

  @override
  bool get wantKeepAlive => shouldKeepAlive;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final provider = Provider.of<AddEventProvider>(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add Event"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: provider.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  TextFormField(
                    controller: provider.eventNameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'You must enter an event name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(width: 2),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      hintText: 'Event Name',
                    ),
                  ),
                  TextFormField(
                    controller: provider.eventDescriptionController,
                    maxLines: 3,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'You must enter an event description';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(width: 2),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      hintText: 'Event Description',
                    ),
                  ),
                  TextFormField(
                    controller: provider.eventLocationNameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'You must enter an event location';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(width: 2),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      hintText: 'Event Location',
                    ),
                  ),
                  const Text(
                    "Start Date",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    child: date.DatePicker(
                      DateTime.now(),
                      selectionColor: Colors.black,
                      onDateChange: provider.updateStartDate,
                    ),
                  ),
                  const Text(
                    "End Date",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    child: date.DatePicker(
                      DateTime.now(),
                      selectionColor: Colors.black,
                      onDateChange: provider.updateEndDate,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: provider.loading
                        ? null
                        : () => provider.publishEvent(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Colors.grey,
                      disabledForegroundColor: Colors.black,
                      minimumSize: const Size(double.infinity, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: provider.loading
                        ? const SpinKitThreeBounce(
                            color: Colors.white,
                            size: 18,
                          )
                        : const Text("Publish Event"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
