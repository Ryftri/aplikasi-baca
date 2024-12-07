import 'package:aplikasi_baca/data/models/user_model.dart';
import 'package:flutter/material.dart';

class PenulisMenuWidget extends StatefulWidget {
  final UserModel userModel;
  
  const PenulisMenuWidget({super.key, required this.userModel});

  @override
  State<PenulisMenuWidget> createState() => _PenulisMenuWidgetState();
}

class _PenulisMenuWidgetState extends State<PenulisMenuWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          width: double.infinity,
          child: Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(onPressed: () {}, child: Text('eko')),
          ),
        ),
        Text(widget.userModel.email),
        SizedBox(
          height: 15,
        ),
        Text(widget.userModel.role.name)
      ]
    );
  }
}