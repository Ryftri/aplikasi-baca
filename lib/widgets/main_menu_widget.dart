import 'package:aplikasi_baca/common/result_state.dart';
import 'package:aplikasi_baca/data/models/user_model.dart';
import 'package:aplikasi_baca/data/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainMenuWidget extends StatefulWidget {
  final UserModel userModel;

  const MainMenuWidget({super.key, required this.userModel});

  @override
  State<MainMenuWidget> createState() => _MainMenuWidgetState();
}

class _MainMenuWidgetState extends State<MainMenuWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(widget.userModel.email)
      ]
    );
  }
}
