import 'package:aplikasi_baca/data/models/user_model.dart';
import 'package:aplikasi_baca/data/models/user_role.dart';
import 'package:aplikasi_baca/widgets/main_menu_widget.dart';
import 'package:aplikasi_baca/widgets/pembaca_menu_widget.dart';
import 'package:aplikasi_baca/widgets/penulis_menu_widget.dart';
import 'package:aplikasi_baca/widgets/user_setting_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const routeName = 'home_page';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static List<Widget> _pages(UserModel userModel) {
    return [
      userModel.role == UserRole.pembaca ? 
        PembacaMenuWidget(userModel: userModel) : PenulisMenuWidget(userModel: userModel),
      UserSettingsWidget(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final UserModel userModel = ModalRoute.of(context)!.settings.arguments as UserModel;
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: _pages(userModel)[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Main Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'User Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}