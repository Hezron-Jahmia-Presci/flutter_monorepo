import 'package:flutter/material.dart';

class DesktopLayout extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final List navItems;
  final List? trailingNavItems; // <- added support for trailing
  final List<Widget> pages;
  final int selectedIndex;
  final ValueChanged<int> onNavTap;

  const DesktopLayout({
    super.key,
    this.appBar,
    this.floatingActionButton,
    required this.navItems,
    this.trailingNavItems,
    required this.pages,
    required this.selectedIndex,
    required this.onNavTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

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
                navItems.asMap().entries.map((entry) {
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

            // Bottom trailing icons (optional)
            trailing:
                trailingNavItems != null
                    ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children:
                          trailingNavItems!.asMap().entries.map((entry) {
                            final indexOffset = navItems.length + entry.key;
                            final item = entry.value;
                            final isSelected = selectedIndex == indexOffset;

                            return IconButton(
                              icon: Icon(
                                isSelected
                                    ? item.filledIcon
                                    : item.unfilledIcon,
                              ),
                              tooltip: item.label,
                              onPressed: () => onNavTap(indexOffset),
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
