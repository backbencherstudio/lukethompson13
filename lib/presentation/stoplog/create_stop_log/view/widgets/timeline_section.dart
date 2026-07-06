import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lukethompson/core/extensions/snackbar_extension.dart';
import 'package:lukethompson/core/utils/error.dart';
import 'package:lukethompson/data/models/models.dart';
import 'package:lukethompson/data/providers/stoplog_queries.dart';
import 'package:lukethompson/data/sources/local/gps_service.dart';

import 'attachment_upload_section.dart';
import 'timeline_item.dart';

class TimelineSection extends ConsumerStatefulWidget {
  const TimelineSection({
    super.key,
    this.session,
    required this.onSingleLogComplete,
  });

  final SingleStoplogData? session;
  final void Function(StopLogStep step) onSingleLogComplete;

  @override
  ConsumerState<TimelineSection> createState() => _TimelineSectionState();
}

class _TimelineSectionState extends ConsumerState<TimelineSection> {
  var arrivalStatus = TimelineItemStatus.idle;
  var dockInStatus = TimelineItemStatus.idle;
  var completedStatus = TimelineItemStatus.idle;
  var departureStatus = TimelineItemStatus.idle;
  var attachmentsStatus = TimelineItemStatus.idle;

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
  void initState() {
    super.initState();
    _updateStatuses();
  }

  @override
  void didUpdateWidget(TimelineSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.session != widget.session) {
      _updateStatuses();
    }
  }

  void _updateStatuses() {
    final s = widget.session;
    if (s == null) {
      setState(() {
        arrivalStatus = .active;
        // arrivalStatus = .completed;
        // dockInStatus = .completed;
        // completedStatus = .completed;
        // departureStatus = .active;
        // attachmentsStatus = .active;
      });
      return;
    }

    setState(() {
      switch (s.currentStep) {
        case StopLogStep.arrivalTime:
          arrivalStatus = .completed;
          dockInStatus = .active;
        case StopLogStep.dockInTime:
          arrivalStatus = .completed;
          dockInStatus = .completed;
          completedStatus = .active;
        case StopLogStep.completedTime:
          arrivalStatus = .completed;
          dockInStatus = .completed;
          completedStatus = .completed;
          departureStatus = .active;
        case StopLogStep.departureTime:
          arrivalStatus = .completed;
          dockInStatus = .completed;
          completedStatus = .completed;
          departureStatus = .completed;
          attachmentsStatus = .active;
        case StopLogStep.uploadDocuments:
          arrivalStatus = .completed;
          dockInStatus = .completed;
          completedStatus = .completed;
          departureStatus = .completed;
          attachmentsStatus = .completed;
        case null:
          print("currentStep is null");
      }
    });
  }

  @override
  void dispose() {
    dockInController.dispose();
    completedController.dispose();
    departureController.dispose();
    super.dispose();
  }

  Future<void> _logArrivalTime() async {
    final activeSessionId = widget.session?.id;
    if (activeSessionId != null) return;

    final position = await GpsService.getCurrentLocation();
    if (position == null) return;

    final params = RecordStopLogParams(
      step: .arrivalTime,
      facilityName: "Test facility",
      location: StopLogLocation(
        city: 'Dhaka',
        state: 'Dhaka Division',
        country: 'BD',
        address: 'Warehouse A, Williamsburg Bridge',
        zip: '10001',
        lat: 40.7128,
        lng: -74.006,
      ),
    );
    final res = await ref
        .read(recordStopLogProviderAction.notifier)
        .record(params);

    if (!res.success && mounted) {
      context.showErrorSnackBar(res.message);
      return;
    }

    setState(() {
      arrivalStatus = TimelineItemStatus.completed;
      dockInStatus = TimelineItemStatus.active;
    });

    if (mounted) {
      context.showSuccessSnackBar("Arrival Time logged successfully");
      widget.onSingleLogComplete(.arrivalTime);
      _refetchSession();
    }
  }

  Future<void> _logDockedInTime() async {
    final activeSessionId = widget.session?.id;
    if (activeSessionId == null) return;

    final position = await GpsService.getCurrentLocation();
    if (position == null) return;

    final params = RecordStopLogParams(
      id: activeSessionId,
      step: .dockInTime,
      location: StopLogLocation(
        city: 'Dhaka',
        state: 'Dhaka Division',
        country: 'BD',
        address: 'Warehouse A, Williamsburg Bridge',
        zip: '10001',
        lat: position.latitude,
        lng: position.longitude,
      ),
    );
    final res = await ref
        .read(recordStopLogProviderAction.notifier)
        .record(params);

    if (!res.success && mounted) {
      context.showErrorSnackBar(res.message);
      return;
    }

    setState(() {
      dockInStatus = TimelineItemStatus.completed;
      completedStatus = TimelineItemStatus.active;
    });
    if (mounted) {
      context.showSuccessSnackBar("Dock In Time logged successfully");
      widget.onSingleLogComplete(.dockInTime);
      _refetchSession();
    }
  }

  Future<void> _logCompletedTime() async {
    final activeSessionId = widget.session?.id;
    if (activeSessionId == null) return;

    final position = await GpsService.getCurrentLocation();
    if (position == null) return;

    final params = RecordStopLogParams(
      id: activeSessionId,
      step: .completedTime,
      location: StopLogLocation(
        city: 'Dhaka',
        state: 'Dhaka Division',
        country: 'BD',
        address: 'Warehouse A, Williamsburg Bridge',
        zip: '10001',
        lat: position.latitude,
        lng: position.longitude,
      ),
    );
    final res = await ref
        .read(recordStopLogProviderAction.notifier)
        .record(params);

    if (!res.success && mounted) {
      context.showErrorSnackBar(res.message);
      return;
    }

    setState(() {
      completedStatus = TimelineItemStatus.completed;
      departureStatus = TimelineItemStatus.active;
    });
    if (mounted) {
      context.showSuccessSnackBar("Completed Time logged successfully");
      widget.onSingleLogComplete(.completedTime);
      _refetchSession();
    }
  }

  Future<void> _logDepartureTime() async {
    final activeSessionId = widget.session?.id;
    if (activeSessionId == null) return;

    final position = await GpsService.getCurrentLocation();
    if (position == null) return;

    final params = RecordStopLogParams(
      id: activeSessionId,
      step: .departureTime,
      location: StopLogLocation(
        city: 'Dhaka',
        state: 'Dhaka Division',
        country: 'BD',
        address: 'Warehouse A, Williamsburg Bridge',
        zip: '10001',
        lat: position.latitude,
        lng: position.longitude,
      ),
    );
    final res = await ref
        .read(recordStopLogProviderAction.notifier)
        .record(params);

    if (!res.success && mounted) {
      context.showErrorSnackBar(res.message);
      return;
    }

    setState(() {
      departureStatus = TimelineItemStatus.completed;
    });
    if (mounted) {
      context.showSuccessSnackBar("Departure Time logged successfully");
      widget.onSingleLogComplete(.departureTime);
      _refetchSession();
    }
  }

  bool _isActionPending(StopLogStep? step, bool isPending) {
    return isPending && widget.session?.currentStep == step;
  }

  void _refetchSession() {
    ref.invalidate(getCurrentActiveStoplog);
    ref.invalidate(getSingleLogWithId);
  }

  Future<void> _onAttachmentPicked(XFile file) async {
    final multipartFile = MultipartFile.fromFileSync(
      file.path,
      filename: file.name,
    );

    final params = RecordStopLogParams(
      step: .uploadDocuments,
      attachments: [multipartFile],
    );
    final res = await ref
        .read(recordStopLogProviderAction.notifier)
        .record(params);

    if (!res.success && mounted) {
      context.showErrorSnackBar(res.message);
      return;
    }

    if (mounted) {
      setState(() {
        attachmentsStatus = .completed;
      });
      ref.invalidate(getSingleLogWithId);
      context.showSuccessSnackBar("Log attachment uploaded successfully");
    }
  }

  @override
  Widget build(BuildContext context) {
    final recordStopLogMutation = ref.watch(recordStopLogProviderAction);

    return Column(
      children: [
        Text(
          "isPending ${recordStopLogMutation.isPending.toString()} | currentStep ${widget.session?.currentStep}",
        ),
        TimelineItem(
          isActionPending: _isActionPending(
            null,
            recordStopLogMutation.isPending,
          ),
          label: 'Arrival Time',
          status: arrivalStatus,
          child: TimelineContent(
            controller: dockInController,
            status: arrivalStatus,
            isActionPending: _isActionPending(
              null,
              recordStopLogMutation.isPending,
            ),
            onChanged: (value) => setState(() {}),
            onConfirm: () => tryAwait(
              _logArrivalTime(),
              onError: (e, _) => context.showErrorSnackBar(e.toString()),
            ),
          ),
        ),
        TimelineItem(
          isActionPending: _isActionPending(
            .arrivalTime,
            recordStopLogMutation.isPending,
          ),
          label: 'Dock In Time',
          status: dockInStatus,
          child: TimelineContent(
            controller: dockInController,
            status: dockInStatus,
            isActionPending: _isActionPending(
              .arrivalTime,
              recordStopLogMutation.isPending,
            ),
            onChanged: (_) {},
            onConfirm: () => tryAwait(
              _logDockedInTime(),
              onError: (e, _) => context.showErrorSnackBar(e.toString()),
            ),
          ),
        ),
        TimelineItem(
          isActionPending: _isActionPending(
            .dockInTime,
            recordStopLogMutation.isPending,
          ),
          label: 'Completed Time',
          status: completedStatus,
          child: TimelineContent(
            controller: completedController,
            status: completedStatus,
            isActionPending: _isActionPending(
              .dockInTime,
              recordStopLogMutation.isPending,
            ),
            onChanged: (_) {},
            onConfirm: () => tryAwait(
              _logCompletedTime(),
              onError: (e, _) => context.showErrorSnackBar(e.toString()),
            ),
          ),
        ),
        TimelineItem(
          isActionPending: _isActionPending(
            .completedTime,
            recordStopLogMutation.isPending,
          ),
          label: 'Departure Time',
          status: departureStatus,
          child: TimelineContent(
            controller: departureController,
            status: departureStatus,
            isActionPending: _isActionPending(
              .completedTime,
              recordStopLogMutation.isPending,
            ),
            onChanged: (_) {},
            onConfirm: () => tryAwait(
              _logDepartureTime(),
              onError: (e, _) => context.showErrorSnackBar(e.toString()),
            ),
          ),
        ),
        TimelineItem(
          isActionPending:
              attachmentsStatus == .active && recordStopLogMutation.isPending,
          label: 'Attachments',
          status: attachmentsStatus,
          isLastStep: true,
          child: AttachmentUploadSection(
            disabled: attachmentsStatus != .active,
            onAttachmentPicked: (file) => tryAwait(
              _onAttachmentPicked(file),
              onError: (e, st) {
                context.showErrorSnackBar(e.toString());
              },
            ),
          ),
        ),
      ],
    );
  }
}
