import 'package:flutter/material.dart';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/config.dart';
import '../core.dart';

class AppAlerts {
  const AppAlerts._();

  static displaySnackBar(BuildContext context, String message, bool isSuccess) {
    final colorScheme = context.colorScheme;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            isSuccess
                ? const Icon(Icons.check_circle, color: Colors.white, size: 30)
                : const Icon(Icons.error, color: Colors.white, size: 30),
            Expanded(
              child: Text(
                message,
                style:
                    context.textTheme.bodyMedium?.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: isSuccess ? Colors.green : colorScheme.error,
      ),
    );
  }

// static Future<void> showAlertDeleteDialog({
//   required BuildContext context,
//   required WidgetRef ref,
//   required int quoteId,
// }) async {
//   final l10n = context.l10n;
//   Widget cancelButton = TextButton(
//     child: Text(l10n.cancel.toUpperCase()),
//     onPressed: () => context.pop(),
//   );
//   Widget deleteButton = TextButton(
//     onPressed: () async {
//       context.pop();
//       await ref.read(deleteQuoteProvider.notifier).deleteQuote(quoteId).then(
//         (value) {
//           AppAlerts.displaySnackbar(
//             context,
//             l10n.quoteDeletedSuccessfully,
//             true,
//           );
//           context.pop();
//         },
//       );
//     },
//     child: Text(l10n.delete.toUpperCase()),
//   );
//
//   AlertDialog alert = AlertDialog(
//     title: Text(l10n.alertTitle),
//     content: Text(l10n.alertContent),
//     actions: [
//       cancelButton,
//       deleteButton,
//     ],
//   );
//
//   await showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return alert;
//     },
//   );
// }
}

class AppUpdater extends StatefulWidget {
  const AppUpdater({super.key});

  @override
  State<AppUpdater> createState() => _AppUpdaterState();
}

class _AppUpdaterState extends State<AppUpdater> {
  double? progress = 0;
  int? status = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xFFFDFDFD),
      alignment: Alignment.center,
      title: Text(
        "Update Available",
        style: context.textTheme.headlineMedium,
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
              'A new version of the app is available. Please update to the new version now',
              textAlign: TextAlign.center,
              style: context.textTheme.bodySmall),
          // RichText(
          //   text: TextSpan(
          //     style: context.textTheme.labelLarge,
          //     children: [
          //       TextSpan(
          //           text: 'A ${widget.label} version of ',
          //           style: context.textTheme.bodySmall),
          //       TextSpan(
          //         text: '${widget.packageInfo.appName} ',
          //         style: context.textTheme.bodySmall
          //             ?.copyWith(fontWeight: FontWeight.bold),
          //       ),
          //       TextSpan(
          //           text: 'is available! Version ',
          //           style: context.textTheme.bodySmall),
          //       TextSpan(
          //         text: '${widget.appVersion} ',
          //         style: context.textTheme.bodySmall
          //             ?.copyWith(fontWeight: FontWeight.bold),
          //       ),
          //       TextSpan(
          //           text: ' is now available you have ',
          //           style: context.textTheme.bodySmall),
          //       TextSpan(
          //         text: widget.packageInfo.version,
          //         style: context.textTheme.bodySmall
          //             ?.copyWith(fontWeight: FontWeight.bold),
          //       ),
          //     ],
          //   ),
          // ),
          // Dimensions.kVerticalSpaceSmaller,
          // Text("Would you like to upgrade it now?",
          //     style: context.textTheme.bodySmall),
          Dimensions.kVerticalSpaceSmall,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // TextButton(
              //   onPressed: () => {Navigator.pop(context)},
              //   child: Text(
              //     "LATER",
              //     style: context.textTheme.labelLarge?.copyWith(
              //         fontWeight: FontWeight.w500,
              //         color: appColor.warning600),
              //   ),
              // ),
              Button(
                onTap: () {
                  _launchPlayStore();
                },
                width: 150,
                child: Text(
                  "UPDATE NOW",
                  style: context.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w500, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _launchPlayStore() async {
    ///Android

    const String packageName = 'com.themovers.themovers_customer';
    const String url =
        'https://play.google.com/store/apps/details?id=$packageName';

    ///IOS
    // String bundleId = "com.example.myapp"; // Replace with the Bundle ID of your app
    // String url = 'https://apps.apple.com/app/$bundleId';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
