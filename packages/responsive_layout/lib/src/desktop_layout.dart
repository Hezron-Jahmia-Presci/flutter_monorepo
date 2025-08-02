import 'package:flutter/material.dart';

class DesktopLayout extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final List navItems;
  final List<Widget> pages;
  final int selectedIndex;
  final ValueChanged<int> onNavTap;
  final int? navRailTrailingCount;

  const DesktopLayout({
    super.key,
    this.appBar,
    this.floatingActionButton,
    required this.navItems,
    required this.pages,
    required this.selectedIndex,
    required this.onNavTap,
    this.navRailTrailingCount,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final int trailingCount = navRailTrailingCount ?? 0;
    final int splitIndex = navItems.length - trailingCount;

    final mainItems = navItems.take(splitIndex).toList();
    final trailingItems = navItems.skip(splitIndex).toList();

    return Scaffold(
      appBar: appBar,
      floatingActionButton: floatingActionButton,
      body: Row(
        children: [
          NavigationRail(
            minWidth: 100,
            selectedIndex:
                selectedIndex < mainItems.length ? selectedIndex : null,
            onDestinationSelected: onNavTap,
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
                  final isSelected = index == selectedIndex;

                  return NavigationRailDestination(
                    icon: Icon(item.unfilledIcon),
                    selectedIcon: Icon(item.filledIcon),
                    label:
                        isSelected ? const SizedBox.shrink() : Text(item.label),
                  );
                }).toList(),
            trailing:
                trailingItems.isNotEmpty
                    ? Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children:
                              trailingItems.asMap().entries.map((entry) {
                                final index = splitIndex + entry.key;
                                final item = entry.value;
                                final isSelected = index == selectedIndex;
                                return IconButton(
                                  icon: Icon(
                                    isSelected
                                        ? item.filledIcon
                                        : item.unfilledIcon,
                                    color:
                                        isSelected
                                            ? colorScheme.primary
                                            : colorScheme.secondary,
                                  ),
                                  onPressed: () => onNavTap(index),
                                  tooltip: item.label,
                                );
                              }).toList(),
                        ),
                      ),
                    )
                    : null,
          ),

          Expanded(child: pages[selectedIndex]),
        ],
      ),
    );
  }
}
