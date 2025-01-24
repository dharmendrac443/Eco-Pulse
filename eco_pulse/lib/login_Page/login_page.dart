import 'package:eco_pulse/home_page/home_page.dart';
import 'package:eco_pulse/registration_page/registration_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isVisible = false;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: _buildBackground(),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 60.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLogo(),
              _buildWelcomeText(),
              _buildForm(),
              _buildForgotPasswordLink(),
              _buildLoginButton(),
              _buildSignUpLink(),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBackground() {
    return const BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xff82f4b1), Color(0xff30c67c)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    );
  }

  Widget _buildLogo() {
    return const CircleAvatar(
      radius: 50,
      backgroundColor: Colors.white,
      child: Icon(
        Icons.person,
        size: 50,
        color: Color(0xff30c67c),
      ),
    );
  }

  Widget _buildWelcomeText() {
    return Column(
      children: const [
        SizedBox(height: 20),
        Text(
          "Welcome Back!",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.limeAccent,
          ),
        ),
        SizedBox(height: 10),
        Text(
          "Log in to continue",
          style: TextStyle(
            fontSize: 16,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Column(
      children: [
        _buildUsernameField(),
        const SizedBox(height: 16),
        _buildPasswordField(),
      ],
    );
  }

  Widget _buildUsernameField() {
    return TextField(
      controller: _usernameController,
      decoration: InputDecoration(
        labelText: 'Username',
        hintText: 'Enter your Username',
        hintStyle: const TextStyle(color: Colors.black26),
        labelStyle: const TextStyle(color: Colors.blueGrey),
        prefixIcon: const Icon(Icons.person, color: Colors.blueGrey),
        filled: true,
        fillColor: Colors.white.withAlpha(51),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.green, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.greenAccent),
        ),
      ),
      keyboardType: TextInputType.emailAddress,
      style: const TextStyle(color: Colors.black),
    );
  }

  Widget _buildPasswordField() {
    return TextField(
      controller: _passwordController,
      obscureText: !_isVisible,
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Enter your Password',
        hintStyle: const TextStyle(color: Colors.black26),
        labelStyle: const TextStyle(color: Colors.blueGrey),
        prefixIcon: const Icon(Icons.lock, color: Colors.blueGrey),
        suffixIcon: IconButton(
          icon: Icon(
            _isVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _isVisible = !_isVisible;
            });
          },
        ),
        filled: true,
        fillColor: Colors.white.withAlpha(51),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.green, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.greenAccent),
        ),
      ),
      style: const TextStyle(color: Colors.black),
    );
  }

  Widget _buildForgotPasswordLink() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          // Handle forgot password
        },
        child: const Text(
          'Forgot Password?',
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.yellow,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Text(
        'Login',
        style: TextStyle(
          color: Color(0xff30c67c),
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSignUpLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account?",
          style: TextStyle(color: Colors.black),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RegistrationPage()),
            );
          },
          child: const Text(
            'Sign Up',
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }
}