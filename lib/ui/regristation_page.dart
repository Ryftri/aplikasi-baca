import 'package:flutter/material.dart';
import '../common/services/auth_service.dart';
import '../data/models/user_role.dart';

class RegistrationPage extends StatefulWidget {
  static const routeName = 'registration_page';

  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _namaPanjangController = TextEditingController();
  UserRole? _selectedRole;
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  final List<UserRole> _roles = UserRole.values;

  void _register() async {
    try {
      if (_usernameController.text.isEmpty || _emailController.text.isEmpty ||
          _passwordController.text.isEmpty || _namaPanjangController.text.isEmpty ||
          _selectedRole == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill in all fields')),
        );
        return;
      }

      setState(() {
        _isLoading = true;
      });

      final result = await _authService.registerUser(
        _usernameController.text,
        _emailController.text,
        _passwordController.text,
        _namaPanjangController.text,
        _selectedRole!,
      );

      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result ? 'Registration successful' : 'Registration failed')),
      );
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _namaPanjangController,
              decoration: const InputDecoration(labelText: 'Nama Panjang'),
            ),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            DropdownButtonFormField<UserRole>(
              value: _selectedRole,
              decoration: const InputDecoration(labelText: 'Role'),
              items: _roles.map((role) {
                return DropdownMenuItem<UserRole>(
                  value: role,
                  child: Text(role.name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedRole = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _isLoading ? null : _register,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
