import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/extensions/sizedbox_extension.dart';
import 'package:lukethompson/core/route/routes_names.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/core/widgets/global_app_bar.dart';
import 'package:lukethompson/core/widgets/global_button.dart';
import 'package:lukethompson/presentation/custom_widget/textField_widget.dart';

class SubcriptionAddCardScreen extends ConsumerStatefulWidget {
  const SubcriptionAddCardScreen({super.key});

  @override
  ConsumerState<SubcriptionAddCardScreen> createState() =>
      _SubcriptionAddCardScreenState();
}

class _SubcriptionAddCardScreenState
    extends ConsumerState<SubcriptionAddCardScreen> {
  final _cardNameController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _expiryMMController = TextEditingController();
  final _expiryYYController = TextEditingController();
  final _cvvController = TextEditingController();

  @override
  void dispose() {
    _cardNameController.dispose();
    _cardNumberController.dispose();
    _expiryMMController.dispose();
    _expiryYYController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 20),
      helpText: 'Select expiry date',
    );
    if (picked != null) {
      _expiryMMController.text = picked.month.toString().padLeft(2, '0');
      _expiryYYController.text = picked.year.toString().substring(2);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                InputLabel("Card Name"),
                SizedBox(height: 8.h),
                CustomTextFieldWidget(
                  controller: _cardNameController,
                  hintText: "Enter your card name",
                ),

                SizedBox(height: 15.h),
                InputLabel("Card Number"),
                SizedBox(height: 8.h),
                CustomTextFieldWidget(
                  controller: _cardNumberController,
                  hintText: "Enter your card number",
                ),

                SizedBox(height: 15.h),
                InputLabel("Expiry Date"),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFieldWidget(
                        controller: _expiryMMController,
                        hintText: "MM",
                        readonly: true,
                        onTap: _pickDate,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: CustomTextFieldWidget(
                        controller: _expiryYYController,
                        hintText: "YY",
                        readonly: true,
                        onTap: _pickDate,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 15.h),
                InputLabel("CVV"),
                SizedBox(height: 8.h),
                CustomTextFieldWidget(
                  controller: _cvvController,
                  hintText: "000",
                ),

                Spacer(),

                SizedBox(height: 15.h),
                GlobalButton(
                  label: "Continue",
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      RoutesName.subscriptionSuccess,
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
