import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../config/config.dart';
import '../core/core.dart';
import '../feature/feature.dart';

final GlobalKey<NavigatorState> navigatorKey =
    GlobalKey<NavigatorState>(debugLabel: "Main Navigator Key");

class Customer extends ConsumerStatefulWidget {
  const Customer({super.key});

  @override
  ConsumerState<Customer> createState() => _CustomerConsumerState();
}

class _CustomerConsumerState extends ConsumerState<Customer> {
  LocalNotificationServices localNotificationServices =
      LocalNotificationServices();

  @override
  void initState() {
    super.initState();

    localNotificationServices.requestNotificationPermission();
    localNotificationServices.firebaseInit(context);
    localNotificationServices.setupInteractMessage(context);

    // localNotificationServices.isTokenRefresh();
    localNotificationServices.getDeviceToken().then((token) {
      setState(() => debugPrint("Device Token: $token"));
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeProvider);
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (ctx, child) {
        return MaterialApp(
          navigatorKey: navigatorKey,
          title: 'The Movers Online',
          debugShowCheckedModeBanner: false,
          theme: GeneratorTheme.lightTheme,
          darkTheme: GeneratorTheme.darkTheme,
          themeMode: theme,
          home: const SplashScreen(),
        );
      },
    );
  }
}
