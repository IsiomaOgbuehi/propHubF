import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  final String username;
  final String password;

  const Login({super.key, required this.username, required this.password});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}