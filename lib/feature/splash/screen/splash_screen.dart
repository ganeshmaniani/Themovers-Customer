import 'package:flutter/material.dart';
import 'package:gif/gif.dart';
import 'package:themovers/config/config.dart';

import '../../../../core/core.dart';
import '../.././feature.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late GifController _gifController;

  @override
  void initState() {
    super.initState();
    _gifController = GifController(vsync: this);
    initialAppRoute();
  }

  void initialAppRoute() async {
    final userId = SharedPrefs.instance.getInt(AppKeys.userId);
    final auth = userId != null ? true : false;
    Future.delayed(
        const Duration(seconds: 5),
        () => {
              if (auth)
                {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const DashboardScreen()),
                      (route) => false)
                }
              else
                {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const EmailAuthScreen()),
                      (route) => false)
                }
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Gif(
          fps: 80,
          image: const AssetImage(AppIcon.splashAnimation),
          controller: _gifController,
          autostart: Autostart.once,
          width: context.deviceSize.width,
        ),
      ),
    );
  }
}
