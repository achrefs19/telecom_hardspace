import 'package:f/constants.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:badges/Badges.dart' as badges;
import 'package:flutter/material.dart' as material;

class MyBadge extends StatefulWidget {
  MyBadge(this.number, {super.key});
  int number;

  @override
  State<MyBadge> createState() => _MyBadgeState();
}

class _MyBadgeState extends State<MyBadge> {
  @override
  Widget build(BuildContext context) {
    return badges.Badge(
      position: badges.BadgePosition.topEnd(top: -10, end: -12),
      showBadge: true,
      ignorePointer: false,
      onTap: () {},
      badgeContent:
      Text(widget.number.toString()),
      badgeAnimation: const badges.BadgeAnimation.scale(
        animationDuration: Duration(seconds: 1),
        colorChangeAnimationDuration: Duration(seconds: 1),
        loopAnimation: false,
        curve: Curves.fastOutSlowIn,
        colorChangeAnimationCurve: Curves.easeInCubic,
      ),
      badgeStyle: badges.BadgeStyle(
        shape: badges.BadgeShape.square,
        badgeColor: primaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 1,vertical: 2),
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: Colors.white, width: 2),
         borderGradient: const badges.BadgeGradient.linear(
            colors: [primaryColor, primaryColor]),
        badgeGradient: const badges.BadgeGradient.linear(
          colors: [primaryColor, secondaryColor],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        elevation: 0,
      ),
      child: const Icon(material.Icons.remove_red_eye_outlined, color: Colors.black, size: 30),

    );
  }
}
