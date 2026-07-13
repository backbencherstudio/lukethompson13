import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/values_manager.dart';
import 'package:lukethompson/core/widgets/activity_indicator.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/core/widgets/global_app_bar.dart';
import 'package:lukethompson/core/widgets/global_button.dart';
import 'package:lukethompson/data/sources/remote/stoplog/stoplog_queries.dart';
import 'package:lukethompson/presentation/home_screen/view/widget/status_display.dart';
import 'package:lukethompson/presentation/stoplog/create_stop_log/view/widgets/facility_section.dart';
import 'package:lukethompson/presentation/stoplog/create_stop_log/view/widgets/timeline_section.dart';

class CreateStopLogScreen extends ConsumerStatefulWidget {
  const CreateStopLogScreen({super.key});

  @override
  ConsumerState<CreateStopLogScreen> createState() =>
      _CreateStopLogScreenState();
}

class _CreateStopLogScreenState extends ConsumerState<CreateStopLogScreen> {
  final _timelineKey = GlobalKey<TimelineSectionState>();
  String? _sessionId;
  bool _isActiveSessionLoading = true;
  bool _canCalculateAndPreview = false;

  void activateCalculateBtn(bool enabled) {
    setState(() {
      _canCalculateAndPreview = enabled;
    });
  }

  @override
  void initState() {
    super.initState();
    final activeSession = ref.read(getCurrentActiveStoplog);
    _sessionId = activeSession.value?.id;
    _isActiveSessionLoading = activeSession.isLoading;
  }

  @override
  Widget build(BuildContext context) {
    final session = _sessionId != null && _sessionId!.isNotEmpty
        ? ref.watch(getSingleLogWithId(_sessionId!))
        : const AsyncValue.data(null);

    ref.listen(getCurrentActiveStoplog, (prev, next) {
      if (!mounted) return;
      setState(() {
        _sessionId = next.value?.id;
        _isActiveSessionLoading = next.isLoading;
      });
    });

    final isLoading =
        _isActiveSessionLoading && _sessionId == null ||
        session.isLoading && !session.hasValue;

    // print("value ==========================================");
    // print(session.value);
    // print(session.value?.status);
    // print(session.value?.currentStep);
    // print("==========================================");
    // final canCalculateAndPreview = session.value?.status == .completed;
    // print(session.error.toString());
    // print(session.stackTrace);

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFF0F1419),
      appBar: GlobalAppBar(
        hideBackButton: true,
        title: 'Log Stop',
        subTitle: "Review details before sending",
      ),
      body: AppGradientBackground(
        child: SafeArea(
          child: isLoading
              ? Center(child: ActivityIndicator())
              : session.hasError
              ? StatusDisplay.error(session.error.toString())
              : SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppPadding.screenPadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16.h),
                      const FacilitySection(),

                      SizedBox(height: 24.h),
                      TimelineSection(
                        key: _timelineKey,
                        onSingleLogComplete: (_) {},
                        activateCalculateBtn: activateCalculateBtn,
                        session: session.value,
                      ),

                      SizedBox(height: 100.h),
                    ],
                  ),
                ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.fromLTRB(
          AppPadding.screenPadding,
          0,
          AppPadding.screenPadding,
          12,
        ),
        child: GlobalButton(
          isDisabled: !_canCalculateAndPreview,
          label: "Calculate & Preview",
          onPressed: () {
            _timelineKey.currentState?.logBolNumberAndAttachment();
          },
        ),
      ),
    );
  }
}
