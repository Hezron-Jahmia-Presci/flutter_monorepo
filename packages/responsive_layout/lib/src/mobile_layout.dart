import 'package:flutter/material.dart';

class MobileLayout extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final List? navItems;
  final List<Widget>? pages;
  final int selectedIndex;
  final ValueChanged<int> onNavTap;

  const MobileLayout({
    super.key,
    this.appBar,
    this.floatingActionButton,
    this.navItems,
    this.pages,
    required this.selectedIndex,
    required this.onNavTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final body =
        (pages != null && selectedIndex < pages!.length)
            ? pages![selectedIndex]
            : const SizedBox.shrink();

    return Scaffold(
      appBar: appBar,
      body: Padding(padding: const EdgeInsets.all(24.0), child: body),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar:
          navItems != null
              ? SizedBox(
                height: 100,
                child: BottomNavigationBar(
                  items:
                      navItems!
                          .map(
                            (item) => BottomNavigationBarItem(
                              icon: Icon(item.unfilledIcon),
                              activeIcon: Icon(item.filledIcon),
                              label: item.label,
                            ),
                          )
                          .toList(),
                  currentIndex: selectedIndex,
                  onTap: onNavTap,
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: colorScheme.primary,
                  unselectedItemColor: colorScheme.secondary,
                  unselectedLabelStyle: TextStyle(color: colorScheme.secondary),
                ),
              )
              : null,
    );
  }
}
