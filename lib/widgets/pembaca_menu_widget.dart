import 'package:aplikasi_baca/data/models/user_model.dart';
import 'package:flutter/material.dart';

class PembacaMenuWidget extends StatefulWidget {
  final UserModel userModel;

  const PembacaMenuWidget({super.key, required this.userModel});

  @override
  State<PembacaMenuWidget> createState() => _PembacaMenuWidgetState();
}

class _PembacaMenuWidgetState extends State<PembacaMenuWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Pembaca"),
        Text(widget.userModel.email),
        SizedBox(
          height: 15,
        ),
        Text(widget.userModel.role.name)
      ]
    );
  }
}