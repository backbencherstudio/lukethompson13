import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lukethompson/core/extensions/snackbar_extension.dart';
import 'package:lukethompson/data/providers/stoplog_queries.dart';

import 'timeline_item.dart';

class TimelineSection extends ConsumerStatefulWidget {
  const TimelineSection({super.key});

  @override
  ConsumerState<TimelineSection> createState() => _TimelineSectionState();
}

class _TimelineSectionState extends ConsumerState<TimelineSection> {
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

  Future<void> _logArrivalTime() async {
    try {
      final res = await ref
          .read(recordStopLogMutation)
          .run(RecordStopLogParams(step: .arrivalTime));
      print("========================================");
      print(res);
      print("========================================");

      _getLocation().then((_) {
        setState(() {
          arrivalStatus = TimelineItemStatus.completed;
          dockInStatus = TimelineItemStatus.active;
        });
      });
    } catch (e) {
      if (mounted) {
        context.showErrorSnackBar(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final createLog = ref.watch(recordStopLogMutation);

    return Column(
      children: [
        TimelineItem(
          title: 'Arrival Time',
          status: arrivalStatus,
          controller: dockInController,
          onConfirm: _logArrivalTime,
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
