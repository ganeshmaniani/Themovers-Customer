import 'dart:developer';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';

import '../../../../../config/config.dart';
import '../../../../../core/core.dart';
import '../../../../feature.dart';

class BookingUpdateBottomSheet extends ConsumerStatefulWidget {
  final String bookingId;

  const BookingUpdateBottomSheet({super.key, required this.bookingId});

  @override
  ConsumerState<BookingUpdateBottomSheet> createState() =>
      _BookingUpdateBottomSheetConsumerState();
}

class _BookingUpdateBottomSheetConsumerState
    extends ConsumerState<BookingUpdateBottomSheet> {
  final _descriptionController = TextEditingController();

  double rating = 0;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return SizedBox(
      height: 500.h,
      child: Stack(
        children: [
          Positioned(
            top: 45.h,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 460.h,
              alignment: Alignment.center,
              padding: Dimensions.kPaddingAllMedium,
              decoration: BoxDecoration(
                color: context.colorScheme.onPrimary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Dimensions.kVerticalSpaceLarge,
                  Text('*Please pay the total amount to the driver.',
                      style: textTheme.bodySmall!.copyWith(color: Colors.red)),
                  Dimensions.kSpacer,
                  InkWell(
                    onTap: () {
                      ref
                          .read(bookingProvider.notifier)
                          .updateBookingUpdate(StatusUpdateEntities(
                              bookingId: widget.bookingId, paymentMode: '1'))
                          .then((res) => res.fold(
                              (l) => {
                                    {
                                      debugPrint(l.message),
                                      Navigator.pop(context),
                                    }
                                  },
                              (r) => {
                                    {
                                      Navigator.pop(context),
                                      Navigator.pop(context),
                                      showRatingModel(),
                                    }
                                  }));
                    },
                    child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: const Color(0xFF23978E),
                          borderRadius: BorderRadius.circular(12)),
                      padding: Dimensions.kPaddingAllSmall,
                      child: Text(
                        "COMPLETE JOB",
                        style: context.textTheme.bodySmall
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  Dimensions.kVerticalSpaceSmall,
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 150,
            child: Container(
              width: 70.w,
              height: 70.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: context.colorScheme.primary,
                borderRadius: Dimensions.kBorderRadiusAllSmall,
                boxShadow: [
                  BoxShadow(
                    color: context.colorScheme.secondary.withOpacity(.3),
                    offset: const Offset(0, 6),
                    blurRadius: 16,
                    spreadRadius: 3,
                  ),
                ],
              ),
              child: Icon(Icons.info_rounded,
                  size: Dimensions.iconSizeMedium, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void showRatingModel() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Please rate\nyour experience with us",
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMedium),
            content: SizedBox(
              height: 150.h,
              child: Form(
                child: Column(
                  children: [
                    RatingBar.builder(
                        updateOnDrag: true,
                        initialRating: rating,
                        minRating: rating,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemBuilder: (context, _) =>
                            const Icon(Icons.star, color: Colors.amber),
                        onRatingUpdate: (rating) {
                          this.rating = rating;
                        }),
                    Dimensions.kVerticalSpaceSmall,
                    TextFormField(
                      maxLines: 2,
                      controller: _descriptionController,
                      keyboardType: TextInputType.text,
                      enableSuggestions: true,
                      obscureText: false,
                      enableInteractiveSelection: true,
                      style: context.textTheme.bodyMedium,
                      decoration: InputDecoration(
                        labelText: "Description",
                        labelStyle: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.secondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Button(
                      width: 60.w,
                      height: 36.h,
                      onTap: () => Navigator.pop(context),
                      color: context.colorScheme.secondary.withOpacity(.3),
                      child: Text(
                        "Cancel",
                        style: context.textTheme.labelLarge
                            ?.copyWith(color: Colors.white),
                      )),
                  Dimensions.kHorizontalSpaceSmall,
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF23978E)),
                      onPressed: () async {
                        debugPrint("Click");
                        final userid =
                            SharedPrefs.instance.getInt(AppKeys.userId);

                        Map data = {
                          'user_id': userid.toString(),
                          'booking_id': widget.bookingId,
                          'ratings': rating.toString(),
                          'feedback': _descriptionController.text
                        };

                        debugPrint(data.toString());
                        Map<String, String> headers = {
                          "Content-Type": "application/json",
                          "Accept": "application/json",
                        };

                        try {
                          Response response = await post(
                            Uri.parse(ApiUrl.bookingRatingEndpoint),
                            body: json.encode(data),
                            headers: headers,
                            encoding: Encoding.getByName("utf-8"),
                          ).timeout(const Duration(seconds: 15));

                          debugPrint("Response: ${response.statusCode}");

                          log(response.body.toString());

                          // AppAlerts.displaySnackBar(
                          //     context, 'Rating Update Successful', true);
                          // Navigator.pop(context);

                          if (response.statusCode == 200) {
                            final jsonResponse = json.decode(response.body);
                            if (jsonResponse["Api_success"].toString() ==
                                "true") {
                              AppAlerts.displaySnackBar(
                                  context, 'Rating Update Successful', true);
                              Navigator.pop(context);
                            }
                          } else {
                            Navigator.pop(context);
                          }
                        } catch (e) {
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        "Submit",
                        style: context.textTheme.labelLarge
                            ?.copyWith(color: Colors.white),
                      )),
                  // Button(
                  //     width: 60.w,
                  //     height: 36.h,
                  //     onTap: () {

                  //     },
                  //     child: Text(
                  //       "Submit",
                  //       style: context.textTheme.labelLarge
                  //           ?.copyWith(color: Colors.white),
                  //     ))
                ],
              )
            ],
          );
        });
  }

  void onSubmit() async {
    // ref
    //     .read(bookingProvider.notifier)
    //     .uploadBookingRating(ratingEntities)
    //     .then((res) => res.fold(
    //         (l) => {Navigator.pop(context)},
    //         (r) => {
    //               AppAlerts.displaySnackBar(
    //                   context, 'Rating Update Successful', true),
    //               Navigator.pop(context),
    //             }));
  }
}
