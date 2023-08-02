import 'package:f/constants.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart' as pb;

class ProgressBut extends StatelessWidget {
  ProgressBut({super.key, required this.butttonState, required this.onPressed});
  var butttonState;
  Function onPressed;

  @override
  Widget build(BuildContext context) {
    return pb.ProgressButton.icon(iconedButtons: {
        pb.ButtonState.idle:
        IconedButton(
            text: "Auto Detect",
            icon: Icon(Icons.autorenew,color: Color(0xffffffff)),
            color: primaryColor),
        pb.ButtonState.loading:
        IconedButton(
            text: "Loading",
            color: warningColor),
        pb.ButtonState.fail:
        IconedButton(
            text: "Failed",
            icon: Icon(Icons.cancel,color: warningColor),
            color: warningColor),
        pb.ButtonState.success:
        IconedButton(
            text: "Success",
            icon: Icon(Icons.check_circle,color: Color(0xffffffff),),
            color: successColor)
      },
          onPressed: ()=> onPressed(),
          radius: 5.0,
          state: butttonState );
  }
}
