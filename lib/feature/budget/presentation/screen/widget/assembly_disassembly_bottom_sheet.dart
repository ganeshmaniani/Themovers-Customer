import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:themovers/feature/dashboard/dashboard.dart';

import '../../../../../config/config.dart';
import '../../../../../core/core.dart';
import '../../../../budget/budget.dart';

class AssemblyDisassemblyBottomSheet extends ConsumerStatefulWidget {
  const AssemblyDisassemblyBottomSheet({super.key});

  @override
  ConsumerState<AssemblyDisassemblyBottomSheet> createState() =>
      _AssemblyDisassemblyBottomSheetConsumerState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _AssemblyDisassemblyBottomSheetConsumerState
    extends ConsumerState<AssemblyDisassemblyBottomSheet> {
  @override
  Widget build(BuildContext context) {
    int diningTableCount = ref.watch(budgetControllerProvider).diningTable ?? 0;
    int officeTableCount = ref.watch(budgetControllerProvider).officeTable ?? 0;
    int bedCount = ref.watch(budgetControllerProvider).bed ?? 0;
    int wardrobeCount = ref.watch(budgetControllerProvider).wardrobe ?? 0;

    final amount = ref.watch(budgetControllerProvider).budgetPackage;
    final textTheme = context.textTheme;
    return Scaffold(
      key: _scaffoldKey,
      drawer: const CustomDrawer(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Dimensions.kVerticalSpaceLarge,
              appBar(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Budget Booking',
                      style: textTheme.headlineMedium!
                          .copyWith(fontWeight: FontWeight.w400, height: 0),
                    ),
                    Dimensions.kVerticalSpaceSmall,
                    Container(
                      padding:
                          const EdgeInsets.only(top: 10, left: 20, bottom: 10),
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Color(0xFFB40205),
                      ),
                      child: Text(
                        'Assemble / Disassemble',
                        style: textTheme.titleSmall!.copyWith(
                          color: Colors.white,
                          height: 0,
                        ),
                      ),
                    ),
                    Dimensions.kVerticalSpaceSmaller,
                    Text(
                        'Disassemble your furniture at pickup location and reassemble at deliver location',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF000000),
                          height: 0,
                        )),
                  ],
                ),
              ),
              Dimensions.kVerticalSpaceSmall,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  productDetailCard(
                    icon: AppIcon.diningTable,
                    title: 'Dining Table',
                    size: 'Any Size',
                    decoration: 'MYR ${amount?.diningTable}',
                    count: diningTableCount,
                    increment: () => setState(() => {
                          diningTableCount = diningTableCount + 1,
                          addCount('dining', diningTableCount),
                        }),
                    decrement: () => setState(() => diningTableCount != 0
                        ? {
                            diningTableCount = diningTableCount - 1,
                            addCount('dining', diningTableCount),
                          }
                        : () {}),
                  ),
                  Dimensions.kHorizontalSpaceMedium,
                  productDetailCard(
                    icon: AppIcon.officeTable,
                    title: 'Office Table',
                    size: 'Any Size',
                    decoration: 'MYR ${amount?.table}',
                    count: officeTableCount,
                    increment: () => setState(() => {
                          officeTableCount = officeTableCount + 1,
                          addCount('office', officeTableCount),
                        }),
                    decrement: () => setState(
                      () => officeTableCount != 0
                          ? {
                              officeTableCount = officeTableCount - 1,
                              addCount('office', officeTableCount),
                            }
                          : () {},
                    ),
                  ),
                ],
              ),
              Dimensions.kVerticalSpaceSmall,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  productDetailCard(
                    icon: AppIcon.bed,
                    title: 'Bed',
                    size: 'Single, Queen, King',
                    decoration: 'MYR ${amount?.bed}',
                    count: bedCount,
                    increment: () => setState(() =>
                        {bedCount = bedCount + 1, addCount('bed', bedCount)}),
                    decrement: () => setState(
                      () => bedCount != 0
                          ? {bedCount = bedCount - 1, addCount('bed', bedCount)}
                          : () {},
                    ),
                  ),
                  Dimensions.kHorizontalSpaceMedium,
                  productDetailCard(
                    icon: AppIcon.wardrobe,
                    title: '\nWardrobe',
                    size: 'Bookshelf, Cupboard',
                    decoration: 'MYR ${amount?.wardrobe}',
                    count: wardrobeCount,
                    increment: () => setState(() => {
                          wardrobeCount = wardrobeCount + 1,
                          addCount('wardrobe', wardrobeCount),
                        }),
                    decrement: () => setState(
                      () => wardrobeCount != 0
                          ? {
                              wardrobeCount = wardrobeCount - 1,
                              addCount('wardrobe', wardrobeCount),
                            }
                          : () {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  alignment: Alignment.center,
                  height: 50.sp,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: const Color(0xFFB40205),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    'Done',
                    style: context.textTheme.bodySmall
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget appBar() {
    return Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
              Image(
                  image: const AssetImage(AppIcon.theMoversLogo), width: 100.w),
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
            ],
          ),
        ));
  }

  titleAndLabelCard({required String title, required String discription}) {
    final textTheme = context.textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textTheme.titleLarge?.copyWith(color: const Color(0xFF444550)),
        ),
        Dimensions.kVerticalSpaceSmallest,
        Text(
          discription,
          style: textTheme.labelLarge?.copyWith(color: Colors.black54),
        ),
      ],
    );
  }

  productDetailCard({
    required String icon,
    required String title,
    required String size,
    required String decoration,
    required int count,
    required VoidCallback increment,
    required VoidCallback decrement,
  }) {
    final textTheme = context.textTheme;
    return Column(
      children: [
        Image(
          image: AssetImage(icon),
          width: 125,
          height: 125,
        ),
        Dimensions.kVerticalSpaceSmallest,
        CustomProductCounterCard(
            isEnable: true,
            limited: false,
            count: count,
            increment: increment,
            decrement: decrement),
        Dimensions.kVerticalSpaceSmallest,
        Text(decoration,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF000000),
            )),
        Text('per furniture',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF000000),
            ))
      ],
    );
  }

  void addCount(String service, int count) async {
    switch (service) {
      case 'dining':
        ref.read(budgetControllerProvider).setDiningTable(count);
        break;
      case 'office':
        ref.read(budgetControllerProvider).setOfficeTable(count);
        break;
      case 'bed':
        ref.read(budgetControllerProvider).setBed(count);
        break;
      case 'wardrobe':
        ref.read(budgetControllerProvider).setWardrobe(count);
        break;
    }
  }
}
