import 'package:get/get.dart';
import 'package:test_app/presentation/home/home_view.dart';

class AppRouting {
  static final routes = [
    GetPage(
      name: HomeView.route,
      page: () => const HomeView(),
    ),
  ];
}
