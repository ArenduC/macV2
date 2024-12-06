import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:maca/function/app_function.dart';
import 'package:maca/page/landing_page.dart';
import 'package:maca/page/marketing_page.dart';
import 'package:maca/styles/colors/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  dynamic borderListData = [];
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    LandingPage(),
    MarketingPage(),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    macaPrint(_selectedIndex, "currentIndex");
  }

  void showBedSelectionModal(dynamic value) {
    showModalBottomSheet(
        context: context,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        isScrollControlled: true, // Allows the modal to take more space
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(20)), // Optional rounded corners
        ),
        builder: (context) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(), // Dismiss keyboard
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height,
                ),
                child: getModalItem(value),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.theme,
        onPressed: () {
          showBedSelectionModal(_selectedIndex);
        },
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300), // Animation duration
          transitionBuilder: (child, animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          child: Icon(
            getCurrentPageIcon(_selectedIndex),
            key: ValueKey<int>(
                _selectedIndex), // Unique key for AnimatedSwitcher
            color: AppColors.themeWhite,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
            color: AppColors.theme,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
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
              icon: Icon(Icons.school),
              label: 'School',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: AppColors.themeWhite,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
