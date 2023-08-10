import 'package:flutter/material.dart';

class SendButton extends StatelessWidget {
  final Function onPressed;
  String txt;
  Color backGroundColor;
  Color textColor;
  Color borderColor;
  double radius;
  SendButton({required this.onPressed,this.txt = "", this.backGroundColor = Colors.black, this.textColor = Colors.white, this.borderColor = Colors.black, this.radius = 10});

  @override
  Widget build(BuildContext context) {
    return new SizedBox(
        child: ElevatedButton.icon(
            onPressed: () => onPressed(),
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(textColor),
                backgroundColor: MaterialStateProperty.all<Color>(backGroundColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(radius)),
                        side: BorderSide(color: borderColor)))), icon: Icon(Icons.send), label: Text(txt.toUpperCase(), style: TextStyle(fontSize: 20)))
    );
  }
}