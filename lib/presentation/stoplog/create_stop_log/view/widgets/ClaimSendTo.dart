import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lukethompson/core/extensions/sizedbox_extension.dart';
import 'package:lukethompson/core/extensions/snackbar_extension.dart';
import 'package:lukethompson/core/platform/share_service.dart';
import 'package:lukethompson/core/utils/error.dart';
import 'package:lukethompson/core/utils/logger.dart';
import 'package:lukethompson/core/widgets/global_button.dart';
import 'package:lukethompson/core/widgets/section_header.dart';
import 'package:lukethompson/data/sources/remote/claim/claim_api_controller.dart';
import 'package:lukethompson/data/sources/remote/remote.dart';
import 'package:lukethompson/presentation/custom_widget/textField_widget.dart';
import 'package:lukethompson/presentation/stoplog/create_stop_log/view/widgets/send_method_toggle.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ClaimSendTo extends ConsumerStatefulWidget {
  const ClaimSendTo({super.key, required this.data, this.redirectRoute});

  final SingleStoplogDetailData data;
  final String? redirectRoute;

  @override
  ConsumerState<ClaimSendTo> createState() => _ClaimSendToState();
}

class _ClaimSendToState extends ConsumerState<ClaimSendTo> {
  final form = ClaimSendToForm();

  FormControl<String> get recipientEmail => form.recipientEmail;
  FormControl<String> get brokerEmail => form.brokerEmail;
  FormControl<int> get sendMethod => form.sendMethod;

  Future<void> onClaim() async {
    final method = SendMethod.values[sendMethod.value ?? 0];
    final shareService = ShareService();

    logger.d(widget.data.id);

    final id = widget.data.id;
    if (id == null) return;

    final redirectRoute = widget.redirectRoute;

    switch (method) {
      case .email:
        form.markAllAsTouched();
        if (!form.valid) return;
        final (submitRes, submitErr) = await tryCatch(_submitClaim(id, method));
        if (submitErr != null) {
          context.showErrorSnackBar(submitErr.toString());
          return;
        }

        context.showSuccessSnackBar("Claim Submitted Succefully");
        if (redirectRoute != null) {
          context.replace(redirectRoute);
        } else {
          context.pop();
        }
        ref.invalidate(stopLogPaginationProvider);
        break;
      case .sms:
        final (submitRes, submitErr) = await tryCatch(_submitClaim(id, method));

        if (submitErr != null) {
          context.showErrorSnackBar(submitErr.toString());
          return;
        }

        final (res, err) = await tryCatch(
          shareService.sendSms(
            body: submitRes?.data.claimMessage ?? "Claim now",
          ),
        );

        if (err != null) {
          context.showErrorSnackBar(err.toString());
          return;
        }

        if (redirectRoute != null) {
          context.replace(redirectRoute);
        } else {
          context.pop();
        }
        ref.invalidate(stopLogPaginationProvider);
        break;
      // case .share:
      //   final (_, err) = await tryCatch(shareService.share("Claim now"));
      //
      //   if (err != null) {
      //     context.showErrorSnackBar(err.toString());
      //     return;
      //   }
      //   break;
    }
  }

  Future<SubmitClaimResponse> _submitClaim(String id, SendMethod method) {
    return ref
        .read(submitAClaimAction.notifier)
        .submit(
          id,
          SubmitClaimRequest(
            claimMethod: method.apiValue,
            recipientEmail: recipientEmail.value,
            brokerEmail: brokerEmail.value,
          ),
        );
  }

  @override
  void dispose() {
    form.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: form,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          24.height,
          const SectionHeader(title: 'Send To'),
          12.height,
          _buildRecipientEmailField(),
          16.height,
          _buildBrokerEmailField(),
          16.height,
          _buildSendMethodToggle(),
          16.height,
          _buildClaimButton(),
        ],
      ),
    );
  }

  Widget _buildRecipientEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const InputLabel('Recipient Email'),
        8.height,
        ReactiveTextField<String>(
          formControl: recipientEmail,
          validationMessages: {
            ValidationMessage.required: (_) => 'Recipient email is required',
            ValidationMessage.email: (_) => 'Please enter a valid email',
          },
          decoration: const InputDecoration(hintText: 'Enter recipient email'),
        ),
      ],
    );
  }

  Widget _buildBrokerEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const InputLabel('CC Broker', hint: '(Optional)'),
        8.height,
        ReactiveTextField<String>(
          formControl: brokerEmail,
          decoration: const InputDecoration(hintText: 'Enter CC broker'),
        ),
      ],
    );
  }

  Widget _buildSendMethodToggle() {
    return ReactiveValueListenableBuilder<int>(
      formControl: sendMethod,
      builder: (_, control, _) {
        return SendMethodToggle(
          selectedMethod: SendMethod.values[control.value ?? 0],
          onChanged: (method) => control.updateValue(method.index),
        );
      },
    );
  }

  Widget _buildClaimButton() {
    return ReactiveFormConsumer(
      builder: (_, form, _) {
        return GlobalButton(
          label: 'Claim Now',
          isDisabled: !form.valid,
          onPressed: onClaim,
        );
      },
    );
  }
}

class ClaimSendToForm extends FormGroup {
  ClaimSendToForm()
    : super({
        'recipientEmail': FormControl<String>(
          validators: [Validators.required, Validators.email],
        ),
        'brokerEmail': FormControl<String>(validators: [Validators.email]),
        'sendMethod': FormControl<int>(value: 0),
      });

  FormControl<String> get recipientEmail =>
      control('recipientEmail') as FormControl<String>;

  FormControl<String> get brokerEmail =>
      control('brokerEmail') as FormControl<String>;

  FormControl<int> get sendMethod => control('sendMethod') as FormControl<int>;
}
