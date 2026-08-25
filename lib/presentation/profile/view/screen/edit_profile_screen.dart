import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lukethompson/core/extensions/snackbar_extension.dart';
import 'package:lukethompson/core/network/error_handle.dart';
import 'package:lukethompson/core/resource/constants/values_manager.dart';
import 'package:lukethompson/core/utils/error.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/core/widgets/full_height_scroll_view.dart';
import 'package:lukethompson/core/widgets/global_app_bar.dart';
import 'package:lukethompson/core/widgets/global_button.dart';
import 'package:lukethompson/data/sources/remote/remote.dart';
import 'package:lukethompson/presentation/custom_widget/textField_widget.dart';
import 'package:lukethompson/presentation/profile/view/widget/multi_step_form_tab.dart';
import 'package:lukethompson/presentation/profile/view/widget/profile_form_step1.dart';
import 'package:lukethompson/presentation/profile/view/widget/profile_form_step2.dart';
import 'package:reactive_forms/reactive_forms.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final personalInfoForm = PersonalInfoForm();
  final companyInfoForm = CompanyInfoForm();
  late final _pageController = PageController();
  final _companyNameFocusNode = FocusNode();

  FormControl<String> get userName => personalInfoForm.userName;
  FormControl<String> get phoneNumber => personalInfoForm.phoneNumber;
  // FormControl<String> get email => personalInfoForm.email;

  FormControl<String> get companyName => companyInfoForm.companyName;
  FormControl<String> get contactName => companyInfoForm.contactName;
  FormControl<String> get addressLine1 => companyInfoForm.addressLine1;
  FormControl<String> get city => companyInfoForm.city;
  FormControl<String> get state => companyInfoForm.state;
  FormControl<String> get postalCode => companyInfoForm.postalCode;
  FormControl<String> get country => companyInfoForm.country;
  FormControl<String> get companyPhone => companyInfoForm.companyPhone;

  @override
  void dispose() {
    personalInfoForm.dispose();
    companyInfoForm.dispose();
    _pageController.dispose();
    _companyNameFocusNode.dispose();
    super.dispose();
  }

  void _populateForm(User? user) {
    if (user == null) return;

    print(user.company);

    personalInfoForm.patchValue({
      'userName': user.name,
      'phoneNumber': user.phoneNumber,
    });

    companyInfoForm.patchValue({
      'companyName': user.company?.companyName,
      'contactName': user.company?.contactName,
      'companyPhone': user.company?.phoneNumber,

      'addressLine1': user.company?.address.addressLine1,
      'city': user.company?.address.city,
      'state': user.company?.address.state,
      'postalCode': user.company?.address.postalCode,
      'country': user.company?.address.country,
    });
  }

  @override
  void initState() {
    super.initState();
    _populateForm(ref.read(userQuery).asData?.value);
  }

  Future<void> _handleUpdate({
    required UpdateUserProfileParams info,
    VoidCallback? onSuccess,
  }) async {
    final ctx = context;

    final action = ref.read(updateUserProfileMutation);

    try {
      final response = await action.run(info);
      if (!ctx.mounted) return;

      if (response.success) {
        ref.invalidate(userQuery);
        if (onSuccess != null) {
          onSuccess();
        }
      }
    } catch (err) {
      ctx.showErrorSnackBar(
        'Failed to update profile',
        subtitle: ErrorHandle.formatErrorMessage(err),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(userQuery, (prev, next) {
      next.whenData(_populateForm);
    });

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: GlobalAppBar(title: 'Edit Profile'),
      body: AppGradientBackground(
        child: SafeArea(
          minimum: EdgeInsets.only(bottom: 12),
          child: Column(
            children: [
              MultiStepFormTab(
                pageController: _pageController,
                steps: ['Personal Informatin', 'Company Information'],
              ),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  children: [
                    ReactiveForm(
                      formGroup: personalInfoForm,
                      child: ProfileFormStep1(
                        onSubmit: () {
                          _handleUpdate(
                            info: UpdateUserProfileParams(
                              name: userName.value?.trim(),
                              phoneNumber: phoneNumber.value?.trim(),
                            ),
                            onSuccess: () {
                              _pageController
                                  .nextPage(
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  )
                                  .then((_) {
                                    _companyNameFocusNode.requestFocus();
                                  });
                            },
                          );
                        },
                        userName: userName,
                        phoneNumber: phoneNumber,
                        // email: email,
                      ),
                    ),
                    ReactiveForm(
                      formGroup: companyInfoForm,
                      child: ProfileFormStep2(
                        companyNameFocusNode: _companyNameFocusNode,
                        onSubmit: () => _handleUpdate(
                          info: UpdateUserProfileParams(
                            company: CreateCompanyRequest(
                              companyName: companyName.value?.trim(),
                              contactName: contactName.value?.trim(),
                              addressLine1: addressLine1.value?.trim(),
                              city: city.value?.trim(),
                              state: state.value?.trim(),
                              postalCode: postalCode.value?.trim(),
                              country: country.value?.trim(),
                              phoneNumber: companyPhone.value?.trim(),
                            ),
                          ),
                          onSuccess: () {
                            context.showSuccessSnackBar(
                              'Profile updated successfully',
                            );
                            context.pop();
                          },
                        ),
                        companyName: companyName,
                        contactName: contactName,
                        companyPhone: companyPhone,
                        addressLine1: addressLine1,
                        city: city,
                        state: state,
                        postalCode: postalCode,
                        country: country,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PersonalInfoForm extends FormGroup {
  PersonalInfoForm()
    : super({
        'userName': FormControl<String>(validators: [Validators.required]),
        'phoneNumber': FormControl<String>(validators: [Validators.required]),
        // 'email': FormControl<String>(
        //   validators: [Validators.required, Validators.email],
        // ),
      });

  FormControl<String> get userName =>
      control('userName') as FormControl<String>;

  FormControl<String> get phoneNumber =>
      control('phoneNumber') as FormControl<String>;

  // FormControl<String> get email => control('email') as FormControl<String>;
}

class CompanyInfoForm extends FormGroup {
  CompanyInfoForm()
    : super({
        'companyName': FormControl<String>(validators: [Validators.required]),
        'contactName': FormControl<String>(validators: [Validators.required]),
        'addressLine1': FormControl<String>(validators: [Validators.required]),
        'city': FormControl<String>(validators: [Validators.required]),
        'state': FormControl<String>(validators: [Validators.required]),
        'postalCode': FormControl<String>(validators: [Validators.required]),
        'country': FormControl<String>(validators: [Validators.required]),
        'companyPhone': FormControl<String>(validators: [Validators.required]),
      });

  FormControl<String> get companyName =>
      control('companyName') as FormControl<String>;

  FormControl<String> get contactName =>
      control('contactName') as FormControl<String>;

  FormControl<String> get addressLine1 =>
      control('addressLine1') as FormControl<String>;

  FormControl<String> get city => control('city') as FormControl<String>;

  FormControl<String> get state => control('state') as FormControl<String>;

  FormControl<String> get postalCode =>
      control('postalCode') as FormControl<String>;

  FormControl<String> get country => control('country') as FormControl<String>;

  FormControl<String> get companyPhone =>
      control('companyPhone') as FormControl<String>;
}
