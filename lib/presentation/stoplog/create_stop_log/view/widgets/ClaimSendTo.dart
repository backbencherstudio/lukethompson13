import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lukethompson/core/extensions/sizedbox_extension.dart';
import 'package:lukethompson/core/extensions/snackbar_extension.dart';
import 'package:lukethompson/core/network/error_handle.dart';
import 'package:lukethompson/core/utils/error.dart';
import 'package:lukethompson/core/widgets/global_button.dart';
import 'package:lukethompson/core/widgets/section_header.dart';
import 'package:lukethompson/data/models/claim/submit_claim.dart';
import 'package:lukethompson/data/models/stops/single_stoplog.model.dart';
import 'package:lukethompson/data/providers/claim_queries.dart';
import 'package:lukethompson/presentation/custom_widget/textField_widget.dart';
import 'package:lukethompson/presentation/stoplog/create_stop_log/view/widgets/send_method_toggle.dart';

class ClaimSendTo extends StatefulWidget {
  const ClaimSendTo({super.key, required this.data});

  final SingleStoplogData data;

  @override
  State<ClaimSendTo> createState() => _ClaimSendToState();
}

class _ClaimSendToState extends State<ClaimSendTo> {
  int _sendMethodIndex = 0;
  final _recipientController = TextEditingController();
  final _ccController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _recipientController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _recipientController.dispose();
    _ccController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .stretch,
      children: [
        24.height,
        SectionHeader(title: 'Send To'),
        12.height,
        InputLabel('Recipient Email'),
        8.height,
        CustomTextFieldWidget(
          hintText: "Enter recipient email",
          controller: _recipientController,
        ),
        SizedBox(height: 16),

        InputLabel('CC Broker', hint: '(Optional)'),
        8.height,
        CustomTextFieldWidget(
          hintText: "Enter CC broker",
          controller: _ccController,
        ),

        16.height,
        SendMethodToggle(
          selectedIndex: _sendMethodIndex,
          onChanged: (index) => setState(() => _sendMethodIndex = index),
        ),

        16.height,
        Consumer(
          builder: (context, ref, child) {
            return GlobalButton(
              label: 'Claim Now',
              isDisabled: _recipientController.text.trim().isEmpty,
              onPressed: () async {
                final id = widget.data.id;
                if (id == null) return;

                final (err, res, _) = await tryAwait(
                  ref
                      .read(submitAClaimAction.notifier)
                      .submit(
                        id,
                        SubmitClaimRequest(
                          claimMethod: "EMAIL",
                          recipientEmail: _recipientController.text,
                          brokerEmail: _ccController.text,
                        ),
                      ),
                );

                if (err != null) {
                  context.showErrorSnackBar(
                    ErrorHandle.formatErrorMessage(err),
                  );
                  return;
                }

                context.showSuccessSnackBar(res?.message ?? '');
              },
            );
          },
        ),
      ],
    );
  }
}
