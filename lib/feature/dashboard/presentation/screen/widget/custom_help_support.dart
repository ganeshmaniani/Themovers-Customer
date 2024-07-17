import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:themovers/config/config.dart';
import 'package:themovers/feature/dashboard/presentation/screen/widget/terms_and_condition_screen.dart';
import 'package:themovers/feature/dashboard/presentation/screen/widget/terms_and_policies_screen.dart';
import 'package:themovers/feature/faq_detail/faq_detail.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/constants/app_assets.dart';
import '../../../../feature.dart';

class HelpAndSupportScreen extends StatelessWidget {
  HelpAndSupportScreen({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void launchWhatsapp({required number, required message}) async {
    String url = 'whatsapp://send?phone=$number&text=$message';
    await launchUrl(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return Scaffold(
      key: _scaffoldKey,
      appBar: appBars(context),
      drawer: const CustomDrawer(),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: Dimensions.kPaddingAllMedium,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Help & Support',
                style: textTheme.headlineMedium!
                    .copyWith(fontWeight: FontWeight.w400),
              ),
              Dimensions.kVerticalSpaceMedium,
              navigatorListCard(
                  icon: Icons.help_center,
                  context: context,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const FAQScreen()));
                  },
                  label: 'Help Center-(FAQ)'),
              navigatorListCard(
                  icon: Icons.chat,
                  context: context,
                  onPressed: () {
                    launchWhatsapp(
                        number: "+60123244261",
                        message:
                            'Good day The Movers Online,we would like to request for a quote for our Moving!');
                  },
                  label: 'Chat With Us'),
              navigatorListCard(
                  icon: Icons.assignment,
                  context: context,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const TermsAndConditionScreen()));
                  },
                  label: 'Terms & Conditions'),
              navigatorListCard(
                  icon: Icons.policy,
                  context: context,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const TermsAndPolicyScreen()));
                  },
                  label: 'Privacy Policies'),
            ],
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

  navigatorListCard({
    required BuildContext context,
    required VoidCallback onPressed,
    required String label,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: InkWell(
        onTap: onPressed,
        child: Row(
          children: [
            Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                  color: const Color(0xFFB30205),
                  borderRadius: BorderRadius.circular(5)),
              child: Icon(icon, size: 18, color: Colors.white),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.bodySmall!
                  .copyWith(fontSize: 15.sp, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
