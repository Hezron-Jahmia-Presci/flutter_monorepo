import 'package:flutter/material.dart';

class DesktopLayout extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final List navItems;
  final List<Widget> pages;
  final int selectedIndex;
  final ValueChanged<int> onNavTap;
  final int trailingCount;

  const DesktopLayout({
    super.key,
    this.appBar,
    this.floatingActionButton,
    required this.navItems,
    required this.pages,
    required this.selectedIndex,
    required this.onNavTap,
    this.trailingCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final int mainCount = navItems.length - trailingCount;
    final mainItems = navItems.take(mainCount).toList();
    final trailingItems = navItems.skip(mainCount).toList();

    final int? navigationRailSelectedIndex =
        (selectedIndex < mainCount) ? selectedIndex : null;

    return Scaffold(
      appBar: appBar,
      floatingActionButton: floatingActionButton,
      body: Row(
        children: [
          NavigationRail(
            minWidth: 100,
            selectedIndex: navigationRailSelectedIndex,
            onDestinationSelected: (index) {
              onNavTap(index); // indexes in main items range
            },
            backgroundColor: colorScheme.surface,
            indicatorShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            selectedIconTheme: IconThemeData(color: colorScheme.primary),
            unselectedIconTheme: IconThemeData(color: colorScheme.secondary),
            selectedLabelTextStyle: TextStyle(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelTextStyle: TextStyle(color: colorScheme.secondary),
            labelType: NavigationRailLabelType.all,
            destinations:
                mainItems.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;
                  final isSelected = (selectedIndex == index);
                  return NavigationRailDestination(
                    icon: Icon(item.unfilledIcon),
                    selectedIcon: Icon(item.filledIcon),
                    label:
                        isSelected ? const SizedBox.shrink() : Text(item.label),
                  );
                }).toList(),

            trailing:
                trailingCount > 0
                    ? Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children:
                          trailingItems.asMap().entries.map((entry) {
                            final trailingIndex = entry.key;
                            final item = entry.value;
                            final realIndex = mainCount + trailingIndex;
                            final isSelected = selectedIndex == realIndex;

                            return IconButton(
                              icon:
                                  isSelected
                                      ? Icon(
                                        item.filledIcon,
                                        color: colorScheme.primary,
                                      )
                                      : Icon(
                                        item.unfilledIcon,
                                        color: colorScheme.secondary,
                                      ),
                              tooltip: item.label,
                              onPressed: () => onNavTap(realIndex),
                            );
                          }).toList(),
                    )
                    : null,
          ),
          Expanded(child: pages[selectedIndex]),
        ],
      ),
    );
  }
}
