import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../auth.dart';

class ForgetPasswordScreen extends ConsumerStatefulWidget {
  final String title;

  const ForgetPasswordScreen({super.key, required this.title});

  @override
  ConsumerState<ForgetPasswordScreen> createState() =>
      _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends ConsumerState<ForgetPasswordScreen>
    with InputValidationMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _emailController = TextEditingController();
  late String phoneNumber = '';
  bool isLoading = false;
  String countryCode = '+60';

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
                      Dimensions.kSpacer,
                      Center(
                        child: Text(
                          widget.title,
                          textAlign: TextAlign.center,
                          style: textTheme.displayLarge?.copyWith(
                              color: Colors.white,
                              letterSpacing: .7,
                              height: 1.2.h,
                              fontSize: 30.sp),
                        ),
                      ),
                      Dimensions.kVerticalSpaceSmaller,
                      Center(
                        child: Text(
                          'Enter your Email to reset',
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
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Dimensions.kVerticalSpaceSmall,
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          enableSuggestions: true,
                          obscureText: false,
                          enableInteractiveSelection: true,
                          style: textTheme.bodyMedium,
                          validator: (email) {
                            if (isEmailValid(email!)) {
                              return null;
                            } else {
                              return 'Enter a valid email address';
                            }
                          },
                          decoration: InputDecoration(
                            suffixIcon: Transform.scale(
                                scale: 0.5,
                                child: SvgPicture.asset(AppIcon.mailIcon)),
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
                            labelText: 'Email',
                            labelStyle: textTheme.bodySmall?.copyWith(
                              color: const Color(0xFF1B293D),
                            ),
                          ),
                        ),

                        // Row(
                        //   children: [
                        //     Container(
                        //       decoration: const BoxDecoration(
                        //         border: Border(
                        //           bottom: BorderSide(
                        //             width: 1,
                        //             color: Color(0x3FB30205),
                        //           ),
                        //         ),
                        //       ),
                        //       child: CountryCodePicker(
                        //         padding:
                        //             const EdgeInsets.symmetric(vertical: 4),
                        //         onChanged: (print) {
                        //           setState(() => countryCode = print.dialCode!);
                        //           debugPrint("Country Code: ${print.dialCode}");
                        //         },
                        //         initialSelection: 'MY',
                        //         favorite: const ['+60', 'MY'],
                        //         flagWidth: 26,
                        //         textStyle: textTheme.bodySmall,
                        //         showFlagDialog: false,
                        //         showCountryOnly: false,
                        //         showOnlyCountryWhenClosed: false,
                        //         alignLeft: false,
                        //       ),
                        //     ),
                        //     const SizedBox(width: 8),
                        //     Expanded(
                        //       child: TextFormField(
                        //         controller: _mobileNumberController,
                        //         keyboardType: TextInputType.number,
                        //         enableSuggestions: true,
                        //         obscureText: false,
                        //         enableInteractiveSelection: true,
                        //         style: textTheme.bodyMedium,
                        //         validator: (name) {
                        //           if (isCheckTextFieldIsEmpty(name!)) {
                        //             return null;
                        //           } else {
                        //             return 'Enter a valid Phone Number';
                        //           }
                        //         },
                        //         decoration: InputDecoration(
                        //           enabledBorder: const UnderlineInputBorder(
                        //             borderSide:
                        //                 BorderSide(color: Color(0x3FB30205)),
                        //           ),
                        //           border: const UnderlineInputBorder(
                        //             borderSide:
                        //                 BorderSide(color: Color(0x3FB30205)),
                        //           ),
                        //           focusedBorder: const UnderlineInputBorder(
                        //             borderSide:
                        //                 BorderSide(color: Color(0x3FB30205)),
                        //           ),
                        //           errorBorder: const UnderlineInputBorder(
                        //             borderSide:
                        //                 BorderSide(color: Color(0x3FB30205)),
                        //           ),
                        //           suffixIcon: Transform.scale(
                        //             scale: 0.5,
                        //             child: SvgPicture.asset(
                        //               AppIcon.mobileIcon,
                        //             ),
                        //           ),
                        //           contentPadding:
                        //               const EdgeInsets.symmetric(horizontal: 8),
                        //           labelText: 'Phone Number',
                        //           labelStyle: textTheme.bodySmall?.copyWith(
                        //             color: context.colorScheme.secondary,
                        //           ),
                        //           errorStyle: textTheme.labelMedium?.copyWith(
                        //               color: context.colorScheme.error),
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // IntlPhoneField(
                        //   controller: _mobileNumberController,
                        //   initialCountryCode: "MY",
                        //   obscureText: false,
                        //   decoration: textInputDecoration('Phone Number'),
                        //   onChanged: (phone) {
                        //     setState(() => phoneNumber = phone.completeNumber);
                        //   },
                        // ),
                        const Spacer(),
                        isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : Button(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() => isLoading = true);
                                    ref
                                        .read(authProvider.notifier)
                                        .validEmailChecker(
                                            _emailController.text)
                                        .then((res) => res.fold(
                                            (l) => {
                                                  setState(
                                                      () => isLoading = false),
                                                  AppAlerts.displaySnackBar(
                                                      context,
                                                      l.message,
                                                      false),
                                                },
                                            (r) => {getOtpValue()}));
                                  }
                                },
                                height: 50.h,
                                child: Row(
                                  children: [
                                    Dimensions.kSpacer,
                                    Text(
                                      'Continue',
                                      style: textTheme.bodySmall?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: .7,
                                      ),
                                    ),
                                    Dimensions.kSpacer,
                                    SvgPicture.asset(AppIcon.arrowIcon),
                                    SizedBox(width: 10.w)
                                  ],
                                ),
                              ),
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

  getOtpValue() {
    ref
        .read(authProvider.notifier)
        .emailOtpGenerator(_emailController.text)
        .then((res) => res.fold(
            (l) => {
                  setState(() => isLoading = false),
                  AppAlerts.displaySnackBar(context, l.message, false),
                  setState(() => isLoading = false)
                },
            (r) => {
                  setState(() => isLoading = false),
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => OtpVerificationScreen(
                                email: _emailController.text,
                              )))),
                  setState(() => isLoading = false),
                }));
  }

// _onSubmit() {
//   ref
//       .read(authProvider.notifier)
//       .validEmailChecker(_emailController.text)
//       .then(
//         (res) => res.fold(
//           (l) => {
//             debugPrint(l.message.toString()),
//             setState(() => isLoading = false),
//             AppAlerts.displaySnackBar(context, l.message.toString(), false)
//           },
//           (r) => {
//             debugPrint(res.toString()),
//             setState(() => isLoading = false),
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (_) => OtpVerificationScreen(
//                           countryCode: countryCode,
//                           mobileNo: _mobileNumberController.text,
//                         )))
//           },
//         ),
//       );
// }
}
