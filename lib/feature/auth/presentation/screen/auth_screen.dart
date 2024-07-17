import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../auth.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenConsumerState();
}

class _AuthScreenConsumerState extends ConsumerState<AuthScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return Scaffold(
      key: _scaffoldKey,
      body: Column(
        children: [
          Expanded(child: Container(color: context.colorScheme.primary)),
          Expanded(
            child: Container(
              padding: Dimensions.kPaddingAllMedium,
              child: Column(
                children: [
                  Dimensions.kVerticalSpaceSmall,
                  _continueWithEmailUI(),
                  Dimensions.kVerticalSpaceMedium,
                  _dividerUI(),
                  Dimensions.kVerticalSpaceMedium,
                  Row(
                    children: [
                      _signInWithGoogle(),
                      Dimensions.kHorizontalSpaceSmall,
                      _signInWithFacebook(),
                    ],
                  ),
                  Dimensions.kSpacer,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: textTheme.labelLarge,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => const RegistrationScreen()));
                        },
                        child: Text(
                          "Register",
                          style: textTheme.labelLarge?.copyWith(
                            color: context.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Dimensions.kVerticalSpaceSmall,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _continueWithEmailUI() {
    final textTheme = context.textTheme;
    return Button(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => const EmailAuthScreen()));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.phone_iphone_rounded,
            color: Colors.white,
            size: Dimensions.iconSizeSmall,
          ),
          Dimensions.kHorizontalSpaceSmall,
          Text(
            'Continue with Email',
            style: textTheme.bodyMedium?.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }

  _signInWithGoogle() {
    final textTheme = context.textTheme;
    return Expanded(
      child: OutlineButton(
        onTap: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.phone_iphone_rounded,
              color: context.colorScheme.primary,
              size: Dimensions.iconSizeSmall,
            ),
            Dimensions.kHorizontalSpaceSmall,
            Text(
              'Google',
              style: textTheme.bodyMedium
                  ?.copyWith(color: context.colorScheme.primary),
            ),
          ],
        ),
      ),
    );
  }

  _signInWithFacebook() {
    final textTheme = context.textTheme;
    return Expanded(
      child: OutlineButton(
        onTap: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.phone_iphone_rounded,
              color: context.colorScheme.primary,
              size: Dimensions.iconSizeSmall,
            ),
            Dimensions.kHorizontalSpaceSmall,
            Text(
              'Facebook',
              style: textTheme.bodyMedium
                  ?.copyWith(color: context.colorScheme.primary),
            ),
          ],
        ),
      ),
    );
  }

  _dividerUI() {
    final textTheme = context.textTheme;
    return Row(
      children: [
        Expanded(
          child: Divider(
            height: 2,
            color: context.colorScheme.onPrimary,
          ),
        ),
        Dimensions.kHorizontalSpaceSmaller,
        Text(
          'or Login with',
          style: textTheme.labelLarge,
        ),
        Dimensions.kHorizontalSpaceSmaller,
        Expanded(
          child: Divider(
            height: 2,
            color: context.colorScheme.onPrimary,
          ),
        ),
      ],
    );
  }
}
