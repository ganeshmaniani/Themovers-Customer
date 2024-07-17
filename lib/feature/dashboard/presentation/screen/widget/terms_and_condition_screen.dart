import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:themovers/config/config.dart';
import 'package:themovers/feature/dashboard/dashboard.dart';

import '../../../../../core/constants/app_assets.dart';
import '../../../data/model/term_and_condition_model.dart';

class TermsAndConditionScreen extends ConsumerStatefulWidget {
  const TermsAndConditionScreen({super.key});

  @override
  ConsumerState<TermsAndConditionScreen> createState() =>
      _TermsAndConditionScreenConsumerState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _TermsAndConditionScreenConsumerState
    extends ConsumerState<TermsAndConditionScreen> {
  bool isLoading = false;
  List<CustomerTermsConditionList> termsAndCondition = [];

  @override
  void initState() {
    super.initState();
    initialTermsAndCondition();
  }

  Future<void> initialTermsAndCondition() async {
    setState(() => isLoading = true);
    ref
        .read(imageSliderProvider.notifier)
        .getTermsAndCondition()
        .then((res) => res.fold(
            (l) => {
                  setState(() => {
                        termsAndCondition = [],
                        isLoading = false,
                      })
                },
            (r) => {
                  setState(() => {
                        termsAndCondition = r.customerTermsConditionList ?? [],
                        isLoading = false,
                      })
                }));
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return Scaffold(
      key: _scaffoldKey,
      appBar: appBars(context),
      drawer: const CustomDrawer(),
      body: isLoading
          ? const Center(child: SpinKitHourGlass(color: Colors.red))
          : SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Terms & Conditions',
                        style: textTheme.headlineMedium!
                            .copyWith(fontWeight: FontWeight.w400),
                      ),
                      Dimensions.kVerticalSpaceMedium,
                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: ListView.builder(
                            itemCount: termsAndCondition.length,
                            itemBuilder: (_, i) {
                              final termsAndConditions = termsAndCondition[i];
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${termsAndConditions.titleName} " ?? '',
                                    style: textTheme.headlineSmall!
                                        .copyWith(fontWeight: FontWeight.w500),
                                  ),
                                  Dimensions.kVerticalSpaceSmallest,
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Text(
                                      termsAndConditions.value ?? '',
                                      style: textTheme.labelLarge!.copyWith(
                                          fontWeight: FontWeight.w400),
                                      textAlign: TextAlign.justify,
                                    ),
                                  )
                                ],
                              );
                            }),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  PreferredSizeWidget appBars(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Dimensions.kHorizontalSpaceMedium,
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                    width: 38.w,
                    height: 38.h,
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color(0xFFB40205)),
                    child: SvgPicture.asset(AppIcon.backArrowIcon)),
              ),
              const Spacer(),
              Image(
                  image: const AssetImage(AppIcon.theMoversLogo), width: 100.w),
              const Spacer(),
              InkWell(
                onTap: () => _scaffoldKey.currentState!.openDrawer(),
                child: Container(
                    width: 38.w,
                    height: 38.h,
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color(0xFFB40205)),
                    child: SvgPicture.asset(AppIcon.menus)),
              ),
              Dimensions.kHorizontalSpaceMedium,
            ],
          ),
          Dimensions.kVerticalSpaceSmaller,
          Divider(
              height: 0,
              color: const Color(0xFFC1C1C1).withOpacity(0.2),
              endIndent: 16,
              indent: 16)
        ],
      ),
    );
  }
}
