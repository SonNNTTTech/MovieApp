import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:test_app/presentation/auth/widget/auth_view.dart';
import 'package:test_app/presentation/bottom_bar/provider/bottom_bar_provider.dart';
import 'package:test_app/presentation/favorite/favorite_view.dart';
import 'package:test_app/presentation/home/widget/home_view.dart';
import 'package:test_app/presentation/search/search_movie_view.dart';

import 'app_route.dart';

class BottomBarWidget extends ConsumerWidget {
  const BottomBarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PersistentTabView(
      context,
      controller: ref
          .watch(bottomBarNotifierProvider.select((value) => value.controller)),
      screens: _buildScreens(),
      items: _navBarsItems(),
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style9,
    );
  }

  List<Widget> _buildScreens() {
    return [
      const HomeView(),
      const SearchMovieView(),
      const FavoriteView(),
      const AuthView(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
        routeAndNavigatorSettings: const RouteAndNavigatorSettings(
          initialRoute: HomeView.route,
          onGenerateRoute: AppRoutes.onGenerated,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.search),
        title: ("Search"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
        routeAndNavigatorSettings: const RouteAndNavigatorSettings(
          initialRoute: SearchMovieView.route,
          onGenerateRoute: AppRoutes.onGenerated,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.heart),
        title: ("Favorite"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
        routeAndNavigatorSettings: const RouteAndNavigatorSettings(
          initialRoute: FavoriteView.route,
          onGenerateRoute: AppRoutes.onGenerated,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.person),
        title: ("Authentication"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }
}
