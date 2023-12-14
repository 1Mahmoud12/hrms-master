import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {

  final TextEditingController _controller;

  const AuthTextField(this._controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      cursorColor: Colors.white,
      decoration: InputDecoration(
          labelStyle: const TextStyle(color: Colors.white),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.white, width: 2),),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 2.0),
              borderRadius: BorderRadius.circular(20),
          ),
      ),
    );
  }
}
