import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maca/function/app_function.dart';
import 'package:maca/page/landing_page.dart';
import 'package:maca/page/marketing_page.dart';
import 'package:maca/styles/colors/app_colors.dart';
import 'package:maca/tabs/more/more.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  dynamic borderListData = [];
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    LandingPage(),
    MarketingPage(),
    More(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    macaPrint(_selectedIndex, "currentIndex");
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        if (_selectedIndex != 0) {
          setState(() {
            _selectedIndex = 0;
          });

          return false;
        } else {
          SystemNavigator.pop();
          return true;
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.backGround,
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.theme,
          onPressed: () {
            showBedSelectionModal(context, _selectedIndex == 2 ? 7 : _selectedIndex);
          },
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300), // Animation duration
            transitionBuilder: (child, animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: Icon(
              getCurrentPageIcon(_selectedIndex),
              key: ValueKey<int>(_selectedIndex), // Unique key for AnimatedSwitcher
              color: AppColors.themeWhite,
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: AppColors.theme, borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: BottomNavigationBar(
            elevation: 0,
            backgroundColor: const Color.fromARGB(0, 40, 46, 137),
            unselectedItemColor: AppColors.themeLite,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Activity',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.widgets_rounded),
                label: 'More',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: AppColors.themeWhite,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
