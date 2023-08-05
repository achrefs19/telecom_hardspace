import 'package:fluent_ui/fluent_ui.dart';

class TextInput extends StatelessWidget {

  final TextEditingController controller;
  final String assetImage;
  final String hintText;
  final double radius;
  final bool isPassword;
  final Color color;

  TextInput({Key? key , this.color = const Color(0xff68b0c5) , this.radius = 30, this.isPassword=false , required this.assetImage ,required this.controller, this.hintText = "Type in your text"}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextBox(
      placeholder: hintText,
      cursorColor: color,
      padding: EdgeInsets.fromLTRB(40,10,10,20),
      style: TextStyle(
        fontSize: 20,
      ),
      obscureText: isPassword,
      decoration: BoxDecoration(
        border: Border(top: BorderSide.none),
        image: DecorationImage(image: ResizeImage(AssetImage(assetImage),height: 20,width: 20),alignment: AlignmentDirectional.centerStart,),
        color: Colors.transparent,
      ),
      highlightColor: color,
      expands: false,
      controller: controller,
    );
  }
}
