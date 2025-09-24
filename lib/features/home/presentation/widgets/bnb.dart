import 'package:bloc_hive_caching_data/features/home/presentation/bloc/home_bloc.dart';
import 'package:bloc_hive_caching_data/features/home/presentation/bloc/home_status/products_status.dart';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

enum _SelectedTab { home, favorite, add, search, person }

class BNB extends StatefulWidget {
  const BNB({super.key});

  @override
  State<BNB> createState() => _BNBState();
}

class _BNBState extends State<BNB> {
  var _selectedTab = _SelectedTab.home;

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = _SelectedTab.values[i];
    });
  }

  @override
  Widget build(BuildContext context) {
    return context.watch<HomeBloc>().state.homeProductsStatus
            is HomeProductsStatusError
        ? Container()
        : Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: CrystalNavigationBar(
              currentIndex: _SelectedTab.values.indexOf(_selectedTab),
              height: 10,
              // indicatorColor: Colors.blue,
              unselectedItemColor: Colors.white70,
              borderWidth: 2,
              outlineBorderColor: Colors.white,
              backgroundColor: Colors.black.withValues(alpha: 0.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 4,
                  spreadRadius: 4,
                  offset: Offset(0, 10),
                ),
              ],
              onTap: _handleIndexChanged,
              items: [
                /// Home
                CrystalNavigationBarItem(
                  icon: IconlyBold.home,
                  unselectedIcon: IconlyLight.home,
                  selectedColor: Colors.white,
                  badge: Badge(
                    label: Text("9+", style: TextStyle(color: Colors.white)),
                  ),
                ),

                /// Favourite
                CrystalNavigationBarItem(
                  icon: IconlyBold.heart,
                  unselectedIcon: IconlyLight.heart,
                  selectedColor: Colors.red,
                ),

                /// Add
                CrystalNavigationBarItem(
                  icon: IconlyBold.plus,
                  unselectedIcon: IconlyLight.plus,
                  selectedColor: Colors.white,
                ),

                /// Search
                CrystalNavigationBarItem(
                  icon: IconlyBold.search,
                  unselectedIcon: IconlyLight.search,
                  selectedColor: Colors.white,
                ),

                /// Profile
                CrystalNavigationBarItem(
                  icon: IconlyBold.user_2,
                  unselectedIcon: IconlyLight.user,
                  selectedColor: Colors.white,
                ),
              ],
            ),
          );
  }
}
