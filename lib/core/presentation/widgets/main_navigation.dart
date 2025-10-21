import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../features/internationalization/generated/translations.dart';
import '../../router/app_router.dart';
import '../../theme/app_theme.dart';

class MainNavigation extends StatelessWidget {
  const MainNavigation({super.key});

  int _getCurrentIndex(BuildContext context) {
    final location = GoRouter.of(
      context,
    ).routerDelegate.currentConfiguration.fullPath;

    if (location.contains(AppRoutes.creator)) return 0;
    if (location.contains(AppRoutes.home)) return 1;
    if (location.contains(AppRoutes.profile)) return 2;

    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final translations = Translations.of(context);

    return BottomNavigationBar(
      selectedItemColor: AppColors.primary,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: _getCurrentIndex(context),
      onTap: (index) {
        switch (index) {
          case 0:
            context.go(AppRoutes.creator);
            break;
          case 1:
            context.go(AppRoutes.home);
            break;
          case 2:
            context.go(AppRoutes.profile);
            break;
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.fitness_center),
          label: translations.creatorPage,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: translations.homeTitle,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.person),
          label: translations.profilePage,
        ),
      ],
    );
  }
}
