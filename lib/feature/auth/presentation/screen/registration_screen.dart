import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../auth.dart';

class RegistrationScreen extends ConsumerStatefulWidget {
  const RegistrationScreen({super.key});

  @override
  ConsumerState<RegistrationScreen> createState() =>
      _RegistrationScreenConsumerState();
}

class _RegistrationScreenConsumerState extends ConsumerState<RegistrationScreen>
    with InputValidationMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _conformPasswordController = TextEditingController();

  bool isPasswordHidden = false;
  bool isConformPasswordHidden = false;
  bool isLoading = false;

  bool isEmailAvailable = true;
  bool isMobileNumberAvailable = true;

  String countryCode = '+60';

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        // physics: const NeverScrollableScrollPhysics(),
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
                          'Register',
                          style: textTheme.displayLarge?.copyWith(
                              color: Colors.white,
                              letterSpacing: .7,
                              height: 1.2.h),
                        ),
                      ),
                      Dimensions.kVerticalSpaceSmaller,
                      Center(
                        child: Text(
                          'Create your account',
                          style: textTheme.labelLarge
                              ?.copyWith(color: Colors.white.withOpacity(0.5)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: Dimensions.kPaddingAllMedium,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _fullNameController,
                          keyboardType: TextInputType.text,
                          enableSuggestions: true,
                          obscureText: false,
                          enableInteractiveSelection: true,
                          style: textTheme.bodyMedium,
                          validator: (name) {
                            if (isCheckTextFieldIsEmpty(name!)) {
                              return null;
                            } else {
                              return 'Enter a valid user name';
                            }
                          },
                          decoration: textInputDecoration('Full Name'),
                        ),
                        Dimensions.kVerticalSpaceSmaller,
                        TextFormField(
                          onChanged: (value) {
                            ref
                                .read(authProvider.notifier)
                                .emailChecker(value)
                                .then(
                                  (res) => res.fold(
                                    (l) => {
                                      debugPrint(res.toString()),
                                      setState(() {
                                        isEmailAvailable = false;
                                        _showDialog(l.message);
                                      })
                                    },
                                    (r) => {
                                      debugPrint(res.toString()),
                                      setState(() => isEmailAvailable = true)
                                    },
                                  ),
                                );
                          },
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
                          decoration: textInputDecoration('Email'),
                        ),
                        Dimensions.kVerticalSpaceSmall,

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
                                  setState(() => countryCode = print.dialCode!);
                                  debugPrint("Country Code: ${print.dialCode}");
                                },
                                initialSelection: 'MY',
                                favorite: const ['+60', 'MY'],
                                flagWidth: 26,
                                textStyle: textTheme.bodySmall,
                                showFlagDialog: false,
                                showCountryOnly: false,
                                showOnlyCountryWhenClosed: false,
                                alignLeft: false,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: TextFormField(
                                controller: _mobileNumberController,
                                keyboardType: TextInputType.number,
                                enableSuggestions: true,
                                obscureText: false,
                                enableInteractiveSelection: true,
                                style: textTheme.bodyMedium,
                                validator: (name) {
                                  if (isCheckTextFieldIsEmpty(name!)) {
                                    return null;
                                  } else {
                                    return 'Enter a valid Phone Number';
                                  }
                                },
                                decoration: InputDecoration(
                                    enabledBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0x3FB30205)),
                                    ),
                                    border: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0x3FB30205)),
                                    ),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0x3FB30205)),
                                    ),
                                    errorBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0x3FB30205)),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    hintText: '123456789',
                                    // hintStyle: textTheme.bodySmall?.copyWith(
                                    //   color: context.colorScheme.secondary,
                                    // ),
                                    errorStyle: textTheme.labelMedium?.copyWith(
                                        color: context.colorScheme.error),
                                    suffixIcon: Transform.scale(
                                      scale: 0.5,
                                      child: SvgPicture.asset(
                                        AppIcon.mobileIcon,
                                      ),
                                    )),
                                onChanged: (value) {
                                  ref
                                      .read(authProvider.notifier)
                                      .phoneNoChecker(value)
                                      .then(
                                        (res) => res.fold(
                                          (l) => {
                                            debugPrint(res.toString()),
                                            setState(() {
                                              isMobileNumberAvailable = false;
                                              _showDialog(l.message);
                                            })
                                          },
                                          (r) => {
                                            debugPrint(res.toString()),
                                            setState(() =>
                                                isMobileNumberAvailable = true)
                                          },
                                        ),
                                      );
                                },
                              ),
                            ),
                          ],
                        ),

                        Dimensions.kVerticalSpaceSmaller,
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
                        Dimensions.kVerticalSpaceSmaller,
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
                          decoration: textInputDecoration('Confirm Password'),
                        ),
                        Dimensions.kVerticalSpaceMedium,

                        const Spacer(),
                        isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : Button(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() => isLoading = true);

                                    RegisterEntities registerEntities =
                                        RegisterEntities(
                                      name: _fullNameController.text,
                                      email: _emailController.text,
                                      number: _mobileNumberController.text,
                                      password: _passwordController.text,
                                    );
                                    // ref
                                    //     .read(authProvider.notifier)
                                    //     .emailOtpGenerator(
                                    //     _emailController.text)
                                    //     .then((res) =>
                                    //     res.fold(
                                    //             (l) =>
                                    //         {
                                    //           setState(
                                    //                   () => isLoading = false),
                                    //           AppAlerts.displaySnackBar(
                                    //               context,
                                    //               l.message,
                                    //               false),
                                    //           setState(
                                    //                   () => isLoading = false)
                                    //         },
                                    //             (r) =>
                                    //         {
                                    //           setState(
                                    //                   () => isLoading = false),
                                    //
                                    //
                                    //           Navigator.push(
                                    //               context,
                                    //               MaterialPageRoute(
                                    //                   builder: ((context) =>
                                    //                       RegisterOTPVerificationScreen(
                                    //                         email:
                                    //                             _emailController
                                    //                                 .text,
                                    //                         registerEntities:
                                    //                             registerEntities,
                                    //                       )))),
                                    //           setState(
                                    //                   () => isLoading = false),
                                    //         }));
                                    ref
                                        .read(authProvider.notifier)
                                        .register(registerEntities)
                                        .then((res) => res.fold(
                                            (l) => {
                                                  AppAlerts.displaySnackBar(
                                                      context, l.message, false)
                                                },
                                            (r) => {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const EmailAuthScreen()))
                                                }));

                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             RegisterOTPVerificationScreen(
                                    //               countryCode: countryCode,
                                    //               phone: _mobileNumberController.text
                                    //                   .toString()
                                    //                   .trim(),
                                    //               registerEntities: registerEntities,
                                    //             )));
                                  }
                                },
                                height: 50.h,
                                child: Row(
                                  children: [
                                    Dimensions.kSpacer,
                                    Text(
                                      'Register',
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
                        Dimensions.kVerticalSpaceLarger,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "I have an account - ",
                              style: textTheme.labelLarge?.copyWith(
                                color: context.colorScheme.secondary,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            const EmailAuthScreen()));
                              },
                              child: Text(
                                "Login",
                                style: textTheme.labelLarge?.copyWith(
                                  color: const Color(0xFF1B293D),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Dimensions.kVerticalSpaceSmallest,
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
    final isName = label == 'Full Name';
    final isEmail = label == 'Email';

    final isCheckPassword = label == "Password";
    final isCheckConformPassword = label == "Confirm Password";
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
                    : SvgPicture.asset(AppIcon.lock),
              )
            : isCheckConformPassword
                ? IconButton(
                    onPressed: () => setState(() =>
                        isConformPasswordHidden = !isConformPasswordHidden),
                    icon: isConformPasswordHidden
                        ? Icon(
                            Icons.lock_open,
                            color: colorScheme.primary,
                          )
                        : SvgPicture.asset(AppIcon.lock))
                : isName
                    ? Transform.scale(
                        scale: 0.5, child: SvgPicture.asset(AppIcon.personIcon))
                    : isEmail
                        ? Transform.scale(
                            scale: 0.5,
                            child: SvgPicture.asset(AppIcon.mailIcon))
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
        contentPadding: const EdgeInsets.all(0),
        labelText: label,
        labelStyle: textTheme.bodySmall?.copyWith(
          color: colorScheme.secondary,
        ),
        errorStyle: textTheme.labelMedium?.copyWith(color: colorScheme.error));
  }

  void _showDialog(String content) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          // title: Text(
          //   title,
          //   style: const TextStyle(color: Colors.red),
          // ),
          content: Text(
            content,
            style: const TextStyle(color: Colors.red),
          ),
          actions: [
            // usually buttons at the bottom of the dialog
            ElevatedButton(
              child: const Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
