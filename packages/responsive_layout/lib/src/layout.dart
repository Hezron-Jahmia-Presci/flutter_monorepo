import 'package:flutter/material.dart';

import 'desktop_layout.dart';
import 'mobile_layout.dart';

class NavItem {
  final IconData filledIcon;
  final IconData unfilledIcon;
  final String label;

  const NavItem({
    required this.filledIcon,
    required this.unfilledIcon,
    required this.label,
  });
}

class Layout extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final List<NavItem> navItems;
  final List<Widget> pages;
  final int selectedIndex;
  final ValueChanged<int> onNavTap;

  const Layout({
    super.key,
    this.appBar,
    this.floatingActionButton,
    required this.navItems,
    required this.pages,
    required this.selectedIndex,
    required this.onNavTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < 600) {
      return MobileLayout(
        appBar: appBar,
        floatingActionButton: floatingActionButton,
        navItems: navItems,
        pages: pages,
        selectedIndex: selectedIndex,
        onNavTap: onNavTap,
      );
    } else {
      return DesktopLayout(
        appBar: appBar,
        floatingActionButton: floatingActionButton,
        navItems: navItems,
        pages: pages,
        selectedIndex: selectedIndex,
        onNavTap: onNavTap,
      );
    }
  }
}
