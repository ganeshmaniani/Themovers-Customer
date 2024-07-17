import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:themovers/config/config.dart';
import 'package:themovers/core/core.dart';
import 'package:themovers/feature/faq_detail/presentation/provider/faq_provider.dart';

import '../../data/model/customer_faq_model.dart';

class FAQScreen extends ConsumerStatefulWidget {
  const FAQScreen({super.key});

  @override
  ConsumerState<FAQScreen> createState() => _FAQScreenConsumerState();
}

class _FAQScreenConsumerState extends ConsumerState<FAQScreen> {
  int currentState = 1;

  bool isLoading = false;

  List<CustomerFaqList> customerFaqList = [];

  @override
  void initState() {
    super.initState();
    initialFAQList();
  }

  Future<void> initialFAQList() async {
    setState(() => isLoading = true);
    ref.read(faqDetailProvider.notifier).getFAQList().then((res) => res.fold(
        (l) => {
              setState(() => {
                    customerFaqList = [],
                    isLoading = false,
                  })
            },
        (r) => {
              setState(() => {
                    customerFaqList = r.customerFaqList!,
                    isLoading = false,
                  })
            }));
  }

  void setBackState() {
    setState(currentState != 0 ? () => currentState = currentState - 1 : () {});
  }

  void appBarOnTap() {
    if (currentState == 1) {
      Navigator.pop(context);
    }
    if (currentState == 2 || currentState == 3) {
      setBackState();
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     'FAQ',
      //     style: textTheme.headlineMedium?.copyWith(color: Colors.white),
      //   ),
      //   leading: InkWell(
      //     onTap: appBarOnTap,
      //     child: const Icon(Icons.arrow_back_sharp, color: Colors.white),
      //   ),
      // ),
      body: isLoading
          ? const Center(child: SpinKitHourGlass(color: Colors.red))
          : SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Container(
                    height: 212.h,
                    width: MediaQuery.of(context).size.width,
                    padding: Dimensions.kPaddingAllMedium,
                    color: context.colorScheme.primary,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Dimensions.kVerticalSpaceLarge,
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                              width: 38.w,
                              height: 38.h,
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  color: Colors.white),
                              child: SvgPicture.asset(
                                AppIcon.backArrowIcon,
                                color: const Color(0xFFB40205),
                              )),
                        ),
                        Dimensions.kSpacer,
                        Text(
                          'Frequently Asked Question',
                          textAlign: TextAlign.center,
                          style: textTheme.displayLarge?.copyWith(
                              color: Colors.white,
                              letterSpacing: .7,
                              fontSize: 30.sp,
                              height: 1.2.h),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: customerFaqList.length,
                        itemBuilder: (context, index) {
                          final question =
                              customerFaqList[index].question ?? '';
                          final answer = customerFaqList[index].answer ?? '';
                          final id = customerFaqList[index].id ?? '';
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.5.w,
                                      color: const Color(0xFFB40205))),
                              child: ExpansionTile(
                                backgroundColor: const Color(0xFFFFFFFF),
                                shape: const Border(),
                                title: Text(
                                  '$id.$question',
                                  style: context.textTheme.labelLarge!
                                      .copyWith(fontWeight: FontWeight.w500),
                                ),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16, bottom: 16),
                                    child: Text(answer,
                                        style: context.textTheme.labelMedium),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Button(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Row(
                          children: [
                            const Spacer(),
                            Text(
                              'Back',
                              style: context.textTheme.labelLarge!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                            const Spacer(),
                            SvgPicture.asset(AppIcon.arrowIcon),
                            Dimensions.kHorizontalSpaceMedium
                          ],
                        )),
                  )
                ],
              ),
            ),
    );
  }
}
