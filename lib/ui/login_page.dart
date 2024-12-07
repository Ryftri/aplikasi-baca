import 'package:aplikasi_baca/common/result_state.dart';
import 'package:aplikasi_baca/data/providers/auth_provider.dart';
import 'package:aplikasi_baca/ui/regristation_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../common/navigation.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  static const routeName = 'login_page';

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    await authProvider.login(_usernameController.text, _passwordController.text);

    if(context.mounted) {
      if (authProvider.state == ResultState.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login successful')),
        );
        Navigation.intentWithDataReplacement(HomePage.routeName, authProvider.userModel);
      } else if (authProvider.state == ResultState.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${authProvider.message}')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid username or password')),
        );
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: ChangeNotifierProvider<AuthProvider>(
        create: (_) => AuthProvider(),
        child: Consumer<AuthProvider>(
          builder: (loginContext, providerState, _) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(labelText: 'Username'),
                  ),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  const SizedBox(height: 16.0),
                  TextButton(
                    onPressed: () {
                      Navigation.intentWithNoData(RegistrationPage.routeName);
                    },
                    child: const Text('Daftar disini.'),
                  ),
                  const SizedBox(height: 16.0),
                  providerState.state == ResultState.loading
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: () => _login(loginContext),
                          child: const Text('Login'),
                        ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
