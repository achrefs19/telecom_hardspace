import 'dart:math';

import 'package:f/components/flat_button.dart';
import 'package:f/components/progress_but.dart';
import 'package:f/constants.dart';
import 'package:f/models/Computer.dart';
import 'package:f/models/Reclamation.dart';
import 'package:f/services/mailer.dart';
import 'package:f/services/notification.dart';
import 'package:firedart/firedart.dart';
import 'package:firedart/generated/google/protobuf/timestamp.pb.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:local_notifier/local_notifier.dart';
import 'package:progress_state_button/progress_button.dart' as pb;

class EditAddReclamation extends StatefulWidget {
  Reclamation reclamation;
  EditAddReclamation(Reclamation this.reclamation, {super.key});
  @override
  State<EditAddReclamation> createState() => _EditAddReclamationState();
}

class _EditAddReclamationState extends State<EditAddReclamation> {

  var butttonState = pb.ButtonState.idle;
  bool _isUpdate = false;

  Firestore firestore = Firestore.instance;
  final userId = FirebaseAuth.instance!.userId;

  void addReclamation() async {

    var user = await firestore.collection("users").document(userId).get();

    await firestore.collection("reclamations").add({
      'title': _titleController.text,
      'description':_descriptionController.text,
      'priority': _selectedPiority,
      'createdAt': DateTime.now(),
      'userId': userId,
      'userName': user["firstName"]+" "+ user["lastName"],
    });

    notifier(title: user["firstName"]+" "+ user["lastName"],body: _titleController.text);
    Mailer();

    Navigator.pop(context);
  }

  void modifyComputer() async {
    await firestore.collection("computers").document(widget.reclamation.id).set({
      'title': _titleController.text,
      'description':_descriptionController.text,
      'priority': _selectedPiority,
      'modifiedAt': Timestamp().toString(),
      'userId': userId,
    });
    Navigator.pop(context);
  }

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  List<String> periority= ["medium","high","crucial"];
  String? _selectedPiority = "medium";

  var _datepurchase;

  @override void initState() {
    // TODO: implement initState
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();

    if(widget.reclamation.id.isNotEmpty){
      _isUpdate = true;
      _titleController.text = widget.reclamation.title;
      _descriptionController.text = widget.reclamation.description;
      _selectedPiority = widget.reclamation.priority;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: Text('Add Computer'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 10,
          ),
          InfoLabel(
            label: 'Title:',
            child: TextBox(
              placeholder: 'Title',
              expands: false,
              controller: _titleController,
            ),
          ),
          Offstage(
            offstage: true,
            child: Text("you must enter a topic"),
          ),

          SizedBox(
            height: 10,
          ),
          InfoLabel(
            label: 'Description',
            child: TextBox(
              placeholder: 'Description',
              expands: false,
              controller: _descriptionController,
              minLines: 5,
              maxLines: 8,
            ),
          ),
          Offstage(
            offstage: true,
            child: Text("you must enter an operator system"),
          ),
          Offstage(
            offstage: true,
            child: Text("you must enter a model"),
          ),
          SizedBox(
            height: 10,
          ),
          InfoLabel(
            label: 'Priority',
            child: ComboBox<String>(
              value: _selectedPiority,
              items: periority.map<ComboBoxItem<String>>((e) {
                return ComboBoxItem<String>(
                  child: Text(e),
                  value: e,
                );
              }).toList(),
              onChanged:(priorty) {
                setState(() => _selectedPiority = priorty);
              },
              placeholder: const Text('Select a cat breed'),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: ()=>Navigator.pop(context), child: Text('Cancel', style: TextStyle(color: primaryColor))),
        TextButton(onPressed: (){!_isUpdate ? addReclamation() : modifyComputer();}, child: Text(!_isUpdate ? 'Add' : 'update',style: TextStyle(color: primaryColor),))
      ],
    );
  }
}