import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/extensions/sizedbox_extension.dart';
import 'package:lukethompson/core/utils/logger.dart';
import 'package:lukethompson/core/widgets/activity_indicator.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/core/widgets/global_app_bar.dart';
import 'package:lukethompson/core/widgets/global_button.dart';
import 'package:lukethompson/presentation/home_screen/view/widget/status_display.dart';
import 'package:lukethompson/presentation/stoplog/create_stop_log/view/widgets/ClaimSendTo.dart';
import 'package:lukethompson/presentation/stops/view/widget/full_claim_preview_card.dart';

class ClaimNowScreenArg {
  const ClaimNowScreenArg({
    this.steplogId,
    this.facilityName,
    this.shipperFacilityId,
  });

  final String? steplogId;
  final String? facilityName;
  final String? shipperFacilityId;
}

class ClaimNowScreen extends ConsumerWidget {
  const ClaimNowScreen({super.key, this.argument});

  final ClaimNowScreenArg? argument;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = FullClaimPreviewCard.getSession(ref, argument?.steplogId);
    logger.t(argument?.steplogId);

    return AppGradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: GlobalAppBar(title: 'Claim Detail'),
        body: SafeArea(
          child: session.when(
            skipLoadingOnRefresh: true,
            skipLoadingOnReload: true,
            data: (data) {
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    16.height,
                    FullClaimPreviewCard(data: data),

                    16.height,
                    // TODO: implement this
                    GlobalButton.secondary(
                      label: 'Export PDF',
                      onPressed: () {},
                    ),

                    if (data != null) ClaimSendTo(data: data),
                  ],
                ),
              );
            },
            loading: () => const Center(child: ActivityIndicator()),
            error: (e, st) {
              return StatusDisplay.error(e.toString());
            },
          ),
        ),
      ),
    );
  }
}
