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

    // Safe selected index for NavigationRail
    final safeSelectedIndex =
        (selectedIndex >= 0 && selectedIndex < mainItems.length)
            ? selectedIndex
            : null;

    return Scaffold(
      appBar: appBar,
      floatingActionButton: floatingActionButton,
      body: Row(
        children: [
          NavigationRail(
            minWidth: 100,
            selectedIndex: safeSelectedIndex,
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

            // Main items shown in destinations
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

            // Trailing items pinned at the bottom with labels
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

                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                  ),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      padding: EdgeInsets.zero,
                                      minimumSize: const Size(56, 56),
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    onPressed: () => onNavTap(index),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          isSelected
                                              ? item.filledIcon
                                              : item.unfilledIcon,
                                          color:
                                              isSelected
                                                  ? colorScheme.primary
                                                  : colorScheme.secondary,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          item.label,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color:
                                                isSelected
                                                    ? colorScheme.primary
                                                    : colorScheme.secondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
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
