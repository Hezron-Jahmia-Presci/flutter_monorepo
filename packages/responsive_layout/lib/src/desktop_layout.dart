import 'package:flutter/material.dart';

class DesktopLayout extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final List navItems;
  final List<Widget> pages;
  final int selectedIndex;
  final ValueChanged<int> onNavTap;
  final int? trailingCount;

  const DesktopLayout({
    super.key,
    this.appBar,
    this.floatingActionButton,
    required this.navItems,
    required this.pages,
    required this.selectedIndex,
    required this.onNavTap,
    this.trailingCount,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final int splitIndex =
        trailingCount != null
            ? navItems.length - trailingCount!
            : navItems.length;

    final topItems = navItems.sublist(0, splitIndex);
    final trailingItems =
        trailingCount != null ? navItems.sublist(splitIndex) : [];

    return Scaffold(
      appBar: appBar,
      floatingActionButton: floatingActionButton,
      body: Row(
        children: [
          NavigationRail(
            minWidth: 100,
            selectedIndex: selectedIndex,
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
                topItems.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;
                  final isSelected = selectedIndex == index;

                  return NavigationRailDestination(
                    icon: Icon(item.unfilledIcon),
                    selectedIcon: Icon(item.filledIcon),
                    label:
                        isSelected ? const SizedBox.shrink() : Text(item.label),
                  );
                }).toList(),
            trailing:
                trailingItems.isNotEmpty
                    ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children:
                          trailingItems.asMap().entries.map((entry) {
                            final offsetIndex = splitIndex + entry.key;
                            final item = entry.value;
                            final isSelected = selectedIndex == offsetIndex;

                            return IconButton(
                              icon: Icon(
                                isSelected
                                    ? item.filledIcon
                                    : item.unfilledIcon,
                              ),
                              tooltip: item.label,
                              onPressed: () => onNavTap(offsetIndex),
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
