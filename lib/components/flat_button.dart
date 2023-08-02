import 'package:flutter/material.dart';

class FlatButton extends StatelessWidget {
  Function onPressed;
  String txt;
  Color backGroundColor;
  Color textColor;
  Color borderColor;
  IconData icon;
  double radius;
  FlatButton({required this.onPressed ,this.borderColor= Colors.white ,this.txt = "", this.backGroundColor = Colors.black, this.textColor = Colors.white, this.icon = Icons.verified, this.radius = 10});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ElevatedButton.icon(
          icon: Icon(icon),
          onPressed: () => onPressed(),
          label: Text(txt.toUpperCase(), style: TextStyle(fontSize: 14)),
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(textColor),
              backgroundColor: MaterialStateProperty.all<Color>(backGroundColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(radius)),
                      side: BorderSide(color: borderColor))))),
    );
  }
}