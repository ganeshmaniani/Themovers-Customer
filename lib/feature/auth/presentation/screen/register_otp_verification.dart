import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../auth.dart';

class RegisterOTPVerificationScreen extends ConsumerStatefulWidget {
  final RegisterEntities registerEntities;

  final String email;

  // final String countryCode;

  const RegisterOTPVerificationScreen({
    // required this.countryCode,
    super.key,
    required this.registerEntities,
    required this.email,
  });

  @override
  ConsumerState<RegisterOTPVerificationScreen> createState() =>
      _RegisterOTPVerificationScreenState();
}

class _RegisterOTPVerificationScreenState
    extends ConsumerState<RegisterOTPVerificationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var otp1Controller = TextEditingController();
  var otp2Controller = TextEditingController();
  var otp3Controller = TextEditingController();
  var otp4Controller = TextEditingController();
  var otp5Controller = TextEditingController();
  var otp6Controller = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isLoading = false;
  late String verificationId;

  int _secondsRemaining = 15; // Initial countdown duration in seconds
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    getOtpCode();
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

  getOtpCode() {
    ref
        .read(authProvider.notifier)
        .emailOtpGenerator(widget.email)
        .then((res) => res.fold(
            (l) => {
                  setState(() => isLoading = false),
                  AppAlerts.displaySnackBar(context, l.message, false),
                  setState(() => isLoading = false)
                },
            (r) => {}));
  }

  // void requestFireBaseOtp() async {
  //   // debugPrint(widget.phone.toString());
  //
  //   // debugPrint(widget.registerEntities.number);
  //   await FirebaseAuth.instance.verifyPhoneNumber(
  //       phoneNumber: widget.countryCode + widget.phone,
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
  //
  // void signInWithPhoneAuthCredential(
  //     PhoneAuthCredential phoneAuthCredential) async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   try {
  //     final authCredential =
  //         await _auth.signInWithCredential(phoneAuthCredential);
  //     setState(() {
  //       isLoading = false;
  //     });
  //     if (authCredential.user != null) {
  //       setState(() => onSubmit());
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     debugPrint("Exception: ${e.toString()}");
  //     setState(() {
  //       isLoading = false;
  //       // AppAlerts.displaySnackBar(context, e.message.toString(), false);
  //     });
  //   }
  // }

  resentOtp() {
    getOtpCode();
    _secondsRemaining = 15;
    startTimer();
  }

  //
  // @override
  // void dispose() {
  //   // Cancel the timer to avoid memory leaks
  //   _timer.cancel();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
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
                    style: textTheme.labelLarge?.copyWith(
                        color: const Color(0xFF1B293D).withOpacity(0.5)),
                  ),
                ),
                // Dimensions.kVerticalSpaceLarge,
                Form(
                    key: _formKey,
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Dimensions.kVerticalSpaceSmall,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            otpInputFormat(otp1Controller),
                            // const SizedBox(width: 4),
                            otpInputFormat(otp2Controller),
                            // const SizedBox(width: 4),
                            otpInputFormat(otp3Controller),
                            // const SizedBox(width: 4),
                            otpInputFormat(otp4Controller),
                            otpInputFormat(otp5Controller),
                            otpInputFormat(otp6Controller)
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
                                    onTap: () => resentOtp(),
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
                    )),
                SizedBox(height: 130.h),
                isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Button(
                        height: 50.h,
                        onTap: () => verifyEmailOtp()

                        // PhoneAuthCredential phoneAuthCredential =
                        //     PhoneAuthProvider.credential(
                        //         verificationId: verificationId,
                        //         smsCode: otp1Controller.text +
                        //             otp2Controller.text +
                        //             otp3Controller.text +
                        //             otp4Controller.text +
                        //             otp5Controller.text +
                        //             otp6Controller.text);
                        // signInWithPhoneAuthCredential(phoneAuthCredential);
                        ,
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
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }

  otpInputFormat(TextEditingController controller) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = context.colorScheme;
    return SizedBox(
      height: 49.h,
      width: 48.w,
      child: TextFormField(
        maxLength: 1,
        autofocus: true,
        controller: controller,
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
        style: textTheme.bodyMedium,
        decoration: InputDecoration(
          fillColor: const Color(0xFFFFFFFF),
          filled: true,
          counterText: '',
          border: OutlineInputBorder(
              borderRadius: Dimensions.kBorderRadiusAllSmallest),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 0.25),
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
        ),
      ),
    );
  }

  void onSubmitOtp() {
    ref
        .read(authProvider.notifier)
        .register(widget.registerEntities)
        .then((res) => res.fold(
              (l) => {
                setState(() => isLoading = false),
                AppAlerts.displaySnackBar(context, l.message, false),
                Navigator.pop(context),
                setState(() => isLoading = false),
              },
              (r) => {
                setState(() => isLoading = false),
                // AppAlerts.displaySnackBar(
                //     context, 'Registration Successful', true),
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const EmailAuthScreen())),
                setState(() => isLoading = false),
              },
            ));
  }

  verifyEmailOtp() async {
    final String otpCode = otp1Controller.text +
        otp2Controller.text +
        otp3Controller.text +
        otp4Controller.text +
        otp5Controller.text +
        otp6Controller.text;
    setState(() => isLoading = true);
    ref
        .read(authProvider.notifier)
        .emailOtpChecker(EmailOtpCheckerEntities(
            email: widget.registerEntities.email, otp: otpCode))
        .then((res) => res.fold(
            (l) => {
                  setState(() => isLoading = false),
                  AppAlerts.displaySnackBar(context, l.message, false),
                  setState(() => isLoading = false)
                },
            (r) => {
                  setState(() => isLoading = false),
                  onSubmitOtp(),
                  setState(() => isLoading = false)
                }));
  }
}
