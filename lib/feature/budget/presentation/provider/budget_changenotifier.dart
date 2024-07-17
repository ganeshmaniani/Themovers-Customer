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
import '../../../budget/budget.dart';

class BudgetController extends ChangeNotifier {
  String? _couponCode;
  double? _discount;

  String? get couponCode => _couponCode;

  double? get discount => _discount;

  void clearCoupon(String? couponCode, double? discount) {
    couponCode = _couponCode;
    discount = _discount;

    notifyListeners();
  }

  bool? _isLoading = false;

  DateTime? _date;
  TimeOfDay? _time;

  String? _pickupAddress;
  String? _dropOffAddress;

  LatLng? _pickupGeometry;
  LatLng? _dropOffGeometry;

  int? _distance;
  String? _duration;

  int? _selectVehicleType;
  String? _vehicleSpecification;

  BudgetPackage? _budgetPackage;

  Coupon? _couponPackage;

  int? _manPowerCount;
  int? _boxCount;

  int? _shrinkWrap;
  int? _bubbleWrap;

  int? _diningTable;
  int? _officeTable;
  int? _bed;
  int? _wardrobe;

  bool? _insurance;
  int? _stairCarry;
  bool? _tailGate;

  int? _longPush = 0;
  List<LongpushType>? _longPushType = [];

  String? _coupon;

  bool? get isLoading => _isLoading;

  DateTime? get date => _date;

  TimeOfDay? get time => _time;

  String? get pickupAddress => _pickupAddress;

  String? get dropOffAddress => _dropOffAddress;

  LatLng? get pickupGeometry => _pickupGeometry;

  LatLng? get dropOffGeometry => _dropOffGeometry;

  int? get distance => _distance;

  String? get duration => _duration;

  int? get selectVehicleType => _selectVehicleType;

  String? get vehicleSpecification => _vehicleSpecification;

  BudgetPackage? get budgetPackage => _budgetPackage;

  Coupon? get couponPackage => _couponPackage;

  int? get manPowerCount => _manPowerCount;

  int? get boxCount => _boxCount;

  int? get shrinkWrap => _shrinkWrap;

  int? get bubbleWrap => _bubbleWrap;

  int? get diningTable => _diningTable;

  int? get officeTable => _officeTable;

  int? get bed => _bed;

  int? get wardrobe => _wardrobe;

  bool? get insurance => _insurance;

  int? get stairCarry => _stairCarry;

  bool? get tailGate => _tailGate;

  int? get longPush => _longPush;

  List<LongpushType>? get longPushType => _longPushType;

  String? get coupon => _coupon;

  Future<void> setLoading(bool isLoading) async {
    _isLoading = isLoading;
    notifyListeners();
  }

  /// Date and Time

  Future<void> setDate(DateTime? data) async {
    _date = data;
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

  /// Vehicle Type and Specification and Budget Moving Amount List
  Future<void> setVehicleType(int? type) async {
    _selectVehicleType = type;
    notifyListeners();
  }

  Future<void> setVehicleSpecification(String? res) async {
    _vehicleSpecification = res;
    notifyListeners();
  }

  Future<void> setBudgetMoving(BudgetPackage? data) async {
    _budgetPackage = data;
    notifyListeners();
  }

  /// Additional Services
  /// Man Power Count and Amount
  Future<void> setManPowerCount(int? count) async {
    _manPowerCount = count;
    notifyListeners();
  }

  /// Box Count and Amount
  Future<void> setBoxCount(int? count) async {
    _boxCount = count;
    notifyListeners();
  }

  /// Wrapping count and amount
  Future<void> setShrinkWrap(int? count) async {
    _shrinkWrap = count;
    notifyListeners();
  }

  Future<void> setBubbleWrap(int? count) async {
    _bubbleWrap = count;
    notifyListeners();
  }

  /// Assembly Disassembly count and amount
  Future<void> setDiningTable(int? count) async {
    _diningTable = count;
    notifyListeners();
  }

  Future<void> setOfficeTable(int? count) async {
    _officeTable = count;
    notifyListeners();
  }

  Future<void> setBed(int? count) async {
    _bed = count;
    notifyListeners();
  }

  Future<void> setWardrobe(int? count) async {
    _wardrobe = count;
    notifyListeners();
  }

  /// Insurance is Selected  and Amount
  Future<void> setInsurance(bool isTrueOrFalse) async {
    _insurance = isTrueOrFalse;
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

  Future<void> setLongPushType(List<LongpushType>? longPush) async {
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

  Future<void> submitBudgetMovingBooking(
      BuildContext context, WidgetRef ref) async {
    final customerId = SharedPrefs.instance.getInt(AppKeys.userId);

    final date = ref.read(budgetControllerProvider).date;
    final time = ref.read(budgetControllerProvider).time;

    final pickupAddress =
        ref.read(budgetControllerProvider).pickupAddress ?? '';
    final dropOffAddress =
        ref.read(budgetControllerProvider).dropOffAddress ?? '';

    final pickupGeometry = ref.read(budgetControllerProvider).pickupGeometry;
    final dropOffGeometry = ref.read(budgetControllerProvider).dropOffGeometry;

    final selectVehicleType =
        ref.read(budgetControllerProvider).selectVehicleType ?? 0;

    final budgetPackage = ref.read(budgetControllerProvider).budgetPackage;
    final couponPackage = ref.read(budgetControllerProvider).couponPackage;
    final longPushType = ref.read(budgetControllerProvider).longPushType ?? [];

    final distance = ref.read(budgetControllerProvider).distance ?? 0;

    final manPower = ref.read(budgetControllerProvider).manPowerCount ?? 0;
    final box = ref.read(budgetControllerProvider).boxCount ?? 0;

    final shrinkWrap = ref.read(budgetControllerProvider).shrinkWrap ?? 0;
    final bubbleWrap = ref.read(budgetControllerProvider).bubbleWrap ?? 0;

    final diningTable = ref.read(budgetControllerProvider).diningTable ?? 0;
    final bed = ref.read(budgetControllerProvider).bed ?? 0;
    final officeTable = ref.read(budgetControllerProvider).officeTable ?? 0;
    final wardrobe = ref.read(budgetControllerProvider).wardrobe ?? 0;

    final insurance = ref.read(budgetControllerProvider).insurance ?? false;
    final stairCarry = ref.read(budgetControllerProvider).stairCarry ?? 0;
    final tailGate = ref.read(budgetControllerProvider).tailGate ?? false;

    final longPush = ref.watch(budgetControllerProvider).longPush ?? 0;

    final coupon = ref.watch(budgetControllerProvider).coupon ?? '';

    final dateAndTime = PickDateTime.dateAndTimeFormat(
        date: DateFormat('yyyy-MM-dd').format(date!),
        time: time!.format(context));

    final amountList = [
      Calculator.distanceAmount(distance, budgetPackage),
      Calculator.manpowerAmount(manPower, budgetPackage),
      Calculator.boxAmount(box, budgetPackage),
      Calculator.shrinkWrapAmount(shrinkWrap, budgetPackage),
      Calculator.bubbleWrapAmount(bubbleWrap, budgetPackage),
      Calculator.diningTableAmount(diningTable, budgetPackage),
      Calculator.bedAmount(bed, budgetPackage),
      Calculator.officeTableAmount(officeTable, budgetPackage),
      Calculator.wardrobeAmount(wardrobe, budgetPackage),
      Calculator.insuranceAmount(insurance, budgetPackage),
      Calculator.stairCarryAmount(stairCarry, budgetPackage),
      Calculator.tailGateAmount(tailGate, budgetPackage),
      Calculator.longPushAmount(longPush, longPushType)
    ];

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

    final budgetEntities = BudgetEntities(
      customerId: customerId ?? 1,
      bookingType: 'Online',
      serviceType: 1,
      bookingDate: dateAndTime,
      pickupAddress: pickupAddress,
      dropOffAddress: dropOffAddress,
      distance: distance.toDouble(),
      vehicleType: selectVehicleType.toString(),
      amount: double.parse(budgetPackage!.basePrice.toString()),
      pickupLatitude: pickupGeometry!.latitude.toString(),
      pickupLongitude: pickupGeometry.longitude.toString(),
      dropLatitude: dropOffGeometry!.latitude.toString(),
      dropLongitude: dropOffGeometry.longitude.toString(),
      manpowerCount: manPower,
      boxCount: box,
      shrinkWrapping: shrinkWrap == 0 ? "No" : "Yes",
      bubbleWrapping: bubbleWrap == 0 ? "No" : "Yes",
      shrinkWrappingCount: shrinkWrap,
      bubbleWrappingCount: bubbleWrap,
      diningTableCount: diningTable,
      tableCount: officeTable,
      bedsCount: bed,
      wardrobeCount: wardrobe,
      stairCarrCount: stairCarry.toString(),
      tailGateEnabled: tailGate == true ? "Yes" : "No",
      longPushType: longPush,
      insuranceEnabled: insurance == true ? "Yes" : "No",
      couponCode: coupon,
      vehicleAmount: amountList[0],
      manpowerAmount: amountList[1],
      boxAmount: amountList[2],
      shrinkWrapAmount: amountList[3],
      bubbleWrapAmount: amountList[4],
      diningAmount: amountList[5],
      bedAmount: amountList[6],
      tableAmount: amountList[7],
      wardrobeAmount: amountList[8],
      insuranceAmount: amountList[9],
      stairAmount: amountList[10],
      tailgateAmount: amountList[11],
      longPushAmount: amountList[12],
      totalAmount: totalAmount == 0 ? calculationAmount : totalAmount,
      discount: discount,
    );

    ref.read(budgetProvider.notifier).budgetBooking(budgetEntities).then(
          (res) => res.fold(
            (l) => {
              debugPrint(l.message),
              AppAlerts.displaySnackBar(
                  context, 'Budget Booking failed', false),
              setLoading(false),
            },
            (r) => {
              debugPrint(r.toString()),
              // AppAlerts.displaySnackBar(
              //     context, 'Budget Booking Successfully', true),
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
                              textAlign: TextAlign.center,
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
                                    .read(budgetControllerProvider)
                                    .setDate(null);
                                ref
                                    .read(budgetControllerProvider)
                                    .setTime(null);
                                ref
                                    .read(budgetControllerProvider)
                                    .setPickupAddress(null);
                                ref
                                    .read(budgetControllerProvider)
                                    .setDropOffAddress(null);
                                ref
                                    .read(budgetControllerProvider)
                                    .setDistance(null);
                                ref
                                    .read(budgetControllerProvider)
                                    .setDuration(null);
                                ref
                                    .read(budgetControllerProvider)
                                    .setVehicleType(null);
                                ref
                                    .read(budgetControllerProvider)
                                    .setVehicleSpecification(null);
                                ref
                                    .read(budgetControllerProvider)
                                    .setManPowerCount(null);
                                ref
                                    .read(budgetControllerProvider)
                                    .setBoxCount(null);
                                ref
                                    .read(budgetControllerProvider)
                                    .setBubbleWrap(null);
                                ref
                                    .read(budgetControllerProvider)
                                    .setShrinkWrap(null);
                                ref
                                    .read(budgetControllerProvider)
                                    .setDiningTable(null);
                                ref
                                    .read(budgetControllerProvider)
                                    .setOfficeTable(null);
                                ref.read(budgetControllerProvider).setBed(null);
                                ref
                                    .read(budgetControllerProvider)
                                    .setWardrobe(null);
                                ref
                                    .read(budgetControllerProvider)
                                    .setStairCarry(null);
                                ref
                                    .read(budgetControllerProvider)
                                    .setLongPushIndex(null);
                                ref
                                    .read(budgetControllerProvider)
                                    .setLongPushType(null);
                                ref
                                    .read(budgetControllerProvider)
                                    .setCoupon(null);
                                ref
                                    .read(budgetControllerProvider)
                                    .setTailGate(null);
                                ref
                                    .read(budgetControllerProvider)
                                    .setCouponPackage(null);
                                ref
                                    .read(budgetControllerProvider)
                                    .setPickupGeometry(null);
                                ref
                                    .read(budgetControllerProvider)
                                    .setDropOffGeometry(null);
                                ref
                                    .read(budgetControllerProvider)
                                    .setBudgetMoving(null);
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
          ),
        );
  }

  void _showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Container(
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'Thank you for Choosing us.',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
                Text(
                    "The Next immediate Personal Fleet Manager will be in-touch with you in a couple of minutes.",
                    textAlign: TextAlign.center,
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
                      Navigator.of(context).pop();
                    },
                    child: SvgPicture.asset(AppIcon.okeyButton)))
          ],
        );
      },
    );
  }
}
