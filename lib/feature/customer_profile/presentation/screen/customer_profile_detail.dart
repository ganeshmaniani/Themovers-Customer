import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:themovers/config/config.dart';
import 'package:themovers/core/constants/app_assets.dart';
import 'package:themovers/core/constants/app_keys.dart';
import 'package:themovers/core/utils/shared_prefs.dart';
import 'package:themovers/feature/faq_detail/presentation/screen/faq_screen.dart';
import 'package:themovers/feature/feature.dart';

import '../../../../core/constants/app_url.dart';
import '../../../../core/utils/app_alerts.dart';

class CustomerProfileSettings extends ConsumerStatefulWidget {
  const CustomerProfileSettings({super.key});

  @override
  ConsumerState<CustomerProfileSettings> createState() =>
      _CustomerProfileSettingsConsumerState();
}

class _CustomerProfileSettingsConsumerState
    extends ConsumerState<CustomerProfileSettings> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  int currentState = 1;
  bool isVisible = false;
  String countryCode = '+60';

  CustomerProfileDetail customerProfileDetail = CustomerProfileDetail();

  @override
  void initState() {
    initialCustomerProfileDetail();
    refresh();

    super.initState();
  }

  initialCustomerProfileDetail() {
    setState(() => isLoading = true);

    ref
        .read(customerProfileDetailProvider.notifier)
        .getCustomerProfileDetail()
        .then((res) => res.fold((l) {
              setState(() => {
                    isLoading = false,
                    debugPrint(l.message),
                    isLoading = false,
                  });
            }, (r) {
              setState(() {
                isLoading = false;
                customerProfileDetail = r.customerProfileDetail!;
                isLoading = false;
              });
            }));
  }

  refresh() {
    initialCustomerProfileDetail();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      key: _scaffoldKey,
      appBar: appBar(),
      // appBar: AppBar(
      //   title: Text(
      //     'Settings',
      //     style: textTheme.headlineMedium?.copyWith(color: Colors.white),
      //   ),
      //   leading: InkWell(
      //     onTap: () {
      //       Navigator.pop(context);
      //       Navigator.pop(context);
      //     },
      //     child: const Icon(Icons.arrow_back_sharp, color: Colors.white),
      //   ),
      // ),
      drawer: const CustomDrawer(),
      body: isLoading
          ? const Center(child: SpinKitHourGlass(color: Colors.red))
          : SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: const Color(0xFFB30205),
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(16),
                    height: 250.h,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        customerProfileDetail.profileImage != null
                            ? InkWell(
                                onTap: () => _showSelectionDialog(context),
                                child: Stack(children: [
                                  Container(
                                    alignment: Alignment.center,
                                    height: 147.h,
                                    width: 147.w,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                '${ApiUrl.baseUrl}public/customer_uploads/${customerProfileDetail.profileImage}')),
                                        borderRadius:
                                            BorderRadius.circular(16.r),
                                        border: Border.all(
                                            color: Colors.white, width: 1.w)),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 1,
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(.8),
                                          borderRadius:
                                              BorderRadius.circular(50.r)),
                                      child: const Icon(
                                          Icons.add_a_photo_outlined,
                                          size: 16,
                                          color: Colors.black),
                                    ),
                                  ),
                                ]),
                              )
                            : InkWell(
                                onTap: () {
                                  _showSelectionDialog(context);
                                  // updateCustomerProfileImage();
                                },
                                child: Stack(children: [
                                  Container(
                                      alignment: Alignment.center,
                                      height: 147.h,
                                      width: 147.w,
                                      decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(.8),
                                          borderRadius:
                                              BorderRadius.circular(16.r),
                                          border: Border.all(
                                              color: Colors.white, width: 1.w)),
                                      child: Text(
                                          customerProfileDetail.name
                                              .toString()
                                              .split('')
                                              .first
                                              .toUpperCase(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineLarge!
                                              .copyWith(fontSize: 50.sp))),
                                  Positioned(
                                    bottom: 0,
                                    right: 1,
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(.8),
                                          borderRadius:
                                              BorderRadius.circular(50.r)),
                                      child: const Icon(Icons.add,
                                          size: 20, color: Colors.black),
                                    ),
                                  ),
                                ]),
                              ),
                        // const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            customerProfileDetail.name ?? '',
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: Colors.white,
                                    fontSize: 26.sp,
                                    fontWeight: FontWeight.w700),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(
                                    builder: (context) => CustomerProfileUpdate(
                                        customerDetails:
                                            customerProfileDetail)))
                                .whenComplete(
                                    () => initialCustomerProfileDetail());
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 32.h,
                            width: 118.w,
                            decoration: BoxDecoration(
                                color: const Color(0xFFFFFFFF),
                                borderRadius: BorderRadius.circular(5.r)),
                            child: Text(
                              'Edit Profile',
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  color: const Color(0xFF1B293D)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Email or phone',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                    color: const Color(0xFF1B293D),
                                    fontSize: 10.sp)),
                        SizedBox(height: 4.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(customerProfileDetail.name ?? '',
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(fontSize: 15.sp)),
                            ),
                            SvgPicture.asset(AppIcon.personIcon)
                          ],
                        ),
                        const Divider(color: Color(0x40B30205)),
                        Text('Mobile Number',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                    color: const Color(0xFF1B293D),
                                    fontSize: 10.sp)),
                        SizedBox(height: 4.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("0${customerProfileDetail.mobileNumber}" ?? '',
                                style: Theme.of(context).textTheme.bodySmall),
                            SvgPicture.asset(AppIcon.mobileIcon)
                          ],
                        ),
                        const Divider(color: Color(0x40B30205)),
                        Text('Email Address',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                    color: const Color(0xFF1B293D),
                                    fontSize: 10.sp)),
                        SizedBox(height: 4.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(customerProfileDetail.email ?? '',
                                style: Theme.of(context).textTheme.bodySmall),
                            SvgPicture.asset(AppIcon.mailIcon)
                          ],
                        ),
                        SizedBox(height: 12.h),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => CreateNewPassword(
                                          oldPassword: customerProfileDetail
                                              .plainPassword
                                              .toString(),
                                          title: 'Reset Password',
                                          phoneNumber: customerProfileDetail
                                              .mobileNumber!
                                              .trimRight(),
                                          showOldPassword: true,
                                          email: '',
                                        )));
                          },
                          child: Container(
                              padding: const EdgeInsets.all(8),
                              width: MediaQuery.of(context).size.width,
                              height: 50.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.r),
                                  border: Border.all(
                                      color: const Color(0xFFB30205))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Change Password',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall),
                                  SvgPicture.asset(AppIcon.blackArrowIcon)
                                ],
                              )),
                        ),
                        SizedBox(height: 12.h),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const FAQScreen()));
                          },
                          child: Container(
                              padding: const EdgeInsets.all(8),
                              width: MediaQuery.of(context).size.width,
                              height: 50.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.r),
                                  border: Border.all(
                                      color: const Color(0xFFB30205))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('FAQ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall),
                                  SvgPicture.asset(AppIcon.blackArrowIcon)
                                ],
                              )),
                        ),
                        SizedBox(height: 70.h),
                        InkWell(
                          onTap: () => _showAlertDialog(),
                          child: Center(
                            child: Text('Delete Account Request',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: const Color(0xFFB30205),
                                        decoration: TextDecoration.underline)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  PreferredSizeWidget appBar() {
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
              Navigator.pop(context);
            },
            child: Container(
                width: 38.w,
                height: 38.h,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
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
                    borderRadius: BorderRadius.circular(8),
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

  _showAlertDialog() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: 200.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Are you sure?',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: const Color(0xFF1B293D))),
                Text('The account will delete permanently.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: const Color(0xFFA5A5A5))),
              ],
            ),
          ),
          actions: [
            Row(
              children: [
                InkWell(
                    onTap: () async {
                      final customerId =
                          SharedPrefs.instance.getInt(AppKeys.userId);

                      ref
                          .read(customerProfileDetailProvider.notifier)
                          .customerDeleteAccount(CustomerDeleteAccountEntities(
                              userId: customerId.toString()))
                          .then((res) => res.fold(
                              (l) => {},
                              (r) => {
                                    Navigator.of(context).pop(),
                                    _showCustomDialog(context)
                                  }));
                    },
                    child: SvgPicture.asset(AppIcon.button, width: 110.w)),
                SizedBox(width: 4.w),
                InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: SvgPicture.asset(AppIcon.noButton, width: 110.w)),
              ],
            )
          ],
        );
      },
    );
  }

  void _showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: 200.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Request Successful',
                  style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 20.sp),
                ),
                // Add your custom content here
                SvgPicture.asset(AppIcon.successFull),
              ],
            ),
          ),
          actions: <Widget>[
            Center(
                child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: SvgPicture.asset(AppIcon.okeyButton)))
          ],
        );
      },
    );
  }

  Future<void> _showSelectionDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("From where do you want to take the photo?"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                GestureDetector(
                  child: Row(
                    children: [
                      const Icon(Icons.image),
                      Dimensions.kHorizontalSpaceSmall,
                      const Text("Gallery"),
                    ],
                  ),
                  onTap: () {
                    pickGalleryImage();
                  },
                ),
                const Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: Row(
                    children: [
                      const Icon(Icons.camera),
                      Dimensions.kHorizontalSpaceSmall,
                      const Text("Camera"),
                    ],
                  ),
                  onTap: () {
                    pickCameraImage();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> pickGalleryImage() async {
    final ImagePicker picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      submitProfileImage(File(pickedImage.path));
    }
  }

  Future<void> pickCameraImage() async {
    final ImagePicker picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      submitProfileImage(File(pickedImage.path));
    }
  }

  Future<void> submitProfileImage(File pickImage) async {
    final id = SharedPrefs.instance.getInt(AppKeys.userId) ?? 0;

    // File? pickedImage =
    //     ref.read(customerDetailUpdateNotifierProvider).pickedImage;
    CustomerProfileImageUpdateEntities customerProfileImageUpdateEntities =
        CustomerProfileImageUpdateEntities(id: id, profileImage: pickImage);
    ref
        .read(customerProfileDetailProvider.notifier)
        .customerProfileImageUpdate(customerProfileImageUpdateEntities)
        .then((res) => res.fold(
            (l) => {
                  refresh(),
                  Navigator.pop(context),
                  AppAlerts.displaySnackBar(context, 'Update Failed', false)
                },
            (r) => {
                  refresh(),
                  Navigator.pop(context),
                  AppAlerts.displaySnackBar(context, 'Update SuccessFull', true)
                }));
  }
}
