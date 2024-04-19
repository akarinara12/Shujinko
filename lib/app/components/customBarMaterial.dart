import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomBottomBarMaterial extends StatelessWidget {

  final Color colorIcon = const Color(0xFFFFFFFF);
  final Color colorSelect = const Color(0xFFEA1818);
  final Color colorBackground = const Color(0xFF1B1B1D);
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomBarMaterial({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const Color colorIcon= Color(0xFFFFFFFF);
    const Color colorSelect= Color(0xFFEA1818);
    const Color colorBackground= Color(0xFF1B1B1D);

    return BottomNavigationBar(
      unselectedItemColor: colorIcon,
      selectedItemColor: colorSelect,
      onTap: onTap,
      currentIndex: currentIndex,
      showSelectedLabels: true,
      type: BottomNavigationBarType.fixed,
      backgroundColor: colorBackground,
      elevation: 0,
      selectedFontSize: 16,
      selectedLabelStyle: GoogleFonts.inriaSans(
          fontWeight: FontWeight.w700
      ),
      iconSize: 26,
      showUnselectedLabels: false,
      items: [
        _bottomNavigationBarItem(
          icon: Icons.house_rounded,
          label: 'Home',
        ),
        _bottomNavigationBarItem(
          icon: Icons.explore,
          label: 'Explore',
        ),
        _bottomNavigationBarItem(
          icon: Icons.local_activity,
          label: 'Activity',
        ),
        _bottomNavigationBarItem(
          icon: Icons.person_2_rounded,
          label: 'Profile',
        ),
      ],
    );
  }
  BottomNavigationBarItem _bottomNavigationBarItem({
    required IconData icon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}
