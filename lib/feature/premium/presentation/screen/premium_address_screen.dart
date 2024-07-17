import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../../premium/premium.dart';

class PremiumAddressScreen extends ConsumerStatefulWidget {
  const PremiumAddressScreen({super.key});

  @override
  ConsumerState<PremiumAddressScreen> createState() =>
      _PremiumAddressScreenConsumerState();
}

class _PremiumAddressScreenConsumerState
    extends ConsumerState<PremiumAddressScreen> {
  static CameraPosition _initialCameraPosition =
      const CameraPosition(target: LatLng(3.140853, 101.693207), zoom: 12);

  late GoogleMapController _controller;

  PremiumDirections directions = const PremiumDirections();
  bool isDirectionAvailable = true;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  void getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _initialCameraPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 12,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    final pickupAddress = ref.watch(premiumNotifierProvider).pickupAddress;
    final dropOffAddress = ref.watch(premiumNotifierProvider).dropOffAddress;

    final pickupGeometry = ref.watch(premiumNotifierProvider).pickupGeometry;
    final dropOffGeometry = ref.watch(premiumNotifierProvider).dropOffGeometry;
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            dateTimePicker(),
            // Dimensions.kVerticalSpaceSmall,
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10)),
                  border: Border.all(color: const Color(0x1AB30205))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  searchTextFormField(
                    locationIcon: AppIcon.pickupLocation,
                    onPressed: () => showAddressModelFunc('pickup'),
                    place: pickupAddress ?? 'Pickup Address',
                  ),
                  const Divider(
                      height: 0,
                      indent: 34,
                      endIndent: 16,
                      color: Color(0x1AB30205)),

                  searchTextFormField(
                    locationIcon: AppIcon.dropLocation,
                    onPressed: () => showAddressModelFunc('drop_off'),
                    place: dropOffAddress ?? 'Drop off Address',
                  ),
                  const Divider(
                      height: 0,
                      indent: 34,
                      endIndent: 16,
                      color: Color(0x1AB30205)),
                  // Dimensions.kVerticalSpaceSmall,
                  // Row(
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [
                  //     Icon(
                  //       Icons.add,
                  //       size: Dimensions.iconSizeSmallest,
                  //       color: context.colorScheme.primary,
                  //     ),
                  //     Dimensions.kHorizontalSpaceSmaller,
                  //     Text(
                  //       'Additional Drop off',
                  //       style: textTheme.labelLarge?.copyWith(
                  //         color: context.colorScheme.primary,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              height: 250,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  GoogleMap(
                    initialCameraPosition: _initialCameraPosition,
                    zoomControlsEnabled: true,
                    myLocationButtonEnabled: false,
                    markers: {
                      if (pickupGeometry != null)
                        Marker(
                          markerId: const MarkerId('origin'),
                          infoWindow: const InfoWindow(title: 'Origin'),
                          icon: BitmapDescriptor.defaultMarkerWithHue(
                              BitmapDescriptor.hueGreen),
                          position: pickupGeometry,
                        ),
                      if (dropOffGeometry != null)
                        Marker(
                          markerId: const MarkerId('destination'),
                          infoWindow: const InfoWindow(title: 'Destination'),
                          icon: BitmapDescriptor.defaultMarkerWithHue(
                              BitmapDescriptor.hueRed),
                          position: dropOffGeometry,
                        )
                    },
                    polylines: {
                      if (!isDirectionAvailable)
                        Polyline(
                          polylineId: const PolylineId('overview_polyline'),
                          color: Colors.red,
                          width: 5,
                          points: directions.polylinePoints!
                              .map((e) => LatLng(e.latitude, e.longitude))
                              .toList(),
                        ),
                    },
                    onMapCreated: (GoogleMapController controller) =>
                        _controller = controller,
                  ),
                ],
              ),
            ),
            if (!isDirectionAvailable)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                    color: Color(0xFF1B293D),
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10))),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Distance / Travel Time',
                        style: context.textTheme.labelLarge!
                            .copyWith(color: Colors.white, fontSize: 12.sp)),
                    Text(
                      '${directions.totalDistance}/${directions.totalDuration}',
                      style: context.textTheme.labelLarge!.copyWith(
                          fontSize: 12.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget dateTimePicker() {
    final textTheme = context.textTheme;
    final date = ref.watch(premiumNotifierProvider).date;
    final time = ref.watch(premiumNotifierProvider).time;
    return Container(
      padding: Dimensions.kPaddingAllMedium,
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Premium Booking',
            style:
                textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w400),
          ),
          Dimensions.kVerticalSpaceSmall,
          Column(
            children: [
              DateTimePicker(
                label: date != null
                    ? DateFormat('yyyy-MM-dd').format(date)
                    : 'Select Date',
                icon: AppIcon.calender,
                onTap: () async {
                  final date = await PickDateTime.date(context);
                  ref.read(premiumNotifierProvider).setDate(date);
                },
                color: date != null ? false : true,
              ),
              Dimensions.kVerticalSpaceSmaller,
              DateTimePicker(
                label: time != null ? time.format(context) : 'Select Time',
                icon: AppIcon.timer,
                onTap: () async {
                  final time = await PickDateTime.time(context);
                  ref.read(premiumNotifierProvider).setTime(time);
                },
                color: time != null ? false : true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  searchTextFormField(
      {required VoidCallback onPressed,
      required String place,
      required String locationIcon}) {
    final textTheme = context.textTheme;
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 58,
        child: Row(
          children: [
            Dimensions.kHorizontalSpaceSmall,
            SvgPicture.asset(locationIcon),
            Dimensions.kHorizontalSpaceSmall,
            Dimensions.kHorizontalSpaceSmall,
            Expanded(
              child: Opacity(
                opacity:
                    place == 'Pickup Address' || place == 'Drop off Address'
                        ? 0.25
                        : 1,
                child: Text(
                  place,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodySmall?.copyWith(
                    color:
                        place == 'Pickup Address' || place == 'Drop off Address'
                            ? Color(0xFF1B293D)
                            : Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showAddressModelFunc(String label) {
    if (label == 'pickup') {
      showModalBottomSheet(
        context: context,
        enableDrag: false,
        isDismissible: false,
        isScrollControlled: true,
        builder: (_) {
          return const PremiumSearchLocation(label: 'Pickup Address');
        },
      );
    }
    if (label == 'drop_off') {
      showModalBottomSheet(
        context: context,
        enableDrag: false,
        isDismissible: false,
        isScrollControlled: true,
        builder: (_) {
          return const PremiumSearchLocation(label: 'Drop off Address');
        },
      ).then((value) async => {
            getDirection(
              ref.watch(premiumNotifierProvider).pickupGeometry,
              ref.watch(premiumNotifierProvider).dropOffGeometry,
            ),
          });
    }
  }

  Future<void> getDirection(LatLng? origin, LatLng? destination) async {
    debugPrint(
        '${origin?.latitude} ${origin?.longitude},${destination?.latitude} ${destination?.longitude}');
    ref
        .read(premiumProvider.notifier)
        .getDirection(PremiumDirectionEntities(
          origin: origin!,
          destination: destination!,
          key: AppKeys.placeApiKey,
        ))
        .then((res) => res.fold(
            (l) => {},
            (r) => {
                  setState(() => {
                        directions = r,
                        _controller.animateCamera(
                          CameraUpdate.newLatLngBounds(directions.bounds!, 100),
                        ),
                        updateDistance(r.totalDistance!),
                        ref
                            .read(premiumNotifierProvider)
                            .setDuration(r.totalDuration!),
                        isDirectionAvailable = false,
                      }),
                }));
  }

  void updateDistance(String response) async {
    List<String> stringList = response.split(" ");
    double doubleValue = double.parse(stringList[0]);
    int intValue = doubleValue.toInt();
    ref.read(premiumNotifierProvider).setDistance(intValue);
  }

  int calcRanks(ranks) {
    double multiplier = .5;
    return (multiplier * ranks).round();
  }
}
