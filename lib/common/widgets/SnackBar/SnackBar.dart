import 'package:flutter/material.dart';

ShowSnackBar(BuildContext context, String msg, int colorr) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
    //backgroundColor: Color(colorr),
    duration: const Duration(seconds: 5),
    content: Container(
      padding: const EdgeInsets.all(16),
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color:Color( colorr),
      ),
      child: Text(
        msg,
        style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
      ),
    ),

behavior: SnackBarBehavior.floating,
backgroundColor: Colors.transparent,
elevation: 0,


    // action: SnackBarAction(label: "exit" , onPressed: (){},),
  )
  
  
  );
}
