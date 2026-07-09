import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lukethompson/core/extensions/sizedbox_extension.dart';
import 'package:lukethompson/core/extensions/snackbar_extension.dart';
import 'package:lukethompson/core/network/error_handle.dart';
import 'package:lukethompson/core/platform/share_service.dart';
import 'package:lukethompson/core/utils/error.dart';
import 'package:lukethompson/core/widgets/global_button.dart';
import 'package:lukethompson/core/widgets/section_header.dart';
import 'package:lukethompson/data/models/claim/submit_claim.dart';
import 'package:lukethompson/data/models/stops/single_stoplog.model.dart';
import 'package:lukethompson/data/providers/claim_queries.dart';
import 'package:lukethompson/presentation/custom_widget/textField_widget.dart';
import 'package:lukethompson/presentation/stoplog/create_stop_log/view/widgets/send_method_toggle.dart'
    show SendMethod, SendMethodToggle;
import 'package:reactive_forms/reactive_forms.dart';

class ClaimSendTo extends ConsumerStatefulWidget {
  const ClaimSendTo({super.key, required this.data});

  final SingleStoplogData data;

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

    switch (method) {
      case .email:
        form.markAllAsTouched();
        if (!form.valid) return;
        final id = widget.data.id;
        if (id == null) return;

        await _submitClaimViaEmail(ref, id, method);
        break;
      case .sms:
        final (res, err) = await tryCatch(
          shareService.sendSms(body: "Claim now"),
        );

        if (err != null) {
          context.showErrorSnackBar(err.toString());
          return;
        }
        break;
      case .share:
        final (_, err) = await tryCatch(
          shareService.share("Claim now"),
        );

        if (err != null) {
          context.showErrorSnackBar(err.toString());
          return;
        }
        break;
    }
  }

  Future<void> _submitClaimViaEmail(
    WidgetRef ref,
    String id,
    SendMethod method,
  ) async {
    final (res, err) = await tryCatch(
      ref
          .read(submitAClaimAction.notifier)
          .submit(
            id,
            SubmitClaimRequest(
              claimMethod: method.apiValue,
              recipientEmail: recipientEmail.value,
              brokerEmail: brokerEmail.value,
            ),
          ),
    );

    if (!mounted) return;

    if (err != null) {
      context.showErrorSnackBar(ErrorHandle.formatErrorMessage(err));
      return;
    }

    context.showSuccessSnackBar(res?.message ?? '');
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
          _buildSendMethodToggle(),
          16.height,
          ReactiveValueListenableBuilder<int>(
            formControl: sendMethod,
            builder: (_, control, _) {
              final isEmail =
                  SendMethod.values[control.value ?? 0] == SendMethod.email;
              if (!isEmail) return const SizedBox.shrink();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildRecipientEmailField(),
                  16.height,
                  _buildBrokerEmailField(),
                  16.height,
                ],
              );
            },
          ),
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
        return ReactiveValueListenableBuilder<int>(
          formControl: sendMethod,
          builder: (_, control, _) {
            final isEmail = SendMethod.values[control.value ?? 0] == .email;
            return GlobalButton(
              label: 'Claim Now',
              isDisabled: isEmail && !form.valid,
              onPressed: onClaim,
            );
          },
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
