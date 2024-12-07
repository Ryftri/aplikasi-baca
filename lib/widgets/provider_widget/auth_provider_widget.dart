import 'package:aplikasi_baca/data/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthProviderWidget extends StatefulWidget {
  final Widget Function(BuildContext, AuthProvider, Widget?) builder;

  const AuthProviderWidget({super.key, required this.builder});

  @override
  State<AuthProviderWidget> createState() => _AuthProviderWidgetState();
}

class _AuthProviderWidgetState extends State<AuthProviderWidget> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthProvider>(
      create: (_) => AuthProvider(),
      child: Consumer<AuthProvider>(
        builder: widget.builder
      ),
    );
  }
}