import 'package:flutter/material.dart';

class UserSettingsWidget extends StatefulWidget {
  const UserSettingsWidget({super.key});

  @override
  State<UserSettingsWidget> createState() => _UserSettingsWidgetState();
}

class _UserSettingsWidgetState extends State<UserSettingsWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('User Setting')
      ],
    );
  }
}