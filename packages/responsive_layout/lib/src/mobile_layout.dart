import 'package:flutter/material.dart';

class MobileLayout extends StatefulWidget {
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final List? navItems;
  final List<Widget>? pages;

  const MobileLayout({
    super.key,
    this.appBar,
    this.floatingActionButton,
    this.navItems,
    this.pages,
  });

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  int _selectedIndex = 0;

  void _onNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final body =
        (widget.pages != null && _selectedIndex < widget.pages!.length)
            ? widget.pages![_selectedIndex]
            : const SizedBox.shrink();

    return Scaffold(
      appBar: widget.appBar,
      body: Padding(padding: const EdgeInsets.all(24.0), child: body),
      floatingActionButton: widget.floatingActionButton,
      bottomNavigationBar:
          widget.navItems != null
              ? SizedBox(
                height: 100,
                child: BottomNavigationBar(
                  items:
                      widget.navItems!
                          .map(
                            (item) => BottomNavigationBarItem(
                              icon: Icon(item.unfilledIcon),
                              activeIcon: Icon(item.filledIcon),
                              label: item.label,
                            ),
                          )
                          .toList(),
                  currentIndex: _selectedIndex,
                  onTap: _onNavTap,
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
