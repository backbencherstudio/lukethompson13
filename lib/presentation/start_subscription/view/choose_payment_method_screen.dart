import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lukethompson/core/extensions/sizedbox_extension.dart';
import 'package:lukethompson/core/route/routes_names.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/core/widgets/global_app_bar.dart';
import 'package:lukethompson/core/widgets/global_button.dart';
import 'package:lukethompson/core/widgets/section_header.dart';
import 'package:lukethompson/gen/assets.gen.dart';
import 'package:lukethompson/presentation/start_subscription/state/choose_subscription_plan_state.dart';
import 'package:lukethompson/presentation/start_subscription/widgets/get_premium_icon.dart';
import 'package:lukethompson/presentation/start_subscription/widgets/payment_option.dart';

class ChoosePaymentMethodScreen extends ConsumerStatefulWidget {
  const ChoosePaymentMethodScreen({super.key});

  @override
  ConsumerState<ChoosePaymentMethodScreen> createState() =>
      _ChooseSubscriptionPlanScreenState();
}

class _ChooseSubscriptionPlanScreenState
    extends ConsumerState<ChoosePaymentMethodScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(selectedPlanIdProvider);

    return AppGradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: GlobalAppBar(title: 'Back'),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                12.height,
                GetPremiumIcon(),
                24.height,

                SectionHeader(title: 'Payment Method'),
                16.height,
                PaymentOption(
                  title: "Card",
                  leading: SvgPicture.asset(Assets.icons.mastercardLogo),
                  isSelected: state.paymentMethod == paymentMethodCard,
                  onTap: () => ref
                      .read(selectedPlanIdProvider.notifier)
                      .selectPaymentMethod(paymentMethodCard),
                ),
                const SizedBox(height: 12),
                PaymentOption(
                  title: "Apple Pay",
                  leading: const Icon(
                    Icons.apple,
                    color: Colors.white,
                    size: 30,
                  ),
                  isSelected: state.paymentMethod == paymentMethodApple,
                  onTap: () => ref
                      .read(selectedPlanIdProvider.notifier)
                      .selectPaymentMethod(paymentMethodApple),
                ),
                const Spacer(),

                GlobalButton(
                  isDisabled: state.paymentMethod == '',
                  label: "Subscribe Now",
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      RoutesName.subscriptionAddCard,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
