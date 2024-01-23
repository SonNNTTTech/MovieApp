import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/route_manager.dart';
import 'package:test_app/presentation/home/home_view.dart';
import 'package:test_app/presentation/my_app/routing.dart';

class MyAppView extends ConsumerWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      enableLog: true,
      initialRoute: HomeView.route,
      getPages: AppRouting.routes,
      defaultTransition: Transition.cupertino,
    );
  }
}
