import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../auth.dart';

class OtpVerificationScreen extends ConsumerStatefulWidget {
  // final String countryCode;
  final String email;

  const OtpVerificationScreen({required this.email, super.key});

  @override
  ConsumerState<OtpVerificationScreen> createState() =>
      _OtpVerificationScreenConsumerState();
}

class _OtpVerificationScreenConsumerState
    extends ConsumerState<OtpVerificationScreen> with InputValidationMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _pin1Controller = TextEditingController();
  final _pin2Controller = TextEditingController();
  final _pin3Controller = TextEditingController();
  final _pin4Controller = TextEditingController();
  final _pin5Controller = TextEditingController();
  final _pin6Controller = TextEditingController();

  bool isLoading = false;
  late String verificationId;

  int _secondsRemaining = 15; // Initial countdown duration in seconds
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    getOtpValue();
    startTimer();
  }

  void startTimer() {
    const oneSecond = Duration(seconds: 2);
    _timer = Timer.periodic(oneSecond, (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          // Timer has reached 0, you can handle what happens when the timer ends here
          timer.cancel(); // Cancel the timer
        }
      });
    });
  }

  getOtpValue() {
    ref
        .read(authProvider.notifier)
        .emailOtpGenerator(widget.email)
        .then((res) => res.fold(
            (l) => {
                  setState(() => isLoading = false),
                  AppAlerts.displaySnackBar(context, l.message, false),
                  setState(() => isLoading = false)
                },
            (r) => {
                  setState(() => isLoading = false),
                }));
  }

  //
  // void requestFireBaseOtp() async {
  //   log(widget.countryCode + widget.mobileNo);
  //   await FirebaseAuth.instance.verifyPhoneNumber(
  //       phoneNumber: widget.countryCode + widget.mobileNo,
  //       verificationCompleted: (phoneAuthCredential) async {
  //         debugPrint(phoneAuthCredential.toString());
  //         setState(() => isLoading = false);
  //       },
  //       verificationFailed: (verificationFailed) async {
  //         debugPrint(verificationFailed.toString());
  //         setState(() => isLoading = false);
  //       },
  //       codeSent: (verificationId, resendToken) async {
  //         debugPrint(verificationId);
  //         debugPrint(resendToken.toString());
  //         this.verificationId = verificationId;
  //       },
  //       codeAutoRetrievalTimeout: (verificationId) async {
  //         debugPrint(verificationId);
  //         setState(() => isLoading = false);
  //       });
  // }

  resentOtp() {
    getOtpValue();
    _secondsRemaining = 15;
    startTimer();
  }

  @override
  void dispose() {
    // Cancel the timer to avoid memory leaks
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Dimensions.kVerticalSpaceLarge,
                Center(
                    child: Image.asset(
                  AppIcon.otpIcon,
                  width: 258.w,
                  height: 307.h,
                )),
                Center(
                  child: Text(
                    'OTP Verification',
                    style: textTheme.displayLarge?.copyWith(
                      fontSize: 30.sp,
                      color: const Color(0xFF1B293D),
                      letterSpacing: .7,
                      height: 1.2.h,
                    ),
                  ),
                ),
                Dimensions.kVerticalSpaceSmaller,
                Center(
                  child: Text(
                    'Check your Email to see the\nverification code',
                    textAlign: TextAlign.center,
                    style: textTheme.labelLarge
                        ?.copyWith(color: const Color(0xFF1B293D)),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Dimensions.kVerticalSpaceSmall,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 49.w,
                            height: 48.h,
                            child: TextFormField(
                              autofocus: true,
                              controller: _pin1Controller,
                              keyboardType: TextInputType.number,
                              maxLength: 1,
                              style: textTheme.bodyMedium,
                              textAlign: TextAlign.center,
                              decoration: textInputDecoration(),
                              onChanged: (val) {
                                if (val.length == 1) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                              onSaved: (pin1) {},
                            ),
                          ),
                          SizedBox(
                            width: 49.w,
                            height: 48.h,
                            child: TextFormField(
                              autofocus: true,
                              controller: _pin2Controller,
                              keyboardType: TextInputType.number,
                              maxLength: 1,
                              style: textTheme.bodyMedium,
                              textAlign: TextAlign.center,
                              decoration: textInputDecoration(),
                              onChanged: (val) {
                                if (val.length == 1) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                              onSaved: (pin2) {},
                            ),
                          ),
                          SizedBox(
                            width: 49.w,
                            height: 48.h,
                            child: TextFormField(
                              autofocus: true,
                              controller: _pin3Controller,
                              keyboardType: TextInputType.number,
                              maxLength: 1,
                              style: textTheme.bodyMedium,
                              textAlign: TextAlign.center,
                              decoration: textInputDecoration(),
                              onChanged: (val) {
                                if (val.length == 1) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                              onSaved: (pin2) {},
                            ),
                          ),
                          SizedBox(
                            width: 49.w,
                            height: 48.h,
                            child: TextFormField(
                              autofocus: true,
                              controller: _pin4Controller,
                              keyboardType: TextInputType.number,
                              maxLength: 1,
                              style: textTheme.bodyMedium,
                              textAlign: TextAlign.center,
                              decoration: textInputDecoration(),
                              onChanged: (val) {
                                if (val.length == 1) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                              onSaved: (pin4) {},
                            ),
                          ),
                          SizedBox(
                            width: 49.w,
                            height: 48.h,
                            child: TextFormField(
                              autofocus: true,
                              controller: _pin5Controller,
                              keyboardType: TextInputType.number,
                              maxLength: 1,
                              style: textTheme.bodyMedium,
                              textAlign: TextAlign.center,
                              decoration: textInputDecoration(),
                              onChanged: (val) {
                                if (val.length == 1) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                              onSaved: (pin4) {},
                            ),
                          ),
                          SizedBox(
                            width: 49.w,
                            height: 48.h,
                            child: TextFormField(
                              autofocus: true,
                              controller: _pin6Controller,
                              keyboardType: TextInputType.number,
                              maxLength: 1,
                              style: textTheme.bodyMedium,
                              textAlign: TextAlign.center,
                              decoration: textInputDecoration(),
                              onChanged: (val) {
                                if (val.length == 1) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                              onSaved: (pin4) {},
                            ),
                          ),
                        ],
                      ),
                      Dimensions.kVerticalSpaceSmall,
                      _secondsRemaining != 0
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                    'Wait $_secondsRemaining seconds remaining',
                                    // Display the countdown
                                    style: textTheme.labelLarge),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: resentOtp,
                                  child: Text(
                                    'Resend?',
                                    style: textTheme.labelLarge?.copyWith(
                                        color: context.colorScheme.primary,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: .6),
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
                SizedBox(height: 130.h),
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Button(
                        onTap: () async {
                          setState(() => isLoading = true);
                          final String otpCode = _pin1Controller.text +
                              _pin2Controller.text +
                              _pin3Controller.text +
                              _pin4Controller.text +
                              _pin5Controller.text +
                              _pin6Controller.text;
                          ref
                              .read(authProvider.notifier)
                              .emailOtpChecker(EmailOtpCheckerEntities(
                                  email: widget.email, otp: otpCode))
                              .then((res) => res.fold(
                                  (l) => {
                                        setState(() => isLoading = false),
                                        AppAlerts.displaySnackBar(
                                            context, l.message, false),
                                        setState(() => isLoading = false)
                                      },
                                  (r) => {
                                        setState(() => isLoading = false),
                                        nextPage(),
                                        setState(() => isLoading = false)
                                      }));
                        },
                        height: 50.h,
                        child: Row(
                          children: [
                            Dimensions.kSpacer,
                            Text(
                              'Verified',
                              style: textTheme.bodySmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                letterSpacing: .7,
                              ),
                            ),
                            Dimensions.kSpacer,
                            SvgPicture.asset(AppIcon.arrowIcon),
                            const SizedBox(width: 10)
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration textInputDecoration() {
    final colorScheme = context.colorScheme;
    return InputDecoration(
      fillColor: const Color(0xFFFFFFFF),
      filled: true,
      counterText: '',
      // border: OutlineInputBorder(borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(
        borderRadius: Dimensions.kBorderRadiusAllSmallest,
        borderSide: const BorderSide(color: Colors.grey, width: 0.25),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: Dimensions.kBorderRadiusAllSmallest,
        borderSide: BorderSide(color: colorScheme.primary, width: 0.25),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: Dimensions.kBorderRadiusAllSmallest,
        borderSide: BorderSide(color: colorScheme.error),
      ),
      contentPadding: Dimensions.kPaddingAllMedium,
    );
  }

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() => isLoading = true);
    try {
      final authCredential =
          await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
      setState(() => isLoading = false);
      if (authCredential.user != null) {
        nextPage();
      }
    } on FirebaseAuthException catch (e) {
      debugPrint("Exception: ${e.toString()}");
      setState(() => isLoading = false);
    }
  }

  void nextPage() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => CreateNewPassword(
              oldPassword: '',
              title: 'Create your password',
              showOldPassword: false,
              phoneNumber: '',
              email: widget.email,
            )));
  }
}
