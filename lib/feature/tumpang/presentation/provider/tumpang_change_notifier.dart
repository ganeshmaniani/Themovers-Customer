import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../core/core.dart';
import '../../../booking/booking.dart';
import '../../../tumpang/tumpang.dart';

class TumpangChangeNotifier extends ChangeNotifier {
  String? _pickupAddress;
  String? _dropOffAddress;
  bool? _isLoading;

  String? _tumpangDescription;

  LatLng? _pickupGeometry;
  LatLng? _dropOffGeometry;
  String? _distance;
  String? _duration;

  DateTime? _date;
  TimeOfDay? _time;

  DateTime? _serviceDate;
  TimeOfDay? _serviceTime;

  int? _serviceType;

  int? _selectVehicleType;
  String? _vehicleSpecification;
  int? _amount;

  File? _pickedImage;

  String? _coupon;

  bool? get isLoading => _isLoading;

  String? get pickupAddress => _pickupAddress;

  String? get dropOffAddress => _dropOffAddress;

  String? get tumpangDescription => _tumpangDescription;

  LatLng? get pickupGeometry => _pickupGeometry;

  LatLng? get dropOffGeometry => _dropOffGeometry;

  String? get distance => _distance;

  String? get duration => _duration;

  DateTime? get date => _date;

  TimeOfDay? get time => _time;

  DateTime? get serviceDate => _serviceDate;

  TimeOfDay? get serviceTime => _serviceTime;

  int? get serviceType => _serviceType;

  int? get selectVehicleType => _selectVehicleType;

  String? get vehicleSpecification => _vehicleSpecification;

  int? get amount => _amount;

  String? get coupon => _coupon;

  File? get pickedImage => _pickedImage;

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

  Future<void> setServiceDate(DateTime? data) async {
    _serviceDate = data;
    notifyListeners();
  }

  Future<void> setServiceTime(TimeOfDay? time) async {
    _serviceTime = time;
    notifyListeners();
  }

  Future<void> setServiceType(int? type) async {
    log(serviceType.toString());
    _serviceType = type;
    notifyListeners();
  }

  Future<void> setTumpangDescription(String? description) async {
    _tumpangDescription = description;
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

  Future<void> setDistance(String? distance) async {
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

  Future<void> setAmount(int? amount) async {
    _amount = amount;
    notifyListeners();
  }

  /// Coupon amount
  Future<void> setCoupon(String? code) async {
    _coupon = code;
    notifyListeners();
  }

  Future<void> setPickedImage(File? image) async {
    _pickedImage = image;
    notifyListeners();
  }

  Future<void> submitTumpangBooking(BuildContext context, WidgetRef ref) async {
    final customerId = SharedPrefs.instance.getInt(AppKeys.userId) ?? 0;

    final date = ref.read(tumpangNotifierProvider).date;
    final time = ref.read(tumpangNotifierProvider).time;
    final distance = ref.read(tumpangNotifierProvider).distance ?? '';

    final pickupAddress = ref.read(tumpangNotifierProvider).pickupAddress ?? '';
    final dropOffAddress =
        ref.read(tumpangNotifierProvider).dropOffAddress ?? '';

    final pickupGeometry = ref.read(tumpangNotifierProvider).pickupGeometry;
    final dropOffGeometry = ref.read(tumpangNotifierProvider).dropOffGeometry;

    final serviceDate = ref.read(tumpangNotifierProvider).serviceDate;
    final serviceTime = ref.read(tumpangNotifierProvider).serviceTime;

    int serviceType = ref.read(tumpangNotifierProvider).serviceType ?? 1;

    File? pickedImage = ref.read(tumpangNotifierProvider).pickedImage;

    final description =
        ref.read(tumpangNotifierProvider).tumpangDescription ?? ' ';

    final dateAndTime = date == null || time == null
        ? DateTime.now().toString()
        : PickDateTime.dateAndTimeFormat(
            date: DateFormat('yyyy-MM-dd').format(date),
            time: time.format(context));
    var serviceDateAndTime = '';
    if (serviceType != 2) {
      serviceDateAndTime = PickDateTime.dateAndTimeFormat(
          date: DateFormat('yyyy-MM-dd').format(serviceDate!),
          time: serviceTime!.format(context));
    } else {
      serviceDateAndTime = '';
    }

    List<String> stringList = distance.split(" ");
    TumpangEntities tumpangEntities = TumpangEntities(
      customerId: customerId,
      serviceType: 4,
      bookingDate: dateAndTime,
      pickupAddress: pickupAddress,
      dropOffAddress: dropOffAddress,
      pickupLatitude: pickupGeometry!.latitude.toString(),
      pickupLongitude: pickupGeometry.longitude.toString(),
      dropLatitude: dropOffGeometry!.latitude.toString(),
      dropLongitude: dropOffGeometry.longitude.toString(),
      distance: stringList[0],
      selectServicePeriod: serviceType == 2 ? '2' : '1',
      serviceDateTimePeriod: serviceDateAndTime,
      description: description,
      profileUpload: pickedImage!,
    );

    ref
        .read(tumpangProvider.notifier)
        .tumpangBooking(tumpangEntities)
        .then((res) => res.fold(
              (l) => {
                AppAlerts.displaySnackBar(
                    context, 'Tumpang Booking failed', false),
                setLoading(false)
              },
              (r) => {
                // AppAlerts.displaySnackBar(
                //     context, 'Tumpang Booking Successfully', true),
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
                                      .read(tumpangNotifierProvider)
                                      .setServiceType(null);
                                  ref
                                      .read(tumpangNotifierProvider)
                                      .setServiceDate(null);
                                  ref
                                      .read(tumpangNotifierProvider)
                                      .setServiceTime(null);
                                  ref
                                      .read(tumpangNotifierProvider)
                                      .setPickupAddress(null);
                                  ref
                                      .read(tumpangNotifierProvider)
                                      .setPickupGeometry(null);
                                  ref
                                      .read(tumpangNotifierProvider)
                                      .setDropOffAddress(null);
                                  ref
                                      .read(tumpangNotifierProvider)
                                      .setDropOffGeometry(null);
                                  ref
                                      .read(tumpangNotifierProvider)
                                      .setDistance(null);
                                  ref
                                      .read(tumpangNotifierProvider)
                                      .setDuration(null);
                                  ref
                                      .read(tumpangNotifierProvider)
                                      .setTumpangDescription(null);
                                  ref
                                      .read(tumpangNotifierProvider)
                                      .setPickedImage(null);
                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                          builder: (_) => BookingDetailScreen(
                                                bookingId: r.toString(),
                                                isTrue: true,
                                                discount: 0,
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
