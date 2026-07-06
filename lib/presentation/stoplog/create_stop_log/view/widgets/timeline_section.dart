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
    required this.activateCalculateBtn,
  });

  final SingleStoplogData? session;
  final void Function(StopLogStep step) onSingleLogComplete;
  final void Function() activateCalculateBtn;

  @override
  ConsumerState<TimelineSection> createState() => _TimelineSectionState();
}

class _TimelineSectionState extends ConsumerState<TimelineSection> {
  var arrivalStatus = TimelineItemStatus.idle;
  var dockInStatus = TimelineItemStatus.idle;
  var completedStatus = TimelineItemStatus.idle;
  var departureStatus = TimelineItemStatus.idle;
  var attachmentsStatus = TimelineItemStatus.idle;
  var bolNumberStatus = TimelineItemStatus.idle;
  XFile? attachmentFile;

  static const String _initialDepartureTime = '01:00 PM';

  final bolNumberController = TextEditingController();

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
        arrivalStatus = TimelineItemStatus.active;
        dockInStatus = TimelineItemStatus.idle;
        completedStatus = TimelineItemStatus.idle;
        departureStatus = TimelineItemStatus.idle;
        attachmentsStatus = TimelineItemStatus.idle;
        bolNumberStatus = TimelineItemStatus.idle;
      });
      return;
    }

    setState(() {
      if (s.bolNumber != null && bolNumberController.text != s.bolNumber) {
        bolNumberController.text = s.bolNumber!;
      }

      arrivalStatus = TimelineItemStatus.idle;
      dockInStatus = TimelineItemStatus.idle;
      completedStatus = TimelineItemStatus.idle;
      departureStatus = TimelineItemStatus.idle;
      attachmentsStatus = TimelineItemStatus.idle;
      bolNumberStatus = TimelineItemStatus.idle;

      switch (s.currentStep) {
        case StopLogStep.arrivalTime:
          arrivalStatus = TimelineItemStatus.completed;
          dockInStatus = TimelineItemStatus.active;
        case StopLogStep.dockInTime:
          arrivalStatus = TimelineItemStatus.completed;
          dockInStatus = TimelineItemStatus.completed;
          completedStatus = TimelineItemStatus.active;
        case StopLogStep.completedTime:
          arrivalStatus = TimelineItemStatus.completed;
          dockInStatus = TimelineItemStatus.completed;
          completedStatus = TimelineItemStatus.completed;
          departureStatus = TimelineItemStatus.active;
        case StopLogStep.departureTime:
          arrivalStatus = TimelineItemStatus.completed;
          dockInStatus = TimelineItemStatus.completed;
          completedStatus = TimelineItemStatus.completed;
          departureStatus = TimelineItemStatus.completed;
          attachmentsStatus = TimelineItemStatus.active;
        case StopLogStep.uploadDocuments:
          arrivalStatus = TimelineItemStatus.completed;
          dockInStatus = TimelineItemStatus.completed;
          completedStatus = TimelineItemStatus.completed;
          departureStatus = TimelineItemStatus.completed;
          attachmentsStatus = TimelineItemStatus.completed;
          bolNumberStatus = TimelineItemStatus.active;
        case null:
          print("currentStep is null");
      }

      if (s.bolNumber != null && s.bolNumber!.isNotEmpty) {
        bolNumberStatus = TimelineItemStatus.completed;
      }
    });
  }

  @override
  void dispose() {
    bolNumberController.dispose();
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

  Future<void> _pickAttachmentFile(XFile file) async {
    attachmentFile = file;
    setState(() {
      attachmentsStatus = TimelineItemStatus.completed;
      bolNumberStatus = TimelineItemStatus.active;
    });
    widget.activateCalculateBtn();
  }

  Future<void> _logBolNumberAndAttachment() async {
    final activeSessionId = widget.session?.id;
    if (activeSessionId == null) return;

    final hasExistingAttachments =
        widget.session?.attachments != null &&
        widget.session!.attachments!.isNotEmpty;
    if (attachmentFile == null && !hasExistingAttachments) {
      context.showErrorSnackBar("Please select an attachment file");
      return;
    }

    MultipartFile? multipartFile;
    if (attachmentFile != null) {
      multipartFile = MultipartFile.fromFileSync(
        attachmentFile!.path,
        filename: attachmentFile!.name,
      );
    }

    final params = RecordStopLogParams(
      id: activeSessionId,
      step: StopLogStep.uploadDocuments,
      bolNumber: bolNumberController.text.trim().isEmpty
          ? null
          : bolNumberController.text.trim(),
      attachments: multipartFile != null ? [multipartFile] : null,
    );

    final res = await ref
        .read(recordStopLogProviderAction.notifier)
        .record(params);

    if (!res.success && mounted) {
      context.showErrorSnackBar(res.message);
      return;
    }

    setState(() {
      bolNumberStatus = TimelineItemStatus.completed;
    });

    if (mounted) {
      context.showSuccessSnackBar("Your Step log is completed");
      _refetchSession();
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
            value: _initialDepartureTime,
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
            value: _initialDepartureTime,
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
            value: _initialDepartureTime,
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
            value: _initialDepartureTime,
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
          lineHeight: 330,
          isActionPending:
              attachmentsStatus == .active && recordStopLogMutation.isPending,
          label: 'Attachments',
          status: attachmentsStatus,
          child: AttachmentUploadSection(
            disabled: attachmentsStatus != .active,
            onAttachmentPicked: (file) => tryAwait(
              _pickAttachmentFile(file),
              onError: (e, st) {
                context.showErrorSnackBar(e.toString());
              },
            ),
          ),
        ),
        TimelineItem(
          isActionPending:
              bolNumberStatus == TimelineItemStatus.active &&
              recordStopLogMutation.isPending,
          label: 'BOL Number',
          isLastStep: true,
          status: bolNumberStatus,
          child: TimelineContentField(
            controller: bolNumberController,
            status: bolNumberStatus,
            isActionPending:
                bolNumberStatus == TimelineItemStatus.active &&
                recordStopLogMutation.isPending,
            onChanged: (_) {},
            onConfirm: () => tryAwait(
              _logBolNumberAndAttachment(),
              onError: (e, _) => context.showErrorSnackBar(e.toString()),
            ),
          ),
        ),
      ],
    );
  }
}
