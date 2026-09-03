import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lukethompson/core/extensions/snackbar_extension.dart';
import 'package:lukethompson/core/network/error_handle.dart';
import 'package:lukethompson/core/route/route_names.dart';
import 'package:lukethompson/core/utils/error.dart';
import 'package:lukethompson/core/widgets/custom_dialog.dart';
import 'package:lukethompson/core/widgets/global_button.dart';
import 'package:lukethompson/core/widgets/profile_setting_item.dart';
import 'package:lukethompson/data/sources/remote/auth/auth_queries.dart';
import 'package:lukethompson/data/sources/remote/auth/auth_state_provider.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AccountDeleteSettingItem extends StatefulWidget {
  const AccountDeleteSettingItem({super.key});

  @override
  State<AccountDeleteSettingItem> createState() =>
      _AccountDeleteSettingItemState();
}

class _AccountDeleteSettingItemState extends State<AccountDeleteSettingItem> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) => ProfileSettingItem(
        icon: Icons.person,
        title: "Delete Account",
        titleColor: Colors.redAccent,
        iconColor: Colors.redAccent,
        onTap: () => showDeletePrompDialog(context),
      ),
    );
  }

  Future<dynamic> showDeletePrompDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => CustomDialog(
        title: 'Delete Account',
        subtitle: 'Are you sure you want to delete your account?',
        bottomWidget: Row(
          spacing: 12,
          children: [
            Expanded(
              child: GlobalButton.danger(
                label: 'Delete',
                onPressed: () {
                  context.pop();
                  showDeleteFormDialog(context);
                },
              ),
            ),
            Expanded(
              child: GlobalButton.outlined(
                label: 'Cancel',
                onPressed: () => context.pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> showDeleteFormDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => DeleteAccountDialog(),
    );
  }
}

class DeleteAccountDialog extends ConsumerStatefulWidget {
  const DeleteAccountDialog({super.key});

  @override
  ConsumerState<DeleteAccountDialog> createState() =>
      _DeleteAccountDialogState();
}

class _DeleteAccountDialogState extends ConsumerState<DeleteAccountDialog> {
  bool _obscurePassword = true;

  final _form = FormGroup({
    'password': FormControl<String>(
      validators: [Validators.required, Validators.minLength(6)],
    ),
  });

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deleteMutatinState = ref.watch(deleteAccountMutation);
    final passwordControl = _form.control('password') as FormControl<String>;

    return CustomDialog(
      title: 'Confirm Account Deletion',
      subtitle:
          'Deleting your account will permanently remove your account and data.\nEnter your password below to continue.',
      bottomWidget: ReactiveForm(
        formGroup: _form,
        child: Column(
          spacing: 16,
          children: [
            ReactiveTextField<String>(
              formControl: passwordControl,
              obscureText: _obscurePassword,
              validationMessages: {
                ValidationMessage.required: (_) => 'Password is required',
                ValidationMessage.minLength: (_) =>
                    'Password must be at least 6 characters',
              },
              decoration: InputDecoration(
                hintText: "Enter Your Password",
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility : Icons.visibility_off,
                    color: const Color.fromARGB(255, 172, 192, 208),
                  ),
                  onPressed: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                ),
              ),
            ),
            ReactiveFormConsumer(
              builder: (_, form, _) {
                return GlobalButton.danger(
                  isDisabled: !_form.valid,
                  isLoading: deleteMutatinState.isPending,
                  label: 'Delete my account',
                  onPressed: () async {
                    _form.markAllAsTouched();
                    if (!_form.valid) return;

                    final (res, err) = await tryCatch(
                      ref
                          .watch(deleteAccountMutation.notifier)
                          .delete(passwordControl.value!),
                    );

                    if (err != null) {
                      context.pop();
                      context.showErrorSnackBar(
                        ErrorHandle.formatErrorMessage(err.toString()),
                      );
                      return;
                    }

                    if (res?.success == true) {
                      context.pop();
                      ref.read(authStateProvider.notifier).logout();
                      context.go(Routes.signIn);
                      context.showSuccessSnackBar(
                        res?.message ?? "Account deleted successfully",
                      );
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
