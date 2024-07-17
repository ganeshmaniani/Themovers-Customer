import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:themovers/config/config.dart';
import 'package:themovers/feature/customer_profile/customer_profile.dart';
import 'package:themovers/feature/dashboard/dashboard.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_keys.dart';
import '../../../../core/utils/app_alerts.dart';
import '../../../../core/utils/input_validation.dart';
import '../../../../core/utils/shared_prefs.dart';
import '../../../../core/widgets/button.dart';

class CustomerProfileUpdate extends ConsumerStatefulWidget {
  final CustomerProfileDetail customerDetails;

  const CustomerProfileUpdate({required this.customerDetails, super.key});

  @override
  ConsumerState<CustomerProfileUpdate> createState() =>
      _CustomerProfileUpdateConsumerState();
}

class _CustomerProfileUpdateConsumerState
    extends ConsumerState<CustomerProfileUpdate> with InputValidationMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController nameController = TextEditingController();
  late TextEditingController emailController = TextEditingController();
  late TextEditingController mobileNumberController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    initiateReq();
  }

  initiateReq() {
    setState(() {
      nameController =
          TextEditingController(text: widget.customerDetails.name ?? '');
      emailController =
          TextEditingController(text: widget.customerDetails.email ?? '');
      mobileNumberController = TextEditingController(
          text: widget.customerDetails.mobileNumber ?? "");
    });
  }

  String countryCode = '+60';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      key: _scaffoldKey,
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              appBar(),
              Expanded(
                flex: 2,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: Dimensions.kPaddingAllMedium,
                  color: context.colorScheme.primary,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Edit Profile',
                          style: textTheme.displayLarge?.copyWith(
                              color: Colors.white,
                              letterSpacing: .7,
                              height: 1.2.h),
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
                          Dimensions.kVerticalSpaceSmallest,
                          TextFormField(
                              controller: nameController,
                              keyboardType: TextInputType.text,
                              enableSuggestions: true,
                              obscureText: false,
                              enableInteractiveSelection: true,
                              style: textTheme.bodyMedium,
                              decoration: textInputDecoration('Full Name')),
                          Dimensions.kVerticalSpaceSmall,
                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            enableSuggestions: true,
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
                                )),
                                child: CountryCodePicker(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  onChanged: (print) {
                                    setState(() {
                                      countryCode = print.dialCode!;
                                      debugPrint(
                                          "Country Code: ${print.dialCode}");
                                    });
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
                                child: SizedBox(
                                  height: 50.h,
                                  child: Baseline(
                                    baseline: 24.0,
                                    baselineType: TextBaseline.alphabetic,
                                    child: TextFormField(
                                      onChanged: (res) {
                                        ref
                                            .read(
                                                customerDetailUpdateNotifierProvider)
                                            .setMobileNumber(res);
                                      },
                                      controller: mobileNumberController,
                                      keyboardType: TextInputType.number,
                                      enableSuggestions: true,
                                      obscureText: false,
                                      enableInteractiveSelection: true,
                                      style: textTheme.bodyMedium,
                                      decoration: InputDecoration(
                                          enabledBorder:
                                              const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0x3FB30205)),
                                          ),
                                          border: const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0x3FB30205)),
                                          ),
                                          focusedBorder:
                                              const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0x3FB30205)),
                                          ),
                                          errorBorder:
                                              const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0x3FB30205)),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 8),
                                          hintText: 'Phone Number',
                                          hintStyle:
                                              textTheme.bodySmall?.copyWith(
                                            color:
                                                context.colorScheme.secondary,
                                          ),
                                          errorStyle: textTheme.labelMedium
                                              ?.copyWith(
                                                  color: context
                                                      .colorScheme.error),
                                          suffixIcon: Transform.scale(
                                            scale: 0.5,
                                            child: SvgPicture.asset(
                                              AppIcon.mobileIcon,
                                            ),
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // const Divider(),
                          const Spacer(),
                          isLoading
                              ? const CircularProgressIndicator()
                              : Button(
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() => isLoading = true);
                                      submitCustomerUpdate();
                                    }
                                  },
                                  height: 50.h,
                                  child: Row(
                                    children: [
                                      Dimensions.kSpacer,
                                      Text(
                                        'Save',
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
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget appBar() {
    return AppBar(
      backgroundColor: const Color(0xFFB40205),
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 16.w),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
                width: 38.w,
                height: 38.h,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: Colors.white),
                child: SvgPicture.asset(
                  AppIcon.backArrowIcon,
                  color: const Color(0xFFB40205),
                )),
          ),
          const Spacer(),
          InkWell(
            onTap: () => _scaffoldKey.currentState!.openDrawer(),
            child: Container(
                width: 38.w,
                height: 38.h,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: Colors.white),
                child: SvgPicture.asset(
                  AppIcon.menus,
                  color: const Color(0xFFB40205),
                )),
          ),
          SizedBox(width: 16.w),
        ],
      ),
    );
  }

  textInputDecoration(String label) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;
    final isName = label == 'Full Name';
    final isEmail = label == 'Email';

    return InputDecoration(
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
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      labelText: label,
      labelStyle: textTheme.bodySmall?.copyWith(
        color: colorScheme.secondary,
      ),
      errorStyle: textTheme.labelMedium?.copyWith(color: colorScheme.error),
      suffixIcon: isName
          ? Transform.scale(
              scale: 0.5, child: SvgPicture.asset(AppIcon.personIcon))
          : isEmail
              ? Transform.scale(
                  scale: 0.5, child: SvgPicture.asset(AppIcon.mailIcon))
              : null,
    );
  }

  Future<void> submitCustomerUpdate() async {
    final id = SharedPrefs.instance.getInt(AppKeys.userId) ?? 0;

    CustomerDetailUpdateEntities customerDetailUpdateEntities =
        CustomerDetailUpdateEntities(
      id: id.toString(),
      customerName: nameController.text,
      emailId: emailController.text,
      mobileNumber: mobileNumberController.text,
    );
    ref
        .read(customerProfileDetailProvider.notifier)
        .customerDetailUpdate(customerDetailUpdateEntities)
        .then((res) => res.fold(
            (l) => {
                  setState(() => isLoading = false),
                  debugPrint(l.message),
                  AppAlerts.displaySnackBar(context, 'Update Failed', false),
                  setState(() => isLoading = false)
                },
            (r) => {
                  setState(() => isLoading = false),
                  AppAlerts.displaySnackBar(
                      context, 'Update SuccessFull', true),
                  Navigator.of(context).pop(),
                  setState(() => isLoading = false)
                }));
  }
}
