import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../../feature.dart';

class CreateNewPassword extends ConsumerStatefulWidget {
  final String phoneNumber;
  final String email;
  final String title;
  final bool showOldPassword;
  final String oldPassword;

  const CreateNewPassword(
      {super.key,
      required this.email,
      required this.phoneNumber,
      required this.title,
      required this.showOldPassword,
      required this.oldPassword});

  @override
  ConsumerState<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends ConsumerState<CreateNewPassword>
    with InputValidationMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _oldPasswordController = TextEditingController();
  final _passwordController = TextEditingController();
  final _conformPasswordController = TextEditingController();

  bool isPasswordHidden = false;
  bool isConformPasswordHidden = false;
  bool isOldPasswordHidden = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: Dimensions.kPaddingAllMedium,
                  color: context.colorScheme.primary,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Dimensions.kVerticalSpaceLarge,
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                            width: 38.w,
                            height: 38.h,
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white),
                            child: SvgPicture.asset(
                              AppIcon.backArrowIcon,
                              color: Color(0xFFB40205),
                            )),
                      ),
                      Dimensions.kSpacer,
                      Center(
                        child: Text(
                          widget.showOldPassword == false
                              ? 'Create your password'
                              : 'Reset Password',
                          // textAlign: TextAlign.center,
                          style: textTheme.displayLarge?.copyWith(
                            color: Colors.white,
                            fontSize: 30.sp,
                          ),
                        ),
                      ),
                      Dimensions.kVerticalSpaceMedium,
                      Center(
                        child: Text(
                          'Create your Password',
                          style: textTheme.labelLarge
                              ?.copyWith(color: Colors.white.withOpacity(0.5)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: Dimensions.kPaddingAllMedium,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Dimensions.kVerticalSpaceSmall,
                        widget.showOldPassword == false
                            ? const SizedBox()
                            : TextFormField(
                                controller: _oldPasswordController,
                                keyboardType: TextInputType.text,
                                obscureText: !isOldPasswordHidden,
                                enableSuggestions: true,
                                enableInteractiveSelection: true,
                                style: textTheme.bodyMedium,
                                validator: (password) {
                                  if (widget.oldPassword == password) {
                                    return null;
                                  } else {
                                    return 'Enter a old password';
                                  }
                                },
                                decoration: textInputDecoration('Old Password'),
                              ),
                        Dimensions.kVerticalSpaceSmall,
                        TextFormField(
                          controller: _passwordController,
                          keyboardType: TextInputType.text,
                          obscureText: !isPasswordHidden,
                          enableSuggestions: true,
                          enableInteractiveSelection: true,
                          style: textTheme.bodyMedium,
                          validator: (password) {
                            if (isPasswordValid(password!)) {
                              return null;
                            } else {
                              return 'Enter a valid password';
                            }
                          },
                          decoration: textInputDecoration('Password'),
                        ),
                        Dimensions.kVerticalSpaceSmall,
                        TextFormField(
                          controller: _conformPasswordController,
                          keyboardType: TextInputType.text,
                          obscureText: !isConformPasswordHidden,
                          enableSuggestions: true,
                          enableInteractiveSelection: true,
                          style: textTheme.bodyMedium,
                          validator: (password) {
                            final newPassword = _passwordController.text;
                            if (isConformPassword(newPassword, password!)) {
                              return null;
                            } else {
                              return 'Enter a valid password';
                            }
                          },
                          decoration: textInputDecoration('Conform Password'),
                        ),
                        Dimensions.kSpacer,
                        isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : Button(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() => isLoading = true);

                                    widget.showOldPassword == false
                                        ? forgetOnSubmit()
                                        : resetOnSubmit();
                                  }
                                },
                                height: 50.h,
                                child: Row(
                                  children: [
                                    Dimensions.kSpacer,
                                    Text(
                                      widget.showOldPassword == false
                                          ? 'Register'
                                          : 'Save',
                                      style: textTheme.bodyMedium?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: .7,
                                      ),
                                    ),
                                    Dimensions.kSpacer,
                                    SvgPicture.asset(AppIcon.arrowIcon),
                                    SizedBox(width: 10.w)
                                  ],
                                ),
                              ),
                        Dimensions.kVerticalSpaceSmallest,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  textInputDecoration(String label) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;
    final isCheckPassword = label == "Password";
    final isCheckConformPassword = label == "Conform Password";
    final isCheckOldPassword = label == 'Old Password';
    return InputDecoration(
      suffixIcon: isCheckPassword
          ? IconButton(
              onPressed: () =>
                  setState(() => isPasswordHidden = !isPasswordHidden),
              icon: isPasswordHidden
                  ? Icon(
                      Icons.lock_open,
                      color: colorScheme.primary,
                    )
                  : SvgPicture.asset(AppIcon.lock))
          : isCheckConformPassword
              ? IconButton(
                  onPressed: () => setState(
                      () => isConformPasswordHidden = !isConformPasswordHidden),
                  icon: isConformPasswordHidden
                      ? Icon(
                          Icons.lock_open,
                          color: colorScheme.primary,
                        )
                      : SvgPicture.asset(AppIcon.lock))
              : isCheckOldPassword
                  ? IconButton(
                      onPressed: () => setState(
                          () => isOldPasswordHidden = !isOldPasswordHidden),
                      icon: isOldPasswordHidden
                          ? Icon(
                              Icons.lock_open,
                              color: colorScheme.primary,
                            )
                          : SvgPicture.asset(AppIcon.lock))
                  : null,
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Color(0x3FB30205)),
      ),
      border: UnderlineInputBorder(
        borderRadius: Dimensions.kBorderRadiusAllSmallest,
        borderSide: BorderSide(color: colorScheme.primary),
      ),
      focusedBorder: UnderlineInputBorder(
        borderRadius: Dimensions.kBorderRadiusAllSmallest,
        borderSide: BorderSide(color: colorScheme.primary),
      ),
      errorBorder: UnderlineInputBorder(
        borderRadius: Dimensions.kBorderRadiusAllSmallest,
        borderSide: BorderSide(color: colorScheme.error),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      labelText: label,
      labelStyle: textTheme.bodySmall?.copyWith(
        color: colorScheme.secondary,
      ),
      errorStyle: textTheme.labelMedium?.copyWith(color: colorScheme.error),
    );
  }

  void forgetOnSubmit() {
    final forgetPasswordEntities = ForgetPasswordEntities(
        email: widget.email, password: _conformPasswordController.text);
    ref.read(authProvider.notifier).forgetPassword(forgetPasswordEntities).then(
          (response) => response.fold(
              (l) => {
                    setState(() => isLoading = false),
                    AppAlerts.displaySnackBar(context, l.message, false),
                  },
              (r) => {
                    setState(() => isLoading = false),
                    // AppAlerts.displaySnackBar(
                    //     context, "Password Update Successfully", true),
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const EmailAuthScreen()),
                        (route) => false),
                  }),
        );
  }

  resetOnSubmit() {
    final id = SharedPrefs.instance.getInt(AppKeys.userId);
    ref
        .read(customerProfileDetailProvider.notifier)
        .resetPassword(ResetPasswordEntities(
            newPassword: _passwordController.text,
            conformPassword: _conformPasswordController.text,
            customerId: id.toString()))
        .then((res) => res.fold(
            (l) => {
                  debugPrint(l.message),
                  setState(() => isLoading = false),
                  setState(() {
                    AppAlerts.displaySnackBar(
                        context,
                        'Password Reset Failed'
                        '',
                        false);
                  }),
                },
            (r) => {
                  // debugPrint(r.message),
                  setState(() => isLoading = false),
                  setState(() {
                    // AppAlerts.displaySnackBar(
                    //     context, "Password Reset Successfully", true);
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const DashboardScreen()),
                        (route) => false);
                  }),
                }));
  }
}
