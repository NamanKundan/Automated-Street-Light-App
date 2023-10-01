import 'package:flutter/material.dart';

class PowerButton extends StatefulWidget {
  @override
  _PowerButtonState createState() => _PowerButtonState();
}

class _PowerButtonState extends State<PowerButton> {
  bool isOn = false;

  void togglePower() {
    setState(() {
      isOn = !isOn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextButton(
          onPressed: togglePower,
          child: Container(
            width: 100.0,
            height: 100.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isOn ? Colors.blue : Colors.white,
            ),
            child: Center(
              child: Icon(
                isOn ? Icons.power_settings_new : Icons.power_off,
                color: isOn ? Colors.white : Colors.black,
                size: 40.0,
              ),
            ),
          ),
        ),
        SizedBox(height: 16.0),
        Text(
          isOn ? 'Power On' : 'Power Off',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
