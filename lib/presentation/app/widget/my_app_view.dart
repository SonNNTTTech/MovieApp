import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/generated/l10n.dart';
import 'package:test_app/presentation/app/widget/splash_view.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../provider/app_provider.dart';

class MyAppView extends ConsumerWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final locale =
        ref.watch(appNotifierProvider.select((value) => value.locale));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: locale,
      home: const SplashView(),
    );
  }
}
