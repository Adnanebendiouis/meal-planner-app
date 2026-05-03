import 'package:flutter/material.dart';
class MyElevatedButton extends StatelessWidget {
  const MyElevatedButton({super.key, required this.buttonLable, required this.onPressedFct});
  final String buttonLable;
  final Function() onPressedFct;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(onPressed: onPressedFct,style: ElevatedButton.styleFrom(
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black,
        side: BorderSide(color: Colors.black, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ), child: Text(buttonLable),),
    );
  }
}