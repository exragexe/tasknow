import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    
    Future.delayed( const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/home'); 
    });
    return const Material(
      color: Color.fromARGB(255, 201, 201, 201),
      child:SizedBox(
        
        child: Center(
          child:Align(
          alignment: Alignment(0, 0.1),
          child: Image(
            image: AssetImage("assets/1.png"),
            
          ),
        ),
        ),
      ),
    );
  }
}