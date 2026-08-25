import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lukethompson/core/extensions/sizedbox_extension.dart';
import 'package:lukethompson/core/extensions/snackbar_extension.dart';
import 'package:lukethompson/core/extensions/text_style_extension.dart';
import 'package:lukethompson/core/network/error_handle.dart';
import 'package:lukethompson/core/resource/constants/values_manager.dart';
import 'package:lukethompson/core/route/route_names.dart';
import 'package:lukethompson/core/utils/error.dart';
import 'package:lukethompson/core/widgets/app_card.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/core/widgets/full_height_scroll_view.dart';
import 'package:lukethompson/core/widgets/global_app_bar.dart';
import 'package:lukethompson/core/widgets/global_button.dart';
import 'package:lukethompson/data/sources/remote/shipper/shipper_queries.dart';
import 'package:lukethompson/data/sources/remote/stoplog/stoplog_list_infinite_scroll.dart';
import 'package:lukethompson/gen/assets.gen.dart';
import 'package:lukethompson/presentation/custom_widget/dropdown_field_widget.dart';
import 'package:lukethompson/presentation/custom_widget/textField_widget.dart';
import 'package:lukethompson/presentation/profile/view/widget/shipper_rating_card.dart';

class RateShipperScreenArg {
  const RateShipperScreenArg({
    required this.id,
    required this.facilityName,
    this.brokerName,
  });

  final String id;
  final String facilityName;
  final String? brokerName;
}

class RateShipperScreen extends ConsumerStatefulWidget {
  const RateShipperScreen({super.key, this.argument});

  final RateShipperScreenArg? argument;

  @override
  ConsumerState<RateShipperScreen> createState() => _RateShipperScreenState();
}

class _RateShipperScreenState extends ConsumerState<RateShipperScreen> {
  String? _selectedReview;
  String? _brokerReview;

  int get _selectedRate => PayerCategory.reviewOptions
      .firstWhere(
        (e) => e.label == _selectedReview,
        orElse: () => const ReviewOption('', 0),
      )
      .value;

  int get _brokerRate => PayerCategory.reviewOptions
      .firstWhere(
        (e) => e.label == _brokerReview,
        orElse: () => const ReviewOption('', 0),
      )
      .value;

  List<ReviewOption> get reviewList => PayerCategory.reviewOptions;

  @override
  Widget build(BuildContext context) {
    final submitStatus = ref.watch(submitARatingForAShipperFacilityMutation);

    return AppGradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: GlobalAppBar(title: 'Client Review'),
        body: SafeArea(
          child: FullHeightScrollView(
            padding: EdgeInsets.symmetric(horizontal: AppPadding.screenPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),

                Center(
                  child: Assets.icons.clientReviewLogo.image(height: 80.w),
                ),

                SizedBox(height: 24.h),

                AppCard(
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      InputLabel('Facility:'),
                      SizedBox(height: 2.h),
                      Text(
                        widget.argument?.facilityName ?? '',
                        style: context.bodyLarge,
                        maxLines: 2,
                        overflow: .ellipsis,
                      ),

                      SizedBox(height: 15.h),
                      InputLabel('Facility review'),
                      SizedBox(height: 8.h),
                      DropdownFieldWidget(
                        value: _selectedReview,
                        hint: "Share your facility review",
                        items: PayerCategory.reviewOptions
                            .map((e) => e.label)
                            .toList(),
                        onChanged: (value) {
                          setState(() => _selectedReview = value);
                        },
                      ),
                    ],
                  ),
                ),

                16.height,

                if (widget.argument?.brokerName != null)
                  AppCard(
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        InputLabel('Broker'),
                        SizedBox(height: 2.h),
                        Text(
                          widget.argument?.brokerName ?? '',
                          style: context.bodyLarge,
                          maxLines: 2,
                          overflow: .ellipsis,
                        ),

                        SizedBox(height: 15.h),
                        InputLabel('Broker review'),
                        SizedBox(height: 8.h),
                        DropdownFieldWidget(
                          value: _brokerReview,
                          hint: "Share your broker review",
                          items: PayerCategory.reviewOptions
                              .map((e) => e.label)
                              .toList(),
                          onChanged: (value) {
                            setState(() => _brokerReview = value);
                          },
                        ),
                      ],
                    ),
                  ),

                const Spacer(),

                GlobalButton(
                  isDisabled: _selectedReview == null || _brokerReview == null,
                  isLoading: submitStatus.isPending,
                  label: "Submit",
                  onPressed: () => _onSubmit(
                    context,
                    ref,
                    widget.argument?.id,
                    _selectedRate,
                    _brokerRate,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onSubmit(
    BuildContext context,
    WidgetRef ref,
    String? stopLogId,
    int rate,
    int brokerRate,
  ) async {
    if (stopLogId == null) return;

    final (res, err) = await tryCatch(
      ref
          .read(submitARatingForAShipperFacilityMutation.notifier)
          .submit(stopLogId, rate, brokerRate),
    );
    if (!context.mounted) return;

    if (err != null) {
      context.showErrorSnackBar(ErrorHandle.formatErrorMessage(err));
      return;
    }

    if (res != null) {
      context.showResultSnackBar(res.message, isSuccess: res.success);
      if (res.success) {
        context.replace(Routes.reviewSubmitted);
        ref.invalidate(stopLogPaginationProvider);
      }
    }
  }
}
