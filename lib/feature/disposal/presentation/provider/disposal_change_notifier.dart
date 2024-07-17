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
import '../../../disposal/disposal.dart';

class DisposalChangeNotifier extends ChangeNotifier {
  String? _location;
  LatLng? _locationGeometry;
  bool? _isLoading = false;

  DateTime? _date;
  TimeOfDay? _time;

  int? _selectVehicleType;
  String? _vehicleSpecification;

  DisposalPackage? _disposalPackage;
  Coupon? _couponPackage;

  String? _coupon;

  bool? get isLoading => _isLoading;

  String? get location => _location;

  LatLng? get locationGeometry => _locationGeometry;

  DateTime? get date => _date;

  TimeOfDay? get time => _time;

  int? get selectVehicleType => _selectVehicleType;

  String? get vehicleSpecification => _vehicleSpecification;

  DisposalPackage? get disposalPackage => _disposalPackage;

  Coupon? get couponPackage => _couponPackage;

  String? get coupon => _coupon;

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
  Future<void> setLocation(String? address) async {
    _location = address;
    notifyListeners();
  }

  Future<void> setLocationGeometry(LatLng? latLng) async {
    _locationGeometry = latLng;
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

  Future<void> setDisposalPackage(DisposalPackage? disposalPackage) async {
    _disposalPackage = disposalPackage;
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

  Future<void> submitDisposalMovingBooking(
      BuildContext context, WidgetRef ref) async {
    final customerId = SharedPrefs.instance.getInt(AppKeys.userId) ?? 0;

    final date = ref.read(disposalNotifierProvider).date;
    final time = ref.read(disposalNotifierProvider).time;

    final location = ref.read(disposalNotifierProvider).location ?? '';

    final locationGeometry =
        ref.read(disposalNotifierProvider).locationGeometry;

    final vehicleType =
        ref.read(disposalNotifierProvider).selectVehicleType ?? 0;

    final disposalPackage = ref.read(disposalNotifierProvider).disposalPackage;
    final couponPackage = ref.read(disposalNotifierProvider).couponPackage;
    final coupon = ref.read(disposalNotifierProvider).coupon ?? '';

    final calculationAmount =
        double.parse(disposalPackage!.basePrice.toString());
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

    final dateAndTime = PickDateTime.dateAndTimeFormat(
        date: DateFormat('yyyy-MM-dd').format(date!),
        time: time!.format(context));

    final disposalEntities = DisposalEntities(
      customerId: customerId ?? 1,
      serviceType: '3',
      bookingDate: dateAndTime,
      location: location,
      vehicleType: vehicleType.toString(),
      amount: calculationAmount,
      latitude: locationGeometry!.latitude.toString(),
      longitude: locationGeometry.longitude.toString(),
      couponCode: coupon,
      totalAmount: totalAmount == 0 ? calculationAmount : totalAmount,
    );

    ref
        .read(disposalProvider.notifier)
        .disposalBookingSubmit(disposalEntities)
        .then((res) => res.fold(
              (l) => {
                AppAlerts.displaySnackBar(
                    context, 'Disposal Booking failed', false),
                setLoading(false)
              },
              (r) => {
                // AppAlerts.displaySnackBar(
                //     context, 'Disposal Booking Successfully', true),
                setLoading(false),
                log(totalAmount.toString()),
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
                                      .read(disposalNotifierProvider)
                                      .setDate(null);
                                  ref
                                      .read(disposalNotifierProvider)
                                      .setTime(null);
                                  ref
                                      .read(disposalNotifierProvider)
                                      .setLocation(null);
                                  ref
                                      .read(disposalNotifierProvider)
                                      .setLocationGeometry(null);
                                  ref
                                      .read(disposalNotifierProvider)
                                      .setVehicleType(null);
                                  ref
                                      .read(disposalNotifierProvider)
                                      .setVehicleSpecification(null);
                                  ref
                                      .read(disposalNotifierProvider)
                                      .setCouponPackage(null);
                                  ref
                                      .read(disposalNotifierProvider)
                                      .setCoupon(null);
                                  ref
                                      .read(disposalNotifierProvider)
                                      .setDisposalPackage(null);
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (_) => BookingDetailScreen(
                                              discount: discount,
                                              bookingId: r.toString(),
                                              isTrue: true)));
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
