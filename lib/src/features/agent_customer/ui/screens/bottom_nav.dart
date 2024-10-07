import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:prophub/src/features/agent_customer/ui/screens/home/home.dart';
import 'package:prophub/src/features/agent_customer/ui/screens/profile/profile.dart';
import 'package:prophub/src/features/agent_customer/ui/screens/search/search.dart';
import 'package:prophub/src/theme/app_colors.dart';

import 'chat/chat.dart';

class BottomNav extends ConsumerStatefulWidget {
  const BottomNav({super.key});

  @override
  ConsumerState<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends ConsumerState<BottomNav> {
  int _selectedIndex = 0;
  static const List<Widget> _pages = <Widget>[
    HomeScreen(),
    SearchScreen(),
    ChatScreen(),
    ProfileScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Iconsax.home_1),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.search_normal_1),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.message_2),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.profile_2user),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: AppColors.primaryDark,
        selectedItemColor: AppColors.primary,
        unselectedLabelStyle: const TextStyle(color: AppColors.primaryDark),
        showUnselectedLabels: true,
        onTap: _onItemTapped,
      ),
    );
  }
}