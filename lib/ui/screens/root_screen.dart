import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:cupertino_native/cupertino_native.dart';
import 'home_screen.dart';
import 'eq_screen.dart';
import 'settings_screen.dart';
import '../theme.dart';
import '../widgets/ambient_background.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _index = 0;

  static const _screens = [
    HomeScreen(),
    EqScreen(),
    SettingsScreen(),
  ];

  void _onSelect(int i) {
    HapticFeedback.selectionClick();
    setState(() => _index = i);
  }

  @override
  Widget build(BuildContext context) {
    final c = AppColors.of(context);

    return AmbientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: IndexedStack(
          index: _index,
          children: _screens,
        ),
        bottomNavigationBar: Platform.isIOS
          ? SafeArea(
              minimum: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: CNTabBar(
                height: 85,
                iconSize: 24,
                tint: c.accent,
                split: false,
                items: const [
                  CNTabBarItem(
                    label: 'Audio',
                    icon: CNSymbol('waveform'),
                  ),
                  CNTabBarItem(
                    label: 'EQ',
                    icon: CNSymbol('slider.horizontal.3'),
                  ),
                  CNTabBarItem(
                    label: 'Settings',
                    icon: CNSymbol('gearshape'),
                  ),
                ],
                currentIndex: _index,
                onTap: _onSelect,
              ),
            )
          : NavigationBar(
              selectedIndex: _index,
              onDestinationSelected: _onSelect,
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.graphic_eq_outlined),
                  selectedIcon: Icon(Icons.graphic_eq),
                  label: 'Audio',
                ),
                NavigationDestination(
                  icon: Icon(Icons.tune_outlined),
                  selectedIcon: Icon(Icons.tune),
                  label: 'EQ',
                ),
                NavigationDestination(
                  icon: Icon(Icons.settings_outlined),
                  selectedIcon: Icon(Icons.settings),
                  label: 'Settings',
                ),
              ],
            ),
      ),
    );
  }
}
