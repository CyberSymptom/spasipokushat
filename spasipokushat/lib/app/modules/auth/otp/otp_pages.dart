import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OtpPages extends StatelessWidget {
  const OtpPages({super.key});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 60,
      textStyle: TextStyle(
        fontSize: 22,
        color: Colors.black,
      ),
      decoration: BoxDecoration(
        color: Colors.orange.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.transparent),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Sms verification", style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Container(
          margin: EdgeInsets.only(top: 40),
          width: double.infinity,
          child: Column(
            children: [
              Text(
                "Verification code",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              Pinput(
                length: 4,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!
                      .copyWith(border: Border.all(color: Colors.orange)),
                ),
                onCompleted: (pin) => debugPrint(pin),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
