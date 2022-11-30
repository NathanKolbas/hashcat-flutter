import 'package:flutter/material.dart';
import 'package:hashcat_flutter/pages/cracking/cracking.dart';
import 'package:hashcat_flutter/pages/settings/settings.dart';
import 'package:hashcat_flutter/pages/toolbox/toolbox.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );
  int _selectedIndex = 0;

  void _bottomBarTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  void _pageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          onPageChanged: _pageChanged,
          children: const <Widget>[
            Cracking(),
            Toolbox(),
            Settings(),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.no_encryption_outlined),
              label: 'Crack',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home_repair_service_outlined),
              label: 'Toolbox',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _bottomBarTapped,
        ),
      ),
    );
  }
}
