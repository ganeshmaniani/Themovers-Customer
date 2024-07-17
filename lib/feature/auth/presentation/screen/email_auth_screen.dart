import 'dart:developer';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../../../feature/feature.dart';

class EmailAuthScreen extends ConsumerStatefulWidget {
  const EmailAuthScreen({super.key});

  @override
  ConsumerState<EmailAuthScreen> createState() =>
      _EmailAuthScreenConsumerState();
}

class _EmailAuthScreenConsumerState extends ConsumerState<EmailAuthScreen>
    with InputValidationMixin {
  final facebookAppEvents = FacebookAppEvents();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String countryCode = '+60';

  bool isPasswordHidden = false;
  bool isLoading = false;
  int selectTapIndex = 1;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;
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
                flex: 4,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: Dimensions.kPaddingAllMedium,
                  color: colorScheme.primary,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 12.h),
                      Container(
                        padding: const EdgeInsets.all(12),
                        height: 167.h,
                        width: 167.w,
                        decoration: BoxDecoration(
                            color: const Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(20.r)),
                        child: Image.asset(AppIcon.logoIcon),
                      ),
                      Dimensions.kVerticalSpaceSmallest,
                      Text(
                        'Signing to Your\nAccount',
                        textAlign: TextAlign.center,
                        style: textTheme.displayLarge?.copyWith(
                            fontSize: 30,
                            color: Colors.white,
                            letterSpacing: .7,
                            height: 1.2),
                      ),
                      Dimensions.kVerticalSpaceSmaller,
                      Text(
                        'Enter your email or phone to login',
                        style: textTheme.labelLarge
                            ?.copyWith(color: Colors.white.withOpacity(0.5)),
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
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Dimensions.kVerticalSpaceSmall,
                        _emailOrMobileNumberBox(),
                        Dimensions.kSpacer,
                        if (selectTapIndex == 2)
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      width: 1.w,
                                      color: const Color(0x3FB30205),
                                    ),
                                  ),
                                ),
                                child: CountryCodePicker(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  onChanged: (print) {
                                    setState(
                                        () => countryCode = print.dialCode!);

                                    debugPrint(
                                        "Country Code: ${print.dialCode}");
                                  },
                                  initialSelection: 'MY',
                                  favorite: const ['+60', 'MY'],
                                  flagWidth: 26,
                                  textStyle: context.textTheme.bodySmall,
                                  showFlagDialog: false,
                                  showCountryOnly: false,
                                  showOnlyCountryWhenClosed: false,
                                  alignLeft: false,
                                ),
                              ),
                              SizedBox(width: 8.h),
                              Expanded(
                                child: TextFormField(
                                  controller: _emailController,
                                  keyboardType: TextInputType.number,
                                  enableSuggestions: true,
                                  obscureText: false,
                                  enableInteractiveSelection: true,
                                  style: context.textTheme.bodyMedium,
                                  validator: (name) {
                                    if (isCheckTextFieldIsEmpty(name!)) {
                                      return null;
                                    } else {
                                      return 'Enter a valid Phone Number';
                                    }
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    hintText: '123456789',
                                    // hintStyle: textTheme.bodySmall?.copyWith(
                                    //     color: const Color(0xFF1B293D)),
                                    errorStyle: context.textTheme.labelMedium
                                        ?.copyWith(
                                            color: context.colorScheme.error),
                                    suffixIcon: Transform.scale(
                                      scale: 0.5,
                                      child:
                                          SvgPicture.asset(AppIcon.mobileIcon),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        if (selectTapIndex == 1)
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            enableSuggestions: true,
                            obscureText: false,
                            enableInteractiveSelection: true,
                            style: textTheme.bodyMedium,
                            validator: (email) {
                              if (isCheckTextFieldIsEmpty(email!)) {
                                return null;
                              } else {
                                return 'Enter a valid email address';
                              }
                            },
                            decoration: textInputDecoration('Email'),
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
                              return 'Enter a valid password should be 8 digit';
                            }
                          },
                          decoration: textInputDecoration('Password'),
                        ),
                        Dimensions.kVerticalSpaceSmall,
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => const ForgetPasswordScreen(
                                      title: 'Forget Password',
                                    )));
                          },
                          child: Text(
                            'Forget Password?',
                            style: textTheme.labelLarge?.copyWith(
                                color: const Color(0xFF1B293D),
                                fontWeight: FontWeight.w600,
                                letterSpacing: .6),
                          ),
                        ),
                        Dimensions.kSpacer,
                        isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : Button(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() => isLoading = true);
                                    _onSubmit();
                                  }
                                },
                                height: 50.h,
                                child: Row(
                                  children: [
                                    Dimensions.kSpacer,
                                    Text(
                                      'Login',
                                      style: textTheme.bodySmall?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: .7,
                                          fontSize: 15.sp),
                                    ),
                                    Dimensions.kSpacer,
                                    SvgPicture.asset(AppIcon.arrowIcon),
                                    SizedBox(width: 10.w)
                                  ],
                                ),
                              ),
                        Dimensions.kVerticalSpaceLarger,

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account? ",
                              style: textTheme.labelLarge?.copyWith(
                                color: context.colorScheme.secondary,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) =>
                                        const RegistrationScreen()));
                              },
                              child: Text(
                                "Register",
                                style: textTheme.labelLarge?.copyWith(
                                  color: const Color(0xFF1B293D),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
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
    final isCheckEmail = label == 'Email';

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
          : isCheckEmail
              ? Transform.scale(
                  scale: 0.5, child: SvgPicture.asset(AppIcon.personIcon))
              : null,
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Color(0x3FB30205)),
      ),
      border: const UnderlineInputBorder(
        borderSide: BorderSide(color: Color(0x3FB30205)),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Color(0x3FB30205)),
      ),
      errorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Color(0x3FB30205)),
      ),
      contentPadding: Dimensions.kPaddingAllSmall,
      labelText: label,
      labelStyle: textTheme.bodySmall?.copyWith(
        color: const Color(0xFF1B293D),
      ),
      // errorStyle: textTheme.labelMedium?.copyWith(color: colorScheme.error),
    );
  }

  _emailOrMobileNumberBox() {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () =>
                setState(() => {_emailController.clear(), selectTapIndex = 1}),
            child: Container(
              height: 42.h,
              padding: Dimensions.kPaddingAllSmall,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selectTapIndex == 1
                    ? const Color(0xFFB30205)
                    : Colors.transparent,
                borderRadius: Dimensions.kBorderRadiusAllSmallest,
                border: Border.all(
                  width: 1.w,
                  color: selectTapIndex == 1
                      ? const Color(0xFFB30205)
                      : const Color(0xFFB30205),
                  strokeAlign: BorderSide.strokeAlignOutside,
                ),
              ),
              child: Text(
                "Email",
                style: context.textTheme.bodySmall?.copyWith(
                  color: selectTapIndex == 1
                      ? Colors.white
                      : Colors.grey.withOpacity(.6),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: InkWell(
            onTap: () => setState(() => {
                  _emailController.clear(),
                  selectTapIndex = 2,
                }),
            child: Container(
              height: 42.h,
              padding: Dimensions.kPaddingAllSmall,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selectTapIndex == 2
                    ? const Color(0xFFB30205)
                    : Colors.transparent,
                borderRadius: Dimensions.kBorderRadiusAllSmallest,
                border: Border.all(
                  width: 1.w,
                  color: selectTapIndex == 2
                      ? const Color(0xFFB30205)
                      : const Color(0xFFB30205),
                  strokeAlign: BorderSide.strokeAlignOutside,
                ),
              ),
              child: Text(
                "Phone number",
                style: context.textTheme.bodySmall?.copyWith(
                  color: selectTapIndex == 2
                      ? Colors.white
                      : Colors.grey.withOpacity(.6),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _onSubmit() {
    ref
        .read(authProvider.notifier)
        .signIn(LoginEntities(
          userId: _emailController.text,
          password: _passwordController.text,
        ))
        .then(
          (res) => {
            res.fold(
              (l) => {
                setState(() => isLoading = false),
                AppAlerts.displaySnackBar(context, l.message, false),
                log(l.message)
              },
              (r) => {
                setState(() => isLoading = false),
                _emailController.clear(),
                _passwordController.clear(),
                sendFaceBookAppEventLog(),
                // AppAlerts.displaySnackBar(context, 'Login Successful', true),
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const DashboardScreen()),
                    (route) => false),
              },
            ),
          },
        );
  }

  void sendFaceBookAppEventLog() async {
    await facebookAppEvents
        .logEvent(name: 'login_user', parameters: <String, dynamic>{
      'user_id': SharedPrefs.instance.getInt(AppKeys.userId),
    });
    facebookAppEvents.setUserData(
      email: SharedPrefs.instance.getString(AppKeys.email),
      firstName: SharedPrefs.instance.getString(AppKeys.name),
    );
    log('Successfully Sent loginEvent');
  }
}
