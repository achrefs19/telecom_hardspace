import 'dart:io';

import 'package:f/components/my_alert_dialog.dart';
import 'package:f/components/rounded_button.dart';
import 'package:f/components/text_input.dart';
import 'package:f/components/user_image_picker.dart';
import 'package:f/constants.dart';
import 'package:f/models/User.dart';
import 'package:f/services/auth_service.dart';
import 'package:firedart/firedart.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  User user = User();
  bool emailMatch=true;
  bool passwordMatch = true;
  bool confirmPasswordMatch = true;
  bool emailNotExist=true;

  bool _validate(){
    if(_emailController.text.isEmpty || !_emailController.text.contains('@') || !_emailController.text.contains('.')){
      setState(() {emailMatch = false;});
      return false;
    } else {
      setState(() {emailMatch = true;});
    }

    if(_passwordController.text.isEmpty || _passwordController.text.length < 8){
      setState(() {passwordMatch = false;});
      return false;
    } else {
      setState(() {passwordMatch = true;});
    }

    if(!_isLogin){
      if(_passwordController.text != _confirmPasswordController.text){
        setState(() {passwordMatch = false;});
        return false;
      } else {
        setState(() {passwordMatch = true;});
      }
    }

    setState(() {});
    return true;
  }

  void _submit() async {

    if(!_validate()) {
      return;
    }
    final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();
      if (_isLogin) {
        userCredentials = _firebaseAuthService.signIn(_emailController.text, _passwordController.text);
      }
      else {
        userCredentials = _firebaseAuthService.signUp(_emailController.text, _passwordController.text);
      }

      //final storageRef = storage.ref().child("user_images").child("ss");
      //await storageRef.putFile(_selectedImage!);
    }

  late TextEditingController _firstNameController ;
  late TextEditingController _lastNameController ;
  late TextEditingController _emailController ;
  late TextEditingController _passwordController ;
  late TextEditingController _confirmPasswordController ;

  @override
  void initState() {
    // TODO: implement initState
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    super.initState();
  }

    /*
    await _firebaseAuthService.signIn(user.email, user.password);
    if (_isLogin) {
      userCredentials =
          await _firebaseAuthService.signIn(user.email, user.password);
    } else {
      userCredentials = await _firebase.signUp(user.email, user.password);
    }*/

    //get storageRef
    /*final storageRef = .instance
          .ref()
          .child('user_images')
          .child('${userCredentials.user!.uid}.jpg');
      //put file in storage
      await storageRef.putFile(_selectedImage!);

      final imageUrl = await storageRef.getDownloadURL();*/

    /*await Firestore.instance
        .collection('users')
        .document(userCredentials.user!.uid)
        .set({
      'firstname': user.firstName,
      'lastname': user.lastName,
      'email': user.email,
      //'image_url' : imageUrl,
    });*/

  var _isLogin = true;
  File? _selectedImage;

  var userCredentials;
  final _firebase = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: blankColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery. of(context). size. width/2,
            color: blankColor,
            margin: EdgeInsets.only(left: 30, right: 30),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (_isLogin)
                    Hero(
                        tag: 'profile pic',
                        child: Container(
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Container(height: 100,width: 200,child: Image.asset('assets/Tunisie-Telecom.png'))),
                        )),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      _isLogin ? 'Welcome back !' : 'Register Now !',
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if (!_isLogin)
                    UserImagePicker(
                      onPickImage: (pickedImage) => _selectedImage = pickedImage,
                    ),
                  if (!_isLogin)
                    TextInput(assetImage: 'assets/enveloppe.png', controller: _firstNameController, hintText: 'First Name'),
                  SizedBox(
                    height: 10,
                  ),
                  if (!_isLogin)
                    TextInput(assetImage: 'assets/enveloppe.png', controller: _lastNameController, hintText: 'Last Name'),
                  SizedBox(
                    height: 10,
                  ),
                  TextInput(assetImage: 'assets/enveloppe.png', controller: _emailController, hintText: 'Email'),
                  Offstage(
                    offstage: emailMatch,
                    child: const Text("you must enter a valid email"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextInput(assetImage: 'assets/verrouiller.png', isPassword: true, controller: _passwordController, hintText: 'Password'),
                  Offstage(
                    offstage: passwordMatch,
                    child: const Text("password must be at least 8 characters"),
                  ),

                  /*TextBox(
                    placeholder: 'Password',
                    cursorColor: primaryColor,
                    padding: EdgeInsets.fromLTRB(40,10,10,20),
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    obscureText: true,
                    decoration: const BoxDecoration(
                      border: Border(top: BorderSide.none),
                      image: DecorationImage(image: AssetImage('assets/verrouiller.png'),alignment: AlignmentDirectional.centerStart,),
                      color: m.Colors.transparent,
                    ),
                    highlightColor: primaryColor,
                    expands: false,
                    controller: _passwordController,
                  )*/
                  SizedBox(
                    height: 10,
                  ),

                  if (!_isLogin)
                    TextInput(assetImage: 'assets/verrouiller.png', controller: _confirmPasswordController, hintText: 'Confirm Password'),
                  Offstage(
                    offstage: confirmPasswordMatch,
                    child: const Text("Passwords doesn't correspond"),
                  ),
                  /*Row(
                    children: [
                      Checkbox(
                        onChanged: (v)=>{},
                        value: false,
                        shape: CircleBorder(),
                        fillColor: MaterialStateProperty.resolveWith((states) => secondaryColor,),
                      ),
                      Text('Remember me',style: TextStyle(
                        color: secondaryColor
                      ),)
                    ],
                  ),*/
                  SizedBox(
                    height: 30,
                  ),
                  RoundedButton(
                    onPressed: () => _submit(),
                    txt: _isLogin ? "Login" : 'Signup',
                    backGroundColor: primaryColor,
                    textColor: blankColor,
                    borderColor: secondaryColor,
                    radius: 5,
                  ),
                  m.TextButton(
                      onPressed: () => setState(() {
                            _isLogin = _isLogin ? false : true;
                          }),
                      child: Text(
                        _isLogin
                            ? 'Create an accound'
                            : 'I already have an account',
                        style: TextStyle(color: secondaryColor),
                      ))
                ]),
          ),
        ],
      ),
    );
  }
}

/*
RoundedButton(
txt: "s'inscrire",
onPressed: () => Auth(
User(
firstName: _firstNameController.text,
lastName: _lastNameController.text,
email: _emailController.text,
governorate: _governorateController.text,
city: _cityController.text,
password: _passwordController.text,
confirmPassword: _confirmPasswordController.text),
context),
backGroundColor: Colors.white,
textColor: Colors.black38,
borderColor: Colors.black38,
),
RoundedButton(
onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => UsersListScreen())))
],*/
