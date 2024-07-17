import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../core/core.dart';
import '../../../booking/booking.dart';
import '../../../budget/data/model/coupon_code_model.dart';
import '../../../manpower/manpower.dart';

class ManpowerChangeNotifier extends ChangeNotifier {
  int? _manPower = 2;
  int? _serviceHour = 2;
  bool? _isSelectDay = false;

  bool? _isLoading = false;

  ManpowerPackage? _manpowerPackage;
  ManpowerPackageModel? _manpowerPackageModel;

  Coupon? _couponPackage;

  String? _manPowerDescription = '';

  String? _location;

  DateTime? _date;
  TimeOfDay? _time;

  LatLng? _locationGeometry;

  String? _coupon;

  bool? get isLoading => _isLoading;

  ManpowerPackage? get manpowerPackage => _manpowerPackage;

  ManpowerPackageModel? get manpowerPackageModel => _manpowerPackageModel;

  Coupon? get couponPackage => _couponPackage;

  int? get manPower => _manPower;

  int? get serviceHour => _serviceHour;

  bool? get isSelectDay => _isSelectDay;

  String? get manPowerDescription => _manPowerDescription;

  String? get location => _location;

  DateTime? get date => _date;

  TimeOfDay? get time => _time;

  LatLng? get locationGeometry => _locationGeometry;

  String? get coupon => _coupon;

  Future<void> setLoading(bool? isLoading) async {
    _isLoading = isLoading;
    notifyListeners();
  }

  /// Date and Time

  Future<void> setDate(DateTime? date) async {
    _date = date;
    notifyListeners();
  }

  Future<void> setTime(TimeOfDay? time) async {
    _time = time;
    notifyListeners();
  }

  /// Pickup & Drop off Address and Pickup & Drop off Geometry and Distance & Duration
  Future<void> setLocation(String? address) async {
    _location = address;
    notifyListeners();
  }

  Future<void> setLocationGeometry(LatLng? latLng) async {
    _locationGeometry = latLng;
    notifyListeners();
  }

  /// Additional Services
  /// Man Power Count and Amount
  Future<void> setManPowerCount(int? count) async {
    _manPower = count;
    notifyListeners();
  }

  Future<void> setServiceHour(int? count) async {
    _serviceHour = count;
    notifyListeners();
  }

  Future<void> setIsSelectDay(bool? val) async {
    _isSelectDay = val;
    notifyListeners();
  }

  Future<void> setManpowerPackage(ManpowerPackage? package) async {
    _manpowerPackage = package;
    notifyListeners();
  }

  Future<void> setManPowerDescription(String? description) async {
    _manPowerDescription = description;
    notifyListeners();
  }

  /// Coupon amount
  Future<void> setCoupon(String? code) async {
    _coupon = code;
    notifyListeners();
  }

  Future<void> setCouponPackage(Coupon? coupon) async {
    _couponPackage = coupon;
    notifyListeners();
  }

  Future<void> setDefaultValue(
      ManpowerPackageModel manpowerPackageModel) async {
    _manpowerPackageModel = manpowerPackageModel;
    notifyListeners();
  }

  /// Disposal Booking
  Future<void> submitDisposalMovingBooking(
      BuildContext context, WidgetRef ref) async {
    final customerId = SharedPrefs.instance.getInt(AppKeys.userId) ?? 0;
    final manpowerPackageModel =
        ref.watch(manpowerNotifierProvider).manpowerPackageModel;

    final defaultAmount = manpowerPackageModel?.defaultManpowerAmount ?? 0;

    final date = ref.read(manpowerNotifierProvider).date;
    final time = ref.read(manpowerNotifierProvider).time;

    final location = ref.read(manpowerNotifierProvider).location ?? ' ';

    final locationGeometry =
        ref.read(manpowerNotifierProvider).locationGeometry;

    final manpowerCount = ref.read(manpowerNotifierProvider).manPower ?? 0;
    final hoursCount = ref.read(manpowerNotifierProvider).serviceHour ?? 0;

    final manpowerPackage = ref.read(manpowerNotifierProvider).manpowerPackage;
    final couponPackage = ref.read(manpowerNotifierProvider).couponPackage;
    final serviceHour = ref.read(manpowerNotifierProvider).serviceHour;

    bool isSelect = ref.read(manpowerNotifierProvider).isSelectDay ?? false;
    final coupon = ref.read(manpowerNotifierProvider).coupon ?? '';
    final description =
        ref.read(manpowerNotifierProvider).manPowerDescription ?? '';

    final dateAndTime = PickDateTime.dateAndTimeFormat(
        date: DateFormat('yyyy-MM-dd').format(date!),
        time: time!.format(context));
    double calculationAmount = isSelect
        ? Calculator.serviceFullDayAmount(manpowerPackage) + defaultAmount
        : Calculator.serviceHourAmount(serviceHour, manpowerPackage) +
            defaultAmount;

    log(defaultAmount.toString());
    double totalAmount = calculationAmount;
    double discount = 0;

    if (couponPackage != null) {
      if (couponPackage.ruleType.toString() == '1') {
        discount = double.parse(couponPackage.rule.toString());
        totalAmount = totalAmount - discount;
        log(totalAmount.toString());
      } else if (couponPackage.ruleType.toString() == '2') {
        discount =
            (calculationAmount * double.parse(couponPackage.rule.toString())) /
                100;
        totalAmount = totalAmount - discount;
        log(totalAmount.toString());
      }
    }

    final manpowerEntities = ManpowerEntities(
      customerId: customerId,
      serviceType: 5,
      bookingDate: dateAndTime,
      pickUpAddress: location,
      pickUpLatitude: locationGeometry!.latitude.toString(),
      pickUpLongitude: locationGeometry.longitude.toString(),
      totalAmount: totalAmount,
      manpowerCount: manpowerCount,
      couponCode: coupon,
      serviceHour: isSelect ? '5' : hoursCount.toString(),
      description: description,
      amount: calculationAmount,
    );

    ref
        .read(manpowerProvider.notifier)
        .manpowerBooking(manpowerEntities)
        .then((res) => res.fold(
              (l) => {
                AppAlerts.displaySnackBar(
                    context, 'Manpower Booking failed', false),
                setLoading(false)
              },
              (r) => {
                // AppAlerts.displaySnackBar(
                //     context, 'Manpower Booking Successfully', true),
                setLoading(false),
                log(totalAmount.toString()),
                log(calculationAmount.toString()),
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Colors.white,
                      content: SizedBox(
                        height: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              'Thank you for Choosing us.',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                            Text(
                                "The Next immediate Personal Fleet Manager will be in-touch with you in a couple of minutes.",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFFA5A5A5),
                                )),
                            // Add your custom content here
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        Center(
                            child: InkWell(
                                onTap: () {
                                  ref
                                      .read(manpowerNotifierProvider)
                                      .setCouponPackage(null);
                                  ref
                                      .read(manpowerNotifierProvider)
                                      .setDate(null);
                                  ref
                                      .read(manpowerNotifierProvider)
                                      .setManPowerCount(null);
                                  ref
                                      .read(manpowerNotifierProvider)
                                      .setTime(null);
                                  ref
                                      .read(manpowerNotifierProvider)
                                      .setLocation(null);
                                  ref
                                      .read(manpowerNotifierProvider)
                                      .setServiceHour(null);
                                  ref
                                      .read(manpowerNotifierProvider)
                                      .setCoupon(null);
                                  ref
                                      .read(manpowerNotifierProvider)
                                      .setManPowerDescription(null);
                                  ref
                                      .read(manpowerNotifierProvider)
                                      .setManpowerPackage(null);
                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                          builder: (_) => BookingDetailScreen(
                                                bookingId: r.toString(),
                                                isTrue: true,
                                                discount: discount,
                                              )));
                                },
                                child: SvgPicture.asset(AppIcon.okeyButton)))
                      ],
                    );
                  },
                ),
              },
            ));
  }
}
