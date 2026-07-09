import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/extensions/sizedbox_extension.dart';
import 'package:lukethompson/core/extensions/snackbar_extension.dart';
import 'package:lukethompson/core/network/error_handle.dart';
import 'package:lukethompson/core/utils/error.dart';
import 'package:lukethompson/core/utils/logger.dart';
import 'package:lukethompson/core/widgets/activity_indicator.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/core/widgets/global_app_bar.dart';
import 'package:lukethompson/core/widgets/global_button.dart';
import 'package:lukethompson/data/models/stops/mark_a_claim_as_paid_request.model.dart';
import 'package:lukethompson/data/models/stops/single_stoplog.model.dart';
import 'package:lukethompson/data/providers/claim_queries.dart';
import 'package:lukethompson/presentation/home_screen/view/widget/status_display.dart';
import 'package:lukethompson/presentation/stops/view/widget/claim_status_card.dart';
import 'package:lukethompson/presentation/stops/view/widget/full_claim_preview_card.dart';

class ClaimReviewScreenArg {
  const ClaimReviewScreenArg({this.steplogId});

  final String? steplogId;
}

class ClaimReviewScreen extends ConsumerWidget {
  const ClaimReviewScreen({super.key, this.argument});

  final ClaimReviewScreenArg? argument;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = FullClaimPreviewCard.getSession(ref, argument?.steplogId);

    return AppGradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: GlobalAppBar(
          title: 'Claim Review',
          subTitle: 'Review details - Cannot edit after sending',
        ),
        body: SafeArea(
          child: session.when(
            skipLoadingOnRefresh: true,
            skipLoadingOnReload: true,
            data: (data) {
              logger.t(data?.id);
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    16.height,
                    FullClaimPreviewCard(data: data),

                    24.height,
                    if (data != null) ClaimStatusCard(data: data),
                    24.height,

                    GlobalButton(
                      label: 'Mark as Paid',
                      onPressed: () => _onMarkAsPaidPressed(context, ref, data),
                    ),
                    16.height,
                    GlobalButton.secondary(
                      label: 'Send Follow-up',
                      onPressed: () {},
                    ),
                    24.height,
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

  Future<void> _onMarkAsPaidPressed(
    BuildContext context,
    WidgetRef ref,
    SingleStoplogDetailData? data,
  ) async {
    final id = data?.id;
    if (id == null) return;

    final (res, err) = await tryCatch(
      ref
          .read(markAClaimAsPaid.notifier)
          .submit(id, const MarkAClaimAsPaidRequest()),
    );
    if (!context.mounted) return;

    if (err != null) {
      context.showErrorSnackBar(ErrorHandle.formatErrorMessage(err));
      return;
    }

    if (res != null) {
      context.showResultSnackBar(res.message, isSuccess: res.success);
    }
  }
}
