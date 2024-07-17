import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../config/config.dart';
import '../../../../../core/core.dart';
import '../../../../premium/premium.dart';

class PremiumSearchLocation extends ConsumerStatefulWidget {
  final String label;

  const PremiumSearchLocation({super.key, required this.label});

  @override
  ConsumerState<PremiumSearchLocation> createState() =>
      _PremiumSearchLocationConsumerState();
}

class _PremiumSearchLocationConsumerState
    extends ConsumerState<PremiumSearchLocation> {
  bool isLoading = false;

  List<PredictionsList> predictionsList = [];
  List<PremiumGeocodeList> geocodeList = [];

  var latitude = '';
  var longitude = '';
  late StreamSubscription<Position> streamSubscription;

  late TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    initialPlaceDetails();
  }

  void initialPlaceDetails() async {
    final pickupAddress = ref.read(premiumNotifierProvider).pickupAddress ?? '';
    final dropOffAddress =
        ref.read(premiumNotifierProvider).dropOffAddress ?? '';
    final place =
        widget.label == 'Pickup Address' ? pickupAddress : dropOffAddress;
    controller = TextEditingController(text: place);
    placesAutoComplete(place);
  }

  /// Search the Place
  void placesAutoComplete(String query) async {
    setState(() => isLoading = true);
    ref
        .read(premiumProvider.notifier)
        .autoCompletePlaceList(
          PremiumPlaceEntities(query: query, key: AppKeys.placeApiKey),
        )
        .then((res) => res.fold(
            (l) => {
                  predictionsList = [],
                  setState(() => isLoading = false),
                },
            (r) => {
                  predictionsList = r.predictionsList ?? [],
                  setState(() => isLoading = false),
                }));
  }

  /// PlaceId To Get Latitude Longitude
  void placeIdToGeocode(String placeId) async {
    ref
        .read(premiumProvider.notifier)
        .placeToGeocode(PremiumPlaceToGeocodeEntities(
            placeId: placeId, key: AppKeys.placeApiKey))
        .then((res) => res.fold(
            (l) => {
                  geocodeList = [],
                },
            (r) => {
                  geocodeList = r.geocode ?? [],
                  getLatLong(geocodeList),
                }));
  }

  void getLatLong(List<PremiumGeocodeList> geocode) {
    PremiumGeometry val = geocode[0].geometry!;

    if (widget.label == 'Pickup Address') {
      setState(() => {
            ref.read(premiumNotifierProvider).setPickupGeometry(
                LatLng(val.location!.lat!, val.location!.lng!)),
            Navigator.pop(context)
          });
    }
    if (widget.label == 'Drop off Address') {
      setState(() => {
            ref.read(premiumNotifierProvider).setDropOffGeometry(
                LatLng(val.location!.lat!, val.location!.lng!)),
            Navigator.pop(context)
          });

      debugPrint("${val.location!.lat!}, ${val.location!.lng!}");
    }
  }

  /// Your Current Location
  getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    late LocationPermission permission;
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location Services are disabled');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location Permission are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          "Location Permission are Permanently denied, we can't request permission.");
    }

    streamSubscription =
        Geolocator.getPositionStream().listen((Position position) {
      latitude = 'Latitude: ${position.latitude}';
      longitude = 'Longitude: ${position.longitude}';
      debugPrint("$latitude $longitude");
      // getAddressFromLatLang(position);
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: 100,
            padding: const EdgeInsets.fromLTRB(16, 40, 16, 6),
            color: context.colorScheme.primary,
            child: Row(
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.arrow_back_sharp,
                    color: Colors.white,
                  ),
                ),
                Dimensions.kHorizontalSpaceSmaller,
                Expanded(
                  child: TextFormField(
                    autofocus: true,
                    controller: controller,
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.start,
                    style: textTheme.bodySmall,
                    onChanged: (query) => placesAutoComplete(query),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(
                        Icons.location_on_outlined,
                        color: context.colorScheme.primary,
                      ),
                      suffixIcon: InkWell(
                        onTap: () => getCurrentLocation(),
                        child: Icon(
                          Icons.my_location_outlined,
                          color: context.colorScheme.primary,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: Dimensions.kBorderRadiusAllLarger,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 20),
                      hintText: widget.label,
                      helperStyle: textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.secondary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(child: SpinKitHourGlass(color: Colors.red))
                : predictionsList.isEmpty
                    ? Center(
                        child: Text(
                        'No Place',
                        style: textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.secondary,
                        ),
                      ))
                    : ListView.builder(
                        itemCount: predictionsList.length,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        itemBuilder: (_, i) {
                          return predictionsPlaceList(
                            onTap: () {
                              placeIdToGeocode(
                                  predictionsList[i].placeId ?? '');
                              setPickupAddress(
                                  predictionsList[i].description ?? '');
                            },
                            predictions: predictionsList[i],
                          );
                        }),
          ),
        ],
      ),
    );
  }

  void setPickupAddress(String query) async {
    if (widget.label == 'Pickup Address') {
      ref.read(premiumNotifierProvider).setPickupAddress(query);
    }
    if (widget.label == 'Drop off Address') {
      ref.read(premiumNotifierProvider).setDropOffAddress(query);
    }
  }

  Widget predictionsPlaceList(
      {required VoidCallback onTap, required PredictionsList predictions}) {
    final textTheme = context.textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: Dimensions.kBorderRadiusAllSmall,
        child: Container(
          padding: Dimensions.kPaddingAllMedium,
          decoration: BoxDecoration(
            color: context.colorScheme.onSecondary.withOpacity(.1),
            borderRadius: Dimensions.kBorderRadiusAllSmall,
          ),
          child: Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: Dimensions.iconSizeSmall,
                color: context.colorScheme.onSecondary,
              ),
              Dimensions.kHorizontalSpaceMedium,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      predictions.structuredFormatting!.mainText ?? '',
                      style: textTheme.titleLarge,
                    ),
                    Text(
                      predictions.description ?? '',
                      style: textTheme.labelLarge,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
