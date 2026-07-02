import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'timeline_item.dart';

class TimelineSection extends StatefulWidget {
  const TimelineSection({super.key});

  @override
  State<TimelineSection> createState() => _TimelineSectionState();
}

class _TimelineSectionState extends State<TimelineSection> {
  var arrivalStatus = TimelineItemStatus.active;
  var dockInStatus = TimelineItemStatus.idle;
  var completedStatus = TimelineItemStatus.idle;
  var departureStatus = TimelineItemStatus.idle;

  static const String _initialDockInTime = '08:15 AM';
  static const String _initialCompletedTime = '12:45 AM';
  static const String _initialDepartureTime = '01:00 PM';

  final TextEditingController dockInController = TextEditingController(
    text: _initialDockInTime,
  );
  final TextEditingController completedController = TextEditingController(
    text: _initialCompletedTime,
  );
  final TextEditingController departureController = TextEditingController(
    text: _initialDepartureTime,
  );

  @override
  void dispose() {
    dockInController.dispose();
    completedController.dispose();
    departureController.dispose();
    super.dispose();
  }

  Future<void> _getLocation() async {
    try {
      final permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        await Geolocator.requestPermission();
      }
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );
      debugPrint('Location: $position');
    } catch (e) {
      debugPrint('Error getting location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TimelineItem(
          title: 'Arrival Time',
          status: arrivalStatus,
          controller: dockInController,
          onConfirm: () {
            _getLocation().then((_) {
              setState(() {
                arrivalStatus = TimelineItemStatus.completed;
                dockInStatus = TimelineItemStatus.active;
              });
            });
          },
          onChanged: (value) {
            setState(() {
              // no edited flag needed internally
            });
          },
        ),
        TimelineItem(
          title: 'Dock In Time',
          status: dockInStatus,
          controller: dockInController,
          onChanged: (_) {},
          onConfirm: () {
            _getLocation().then((_) {
              setState(() {
                dockInStatus = TimelineItemStatus.completed;
                completedStatus = TimelineItemStatus.active;
              });
            });
          },
        ),
        TimelineItem(
          title: 'Completed Time',
          status: completedStatus,
          controller: completedController,
          onChanged: (_) {},
          onConfirm: () {
            _getLocation().then((_) {
              setState(() {
                completedStatus = TimelineItemStatus.completed;
                departureStatus = TimelineItemStatus.active;
              });
            });
          },
        ),
        TimelineItem(
          title: 'Departure Time',
          status: departureStatus,
          controller: departureController,
          isLastStep: true,
          onChanged: (_) {},
          onConfirm: () {
            _getLocation().then((_) {
              setState(() {
                departureStatus = TimelineItemStatus.completed;
              });
            });
          },
        ),
      ],
    );
  }
}
