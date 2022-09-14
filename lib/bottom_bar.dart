import 'package:flutter/material.dart';
import 'storybook_flutter_tab.dart';
import 'widgetbook_tab.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  var _selectedTabIndex = 0;

  Widget _pageOptions(int tabIndex) {
    switch (tabIndex) {
      case 0:
        return StorybookFlutterTab();
      case 1:
        return WidgetbookTab();
      default:
        return const Text('No such page');
    }
  }

  void _onBottomBarTap(int tabIndex) {
    setState(() {
      _selectedTabIndex = tabIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageOptions(_selectedTabIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Container(),
            label: 'storybook_flutter',
          ),
          BottomNavigationBarItem(
            icon: Container(),
            label: 'widgetbook',
          ),
        ],
        currentIndex: _selectedTabIndex,
        onTap: _onBottomBarTap,
      ),
    );
  }
}
