import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:themovers/feature/budget/data/model/coupon_code_model.dart';

import '../../../../core/core.dart';
import '../../../booking/booking.dart';
import '../../../premium/premium.dart';

class PremiumChangeNotifier extends ChangeNotifier {
  bool? _isLoading = false;
  String? _pickupAddress;
  String? _dropOffAddress;

  LatLng? _pickupGeometry;
  LatLng? _dropOffGeometry;
  int? _distance;
  String? _duration;

  DateTime? _date;
  TimeOfDay? _time;

  int? _selectVehicleType;
  String? _vehicleSpecification;

  PremiumPackage? _premiumPackage;

  Coupon? _couponPackage;

  int? _manPowerCount;

  int? _stairCarry;
  bool? _tailGate;
  int? _longPush = 0;

  List<PremiumLongpushType>? _longPushType = [];

  String? _coupon;

  bool? get isLoading => _isLoading;

  String? get pickupAddress => _pickupAddress;

  String? get dropOffAddress => _dropOffAddress;

  LatLng? get pickupGeometry => _pickupGeometry;

  LatLng? get dropOffGeometry => _dropOffGeometry;

  int? get distance => _distance;

  String? get duration => _duration;

  DateTime? get date => _date;

  TimeOfDay? get time => _time;

  int? get selectVehicleType => _selectVehicleType;

  String? get vehicleSpecification => _vehicleSpecification;

  int? get manPowerCount => _manPowerCount;

  String? get coupon => _coupon;

  int? get stairCarry => _stairCarry;

  bool? get tailGate => _tailGate;

  int? get longPush => _longPush;

  Coupon? get couponPackage => _couponPackage;

  List<PremiumLongpushType>? get longPushType => _longPushType;

  PremiumPackage? get premiumPackage => _premiumPackage;

  Future<void> setLoading(bool isLoading) async {
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
  Future<void> setPickupAddress(String? address) async {
    _pickupAddress = address;
    notifyListeners();
  }

  Future<void> setPickupGeometry(LatLng? latLng) async {
    _pickupGeometry = latLng;
    notifyListeners();
  }

  Future<void> setDropOffAddress(String? address) async {
    _dropOffAddress = address;
    notifyListeners();
  }

  Future<void> setDropOffGeometry(LatLng? latLng) async {
    _dropOffGeometry = latLng;
    notifyListeners();
  }

  Future<void> setDistance(int? distance) async {
    _distance = distance;
    notifyListeners();
  }

  Future<void> setDuration(String? duration) async {
    _duration = duration;
    notifyListeners();
  }

  /// Vehicle Type and Specification and Amount
  Future<void> setVehicleType(int? type) async {
    _selectVehicleType = type;
    notifyListeners();
  }

  Future<void> setVehicleSpecification(String? res) async {
    _vehicleSpecification = res;
    notifyListeners();
  }

  Future<void> setPremiumPackage(PremiumPackage? premiumPackage) async {
    _premiumPackage = premiumPackage;
    notifyListeners();
  }

  /// ManPower Count
  Future<void> setManPowerCount(int? count) async {
    _manPowerCount = count;
    notifyListeners();
  }

  /// Stair Carry is Selected  and Amount
  Future<void> setStairCarry(int? count) async {
    _stairCarry = count;
    notifyListeners();
  }

  /// Tail Gate is Selected  and Amount
  Future<void> setTailGate(bool? isTrueOrFalse) async {
    _tailGate = isTrueOrFalse;
    notifyListeners();
  }

  /// Long Push is Selected and LongPushTypeList
  Future<void> setLongPushIndex(int? index) async {
    _longPush = index;
    notifyListeners();
  }

  Future<void> setLongPushType(List<PremiumLongpushType>? longPush) async {
    _longPushType = longPush;
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

  Future<void> submitPremiumMovingBooking(
      BuildContext context, WidgetRef ref) async {
    final customerId = SharedPrefs.instance.getInt(AppKeys.userId) ?? 0;

    final vehicleType = ref.watch(premiumNotifierProvider).selectVehicleType;

    final pickupAddress =
        ref.watch(premiumNotifierProvider).pickupAddress ?? '';
    final dropOffAddress =
        ref.watch(premiumNotifierProvider).dropOffAddress ?? '';

    final pickupGeometry = ref.watch(premiumNotifierProvider).pickupGeometry;
    final dropOffGeometry = ref.watch(premiumNotifierProvider).dropOffGeometry;

    final date = ref.watch(premiumNotifierProvider).date;
    final time = ref.watch(premiumNotifierProvider).time;

    final budgetPackage = ref.watch(premiumNotifierProvider).premiumPackage;
    final couponPackage = ref.watch(premiumNotifierProvider).couponPackage;
    final longPushType = ref.watch(premiumNotifierProvider).longPushType ?? [];

    int distance = ref.watch(premiumNotifierProvider).distance ?? 0;

    int manPower = ref.watch(premiumNotifierProvider).manPowerCount ?? 0;

    int stairCarry = ref.watch(premiumNotifierProvider).stairCarry ?? 0;
    bool tailGate = ref.watch(premiumNotifierProvider).tailGate ?? false;

    int longPush = ref.watch(premiumNotifierProvider).longPush ?? 0;

    final coupon = ref.watch(premiumNotifierProvider).coupon ?? '';

    List amountList = [
      Calculator.premiumDistanceAmount(distance, budgetPackage),
      Calculator.premiumManpowerAmount(manPower, budgetPackage),
      Calculator.premiumStairCarryAmount(stairCarry, budgetPackage),
      Calculator.premiumTailGateAmount(tailGate, budgetPackage),
      Calculator.premiumLongPushAmount(longPush, longPushType)
    ];

    final dateAndTime = PickDateTime.dateAndTimeFormat(
        date: DateFormat('yyyy-MM-dd').format(date!),
        time: time!.format(context));

    final calculationAmount = Calculator.totalAmount(amountList);
    late double totalAmount = 0;
    late double discount = 0;

    if (couponPackage != null) {
      if (couponPackage.ruleType.toString() == '1') {
        discount = double.parse(couponPackage.rule.toString());
        totalAmount = calculationAmount - discount;
        log(totalAmount.toString());
      } else if (couponPackage.ruleType.toString() == '2') {
        discount =
            (calculationAmount * double.parse(couponPackage.rule.toString())) /
                100;
        totalAmount = calculationAmount - discount;
        log(totalAmount.toString());
      }
    }

    final premiumEntities = PremiumEntities(
      customerId: customerId,
      bookingType: 'Online',
      serviceType: 2,
      bookingDate: dateAndTime,
      pickupAddress: pickupAddress,
      dropOffAddress: dropOffAddress,
      distance: distance.toDouble(),
      vehicleType: vehicleType.toString(),
      amount: double.parse(premiumPackage!.basePrice.toString()),
      pickupLatitude: pickupGeometry!.latitude.toString(),
      pickupLongitude: pickupGeometry.longitude.toString(),
      dropLatitude: dropOffGeometry!.latitude.toString(),
      dropLongitude: dropOffGeometry.longitude.toString(),
      couponCode: coupon,
      manpowerCount: manPower,
      stairCarryCount: stairCarry,
      longPushType: longPush,
      tailGate: tailGate ? 'Yes' : 'No',
      vehicleAmount: amountList[0],
      manpowerAmount: amountList[1],
      stairCarryAmount: amountList[2],
      tailgateAmount: amountList[3],
      longPushAmount: amountList[4],
      totalAmount: totalAmount == 0 ? calculationAmount : totalAmount,
    );
    ref
        .read(premiumProvider.notifier)
        .premiumBooking(premiumEntities)
        .then((res) => res.fold(
              (l) => {
                AppAlerts.displaySnackBar(
                    context, 'Premium Booking failed', false),
                setLoading(false)
              },
              (r) => {
                // AppAlerts.displaySnackBar(
                //     context, 'Premium Booking Successfully', true),
                setLoading(false),
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
                                      .read(premiumNotifierProvider)
                                      .setDate(null);
                                  ref
                                      .read(premiumNotifierProvider)
                                      .setTime(null);
                                  ref
                                      .read(premiumNotifierProvider)
                                      .setPickupAddress(null);
                                  ref
                                      .read(premiumNotifierProvider)
                                      .setDropOffAddress(null);
                                  ref
                                      .read(premiumNotifierProvider)
                                      .setPickupGeometry(null);
                                  ref
                                      .read(premiumNotifierProvider)
                                      .setDropOffGeometry(null);
                                  ref
                                      .read(premiumNotifierProvider)
                                      .setDistance(null);
                                  ref
                                      .read(premiumNotifierProvider)
                                      .setDuration(null);
                                  ref
                                      .read(premiumNotifierProvider)
                                      .setVehicleSpecification(null);
                                  ref
                                      .read(premiumNotifierProvider)
                                      .setVehicleType(null);
                                  ref
                                      .read(premiumNotifierProvider)
                                      .setStairCarry(null);
                                  ref
                                      .read(premiumNotifierProvider)
                                      .setLongPushType(null);
                                  ref
                                      .read(premiumNotifierProvider)
                                      .setLongPushIndex(null);
                                  ref
                                      .read(premiumNotifierProvider)
                                      .setTailGate(null);
                                  ref
                                      .read(premiumNotifierProvider)
                                      .setCoupon(null);
                                  ref
                                      .read(premiumNotifierProvider)
                                      .setCouponPackage(null);
                                  ref
                                      .read(premiumNotifierProvider)
                                      .setPremiumPackage(null);
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
                )
              },
            ));
  }
}
