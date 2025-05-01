import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halal_media/core/theme/app_color.dart';
import 'package:halal_media/core/theme/text_design.dart';
import 'package:halal_media/data/repositories/playlist_repo.dart';
import 'package:halal_media/data/repositories/profile_repo.dart';
import 'package:halal_media/data/repositories/video_repo.dart';
import 'package:halal_media/presentation/cubit/home/home_cubit.dart';
import 'package:halal_media/presentation/cubit/library/library_cubit.dart';
import 'package:halal_media/presentation/cubit/more/more_cubit.dart';
import 'package:halal_media/presentation/cubit/subscribed/subscribed_cubit.dart';
import 'package:halal_media/presentation/cubit/upload_video/upload_video_cubit.dart';
import 'package:halal_media/presentation/screen/home_screen/home_screen.dart';
import 'package:halal_media/presentation/screen/library_screen/library_screen.dart';
import 'package:halal_media/presentation/screen/more_screen/more_screen.dart';
import 'package:halal_media/presentation/screen/subscribed_screen/subscribed_screen.dart';
import 'package:halal_media/presentation/screen/upload_scren/upload_screen.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    BlocProvider(
      create: (_) => HomeCubit(VideoRepo())..videoLoad(),
      child: const HomeScreen(),
    ),
    BlocProvider(
      create: (context) => LibraryCubit(PlaylistRepo())..fetchPlaylist('1'),
      child: LibraryScreen(),
    ),

    BlocProvider(
      create: (_) => SubscribedCubit(ProfileRepo()),
      child: const SubscribedScreen(userId: '104'),
    ),
    BlocProvider(create: (_) => MoreCubit(), child: const MoreScreen()),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],

      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          backgroundColor: AppColor.white,
          unselectedItemColor: AppColor.black900,
          selectedItemColor: AppColor.green,
          type: BottomNavigationBarType.fixed,
          currentIndex:
              _selectedIndex >= 2 ? _selectedIndex + 1 : _selectedIndex,

          selectedLabelStyle: TextDesign().selectedNavText,
          unselectedLabelStyle: TextDesign().unselectedNavText,
          onTap: (index) {
            if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => BlocProvider(
                        create: (context) => UploadVideoCubit()..init(),
                        child: const UploadScreen(),
                      ),
                ),
              );
              return;
            }
            _onItemTapped(index > 2 ? index - 1 : index);
          },

          items: [
            _buildNavItem(0, 'home'),
            _buildNavItem(1, 'library'),
            BottomNavigationBarItem(
              icon: Container(
                decoration: BoxDecoration(
                  color: AppColor.green,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                child: Icon(Icons.add, color: Colors.white, size: 28),
              ),
              label: "",
            ),
            _buildNavItem(2, 'subscribed'),
            _buildNavItem(3, 'More'),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(int index, String name) {
    bool isSelected = _selectedIndex == index;
    return BottomNavigationBarItem(
      icon: Image.asset(
        'assets/icons/navbar/home_${isSelected ? "on" : "off"}.png',
        width: 24,
        height: 24,
      ),
      label: name[0].toUpperCase() + name.substring(1),
    );
  }
}
