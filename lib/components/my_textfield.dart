import 'package:flutter/material.dart';
class MyTextfield extends StatelessWidget{

 MyTextfield({super.key, required this.TFHintText, required this.TFIcon, required this.TFController, required this.isObscure, this.TFValidator});
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