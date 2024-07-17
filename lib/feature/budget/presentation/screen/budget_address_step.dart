import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../../budget/budget.dart';

class BudgetAddressStep extends ConsumerStatefulWidget {
  const BudgetAddressStep({super.key});

  @override
  ConsumerState<BudgetAddressStep> createState() =>
      _BudgetAddressStepConsumerState();
}

class _BudgetAddressStepConsumerState extends ConsumerState<BudgetAddressStep> {
  TextEditingController pickupController = TextEditingController();
  TextEditingController dropOffController = TextEditingController();

  static CameraPosition _initialCameraPosition =
      const CameraPosition(target: LatLng(3.140853, 101.693207), zoom: 12);

  late GoogleMapController _controller;

  Directions directions = const Directions();
  bool isDirectionAvailable = true;

  @override
  void initState() {
    super.initState();

    currentLocation();
    initialLocationMark();
  }

  void currentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Location service are disabled");
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if(permission==LocationPermission.denied){
          return Future.error("Location permission are denied");
      }
    }
    if(permission==LocationPermission.deniedForever){
      
    }
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _initialCameraPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 12,
      );
    });
  }

  void initialLocationMark() async {
    LatLng? pickUpGeometry = ref.read(budgetControllerProvider).pickupGeometry;
    LatLng? dropUpGeometry = ref.read(budgetControllerProvider).dropOffGeometry;

    getDirection(pickUpGeometry, dropUpGeometry);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    final pickupAddress = ref.watch(budgetControllerProvider).pickupAddress;
    final dropOffAddress = ref.watch(budgetControllerProvider).dropOffAddress;
    LatLng? pickUpGeometry = ref.watch(budgetControllerProvider).pickupGeometry;
    LatLng? dropUpGeometry =
        ref.watch(budgetControllerProvider).dropOffGeometry;

    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          selectDataTime(),
          // Dimensions.kVerticalSpaceSmall,
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                border: Border.all(color: const Color(0x1AB30205))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                searchTextFormField(
                  locationIcon: AppIcon.pickupLocation,
                  onPressed: () => showAddressModelFunc('pickup'),
                  place: pickupAddress ?? 'Pickup Address',
                ),
                Divider(
                    height: 0.h,
                    indent: 34,
                    endIndent: 16,
                    color: Color(0x1AB30205)),
                searchTextFormField(
                  locationIcon: AppIcon.dropLocation,
                  onPressed: () => showAddressModelFunc('drop_off'),
                  place: dropOffAddress ?? 'Drop off Address',
                ),
                Divider(
                    height: 0.h,
                    indent: 34,
                    endIndent: 16,
                    color: Color(0x1AB30205)),
                Dimensions.kVerticalSpaceSmall,
                SizedBox(
                  height: 250.h,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      GoogleMap(
                        initialCameraPosition: _initialCameraPosition,
                        zoomControlsEnabled: true,
                        myLocationButtonEnabled: false,
                        markers: {
                          if (pickUpGeometry != null)
                            Marker(
                              markerId: const MarkerId('origin'),
                              infoWindow: const InfoWindow(title: 'Origin'),
                              icon: BitmapDescriptor.defaultMarkerWithHue(
                                  BitmapDescriptor.hueGreen),
                              position: pickUpGeometry,
                            ),
                          if (dropUpGeometry != null)
                            Marker(
                              markerId: const MarkerId('destination'),
                              infoWindow:
                                  const InfoWindow(title: 'Destination'),
                              icon: BitmapDescriptor.defaultMarkerWithHue(
                                  BitmapDescriptor.hueRed),
                              position: dropUpGeometry,
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
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: const Color(0xFF1B293D),
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10.r),
                            bottomLeft: Radius.circular(10.r))),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Text('Distance / Travel Time',
                            style: context.textTheme.labelLarge!.copyWith(
                                color: Colors.white, fontSize: 12.sp)),
                        const Spacer(),
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
        ],
      ),
    );
  }

  Widget selectDataTime() {
    final textTheme = context.textTheme;
    final date = ref.watch(budgetControllerProvider).date;
    final time = ref.watch(budgetControllerProvider).time;
    return Container(
      padding: Dimensions.kPaddingAllMedium,
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Budget Booking',
            style:
                textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w400),
          ),
          Dimensions.kVerticalSpaceSmall,
          Column(
            children: [
              CustomDataTimePicker(
                label: date != null
                    ? DateFormat('yyyy-MM-dd').format(date)
                    : 'Select Date',
                icon: AppIcon.calender,
                onTap: () async {
                  DateTime date = await PickDateTime.date(context);
                  ref.read(budgetControllerProvider).setDate(date);
                },
                color: date != null ? false : true,
              ),
              Dimensions.kVerticalSpaceSmaller,
              CustomDataTimePicker(
                label: time != null ? time.format(context) : 'Select Time',
                icon: AppIcon.timer,
                onTap: () async {
                  TimeOfDay time = await PickDateTime.time(context);
                  ref.read(budgetControllerProvider).setTime(time);
                },
                color: time != null ? false : true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget searchTextFormField(
      {required VoidCallback onPressed,
      required String place,
      required String locationIcon}) {
    final textTheme = context.textTheme;
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 58.h,
        child: Row(
          children: [
            Dimensions.kHorizontalSpaceSmall,
            SvgPicture.asset(locationIcon),
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
                            ? const Color(0xFF1B293D)
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
          return SearchLocationScreen(
            label: 'Pickup Address',
            controller: pickupController,
          );
        },
      ).then((value) async => {
            getDirection(
              ref.watch(budgetControllerProvider).pickupGeometry,
              ref.watch(budgetControllerProvider).dropOffGeometry,
            ),
          });
    }
    if (label == 'drop_off') {
      showModalBottomSheet(
        context: context,
        enableDrag: false,
        isDismissible: false,
        isScrollControlled: true,
        builder: (_) {
          return SearchLocationScreen(
            label: 'Drop off Address',
            controller: dropOffController,
          );
        },
      ).then((value) async => {
            getDirection(
              ref.watch(budgetControllerProvider).pickupGeometry,
              ref.watch(budgetControllerProvider).dropOffGeometry,
            ),
          });
    }
  }

  Future<void> getDirection(LatLng? origin, LatLng? destination) async {
    if (origin != null && destination != null) {
      debugPrint(
          '${origin.latitude} ${origin.longitude},${destination.latitude} ${destination.longitude}');
      ref
          .read(budgetProvider.notifier)
          .getDirection(DirectionEntities(
            origin: origin,
            destination: destination,
            key: AppKeys.placeApiKey,
          ))
          .then((res) => res.fold(
              (l) => {},
              (r) => {
                    setState(() => {
                          directions = r,
                          _controller.animateCamera(
                            CameraUpdate.newLatLngBounds(
                                directions.bounds!, 100),
                          ),
                          updateDistance(r.totalDistance!),
                          ref
                              .read(budgetControllerProvider)
                              .setDuration(r.totalDuration!),
                          isDirectionAvailable = false,
                        }),
                  }));
    }
  }

  void updateDistance(String response) async {
    List<String> stringList = response.split(" ");
    double doubleValue = double.parse(stringList[0]);
    int intValue = doubleValue.toInt();
    ref.read(budgetControllerProvider).setDistance(intValue);
  }

// int calcRanks(ranks) {
//   double multiplier = .5;
//   return (multiplier * ranks).round();
// }
}
