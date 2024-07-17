import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../../disposal/disposal.dart';

class DisposalAddressScreen extends ConsumerStatefulWidget {
  const DisposalAddressScreen({super.key});

  @override
  ConsumerState<DisposalAddressScreen> createState() =>
      _DisposalAddressScreenConsumerState();
}

class _DisposalAddressScreenConsumerState
    extends ConsumerState<DisposalAddressScreen> {
  static const CameraPosition _initialCameraPosition =
      CameraPosition(target: LatLng(3.140853, 101.693207), zoom: 12);

  late GoogleMapController _controller;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  void getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition();

    setState(() {
      _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: ref.read(disposalNotifierProvider).locationGeometry ??
            LatLng(position.latitude, position.longitude),
        zoom: 10,
      )));
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    final location = ref.watch(disposalNotifierProvider).location;
    final locationGeometry =
        ref.watch(disposalNotifierProvider).locationGeometry;

    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            dateTimePicker(),
            Dimensions.kVerticalSpaceSmall,
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
                    onPressed: () => showAddressModelFunc('Pickup Location'),
                    place: location ?? 'Pickup Location',
                  ),
                  const Divider(
                      height: 0,
                      indent: 34,
                      endIndent: 16,
                      color: Color(0x1AB30205)),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              height: 350,
              child: GoogleMap(
                initialCameraPosition: _initialCameraPosition,
                zoomControlsEnabled: true,
                myLocationButtonEnabled: false,
                markers: {
                  if (locationGeometry != null)
                    Marker(
                      markerId: const MarkerId('origin'),
                      infoWindow: const InfoWindow(title: 'Origin'),
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueRed),
                      position: locationGeometry,
                    ),
                },
                onMapCreated: (GoogleMapController controller) =>
                    _controller = controller,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dateTimePicker() {
    final textTheme = context.textTheme;
    final date = ref.watch(disposalNotifierProvider).date;
    final time = ref.watch(disposalNotifierProvider).time;
    return Container(
      padding: Dimensions.kPaddingAllMedium,
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Disposal Service',
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
                  ref.read(disposalNotifierProvider).setDate(date);
                },
                color: date != null ? false : true,
              ),
              Dimensions.kVerticalSpaceSmaller,
              DateTimePicker(
                label: time != null ? time.format(context) : 'Select Time',
                icon: AppIcon.timer,
                onTap: () async {
                  final time = await PickDateTime.time(context);
                  ref.read(disposalNotifierProvider).setTime(time);
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
      {required VoidCallback onPressed, required String place}) {
    final textTheme = context.textTheme;
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 58,
        child: Row(
          children: [
            Dimensions.kHorizontalSpaceSmall,
            SvgPicture.asset(AppIcon.pickupLocation),
            Dimensions.kHorizontalSpaceSmall,
            Expanded(
              child: Opacity(
                opacity: place == 'Pickup Location' ? 0.25 : 1,
                child: Text(
                  place,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodySmall?.copyWith(
                    color: place == 'Pickup Location'
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
    if (label == 'Pickup Location') {
      showModalBottomSheet(
        context: context,
        enableDrag: false,
        isDismissible: false,
        isScrollControlled: true,
        builder: (_) {
          return const DisposalSearchLocation(label: 'Pickup Location');
        },
      ).then((value) => {
            setState(() {
              _controller
                  .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
                target: ref.watch(disposalNotifierProvider).locationGeometry!,
                zoom: 10,
              )));
            }),
          });
    }
  }
}
