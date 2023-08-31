import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mytradeasia/config/themes/theme.dart';

class NavigationBarWidget extends StatefulWidget {
  const NavigationBarWidget({super.key, required this.child});

  final Widget child;

  @override
  State<NavigationBarWidget> createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends State<NavigationBarWidget> {
  void _onTapItem(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).go("/home");
        break;
      case 1:
        GoRouter.of(context).go("/messages");
        break;
      case 2:
        GoRouter.of(context).go("/history");
        break;
      case 3:
        GoRouter.of(context).go("/mytradeasia");
        break;
    }
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/home')) {
      return 0;
    }
    if (location.startsWith('/message')) {
      return 1;
    }
    if (location.startsWith('/history')) {
      return 2;
    }
    if (location.startsWith('/mytradeasia')) {
      return 3;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              activeIcon:
                  ImageIcon(AssetImage("assets/images/icon_home_active.png")),
              icon: ImageIcon(
                  AssetImage("assets/images/icon_home_not_active.png")),
              label: "Home",
            ),
            BottomNavigationBarItem(
              activeIcon: ImageIcon(
                  AssetImage("assets/images/icon_message_active.png")),
              icon: ImageIcon(
                  AssetImage("assets/images/icon_message_not_active.png")),
              label: "Message",
            ),
            BottomNavigationBarItem(
              activeIcon: ImageIcon(
                  AssetImage("assets/images/icon_history_active.png")),
              icon: ImageIcon(
                  AssetImage("assets/images/icon_history_not_active.png")),
              label: "History",
            ),
            BottomNavigationBarItem(
              activeIcon: ImageIcon(
                  AssetImage("assets/images/icon_mytradeasia_active.png")),
              icon: ImageIcon(
                  AssetImage("assets/images/icon_mytradeasia_not_active.png")),
              label: "My Tradeasia",
            ),
          ],
          selectedItemColor: const Color(0XFF123C69),
          selectedFontSize: 12.0,
          selectedLabelStyle: body1Regular,
          unselectedLabelStyle: body1Medium,
          unselectedItemColor: const Color(0XFF597796),
          currentIndex: _calculateSelectedIndex(context),
          onTap: (int index) => _onTapItem(index, context)),
      body: widget.child,
      // body: _widgetOption.elementAt(_selectedIndex),
    );
  }
}
