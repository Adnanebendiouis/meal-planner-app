// ignore_for_file: non_constant_identifier_names, duplicate_ignore

import 'package:flutter/material.dart';
class MyTextfield extends StatelessWidget{

 // ignore: non_constant_identifier_names
 const MyTextfield({super.key, required this.TFHintText, required this.TFIcon, required this.TFController, required this.isObscure, this.TFValidator});
   // ignore: non_constant_identifier_names
   final String TFHintText;
  final Icon TFIcon;
  final TextEditingController TFController;
  final bool isObscure;
  final String? Function(String?)? TFValidator;

 

  @override
  Widget build(BuildContext context){
    return TextFormField(
      validator: TFValidator,
      controller: TFController,
      obscureText: isObscure,
      decoration: InputDecoration(
        hintText: TFHintText,
        prefixIcon: TFIcon,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
        filled: true,
        
      ),
    );
  }
}