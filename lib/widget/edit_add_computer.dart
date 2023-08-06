import 'dart:math';

import 'package:f/components/flat_button.dart';
import 'package:f/components/progress_but.dart';
import 'package:f/constants.dart';
import 'package:f/models/Computer.dart';
import 'package:firedart/firedart.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:progress_state_button/progress_button.dart' as pb;
import 'package:windows_system_info/windows_system_info.dart';

class EditAddComputer extends StatefulWidget {
  Computer computer;
  EditAddComputer(Computer this.computer, {super.key});
  @override
  State<EditAddComputer> createState() => _EditAddComputerState();
}

class _EditAddComputerState extends State<EditAddComputer> {

  var butttonState = pb.ButtonState.idle;
  bool isUpdate = false;

  void _autoDetect() async {
    butttonState = pb.ButtonState.loading;
    setState(() {});
    await WindowsSystemInfo.initWindowsInfo();
    if (await WindowsSystemInfo.isInitilized) {
      _manufacturerController.text = WindowsSystemInfo.baseBoard!.manufacturer;
      _modelController.text = WindowsSystemInfo.os.toString();
      _operatorSystemController.text = WindowsSystemInfo.os!.distro + " " + WindowsSystemInfo.os!.arch;
      _cpuController.text = WindowsSystemInfo.cpu!.brand;
      _ramController.text = ((WindowsSystemInfo.memories[0]!.size+WindowsSystemInfo.memories[1]!.size)/ pow(1024, 3)).toString() + " GB";
      _physicalMemoryController.text = (WindowsSystemInfo.disks[0]!.size~/ pow(1024, 3)).toString()+" GB";
      _gpuController.text = WindowsSystemInfo.graphics!.controllers[0].model + ", " + WindowsSystemInfo.graphics!.controllers[1].model;
    }
    butttonState = pb.ButtonState.success;
    setState(() {});
  }

  Firestore firestore = Firestore.instance;
  List datas = [];
  void addComputer() async {
    await firestore.collection("computers").add({
      'manufacturer': _manufacturerController.text,
      'physicalMemory':_physicalMemoryController.text,
      'randomAccessMemory':_ramController.text,
      'processeur':_cpuController.text,
      'operateurSystem':_operatorSystemController.text,
      'graphicCards':_gpuController.text,
      'purchaseDate': _datepurchase
    });
    Navigator.pop(context);
  }

  void modifyComputer() async {
    await firestore.collection("computers").document(widget.computer.id).set({
      'manufacturer': _manufacturerController.text,
      'physicalMemory':_physicalMemoryController.text,
      'randomAccessMemory':_ramController.text,
      'processeur':_cpuController.text,
      'operateurSystem':_operatorSystemController.text,
      'graphicCards':_gpuController.text,
      'purchaseDate': _datepurchase
    });
    Navigator.pop(context);
  }

  late TextEditingController _manufacturerController;
  late TextEditingController _modelController;
  late TextEditingController _physicalMemoryController;
  late TextEditingController _ramController;
  late TextEditingController _cpuController;
  late TextEditingController _gpuController;
  late TextEditingController _operatorSystemController;

  var _datepurchase;

  @override void initState() {
    // TODO: implement initState
    _manufacturerController = TextEditingController();
    _modelController = TextEditingController();
    _operatorSystemController = TextEditingController();
    _cpuController = TextEditingController();
    _gpuController = TextEditingController();
    _physicalMemoryController = TextEditingController();
    _ramController = TextEditingController();

    if(widget.computer.id.isNotEmpty){
      isUpdate = true;
      _manufacturerController.text = widget.computer.manufacturer;
      _modelController.text = widget.computer.model;
      _operatorSystemController.text = widget.computer.operatorSystem;
      _cpuController.text = widget.computer.processeur;
      _gpuController.text = widget.computer.graphicCards;
      _physicalMemoryController.text = widget.computer.physicalMemory;
      _ramController.text = widget.computer.randomAccessMemory;
      _datepurchase = widget.computer.PurchaseDate;
    }
    super.initState();
  }

  void _showDatePicker(BuildContext context) {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2025))
        .then((value) {
      _datepurchase = value.toString();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: Text('Add Computer'),
      content: Column(
        children: [
          ProgressBut(butttonState:butttonState,onPressed: _autoDetect),
          SizedBox(
            height: 10,
          ),
          InfoLabel(
            label: 'Enter computer manufacturer:',
            child: TextBox(
              placeholder: 'Manufacturer',
              expands: false,
              controller: _manufacturerController,
            ),
          ),
          Offstage(
            offstage: true,
            child: Text("you must enter a manufacturer"),
          ),

          SizedBox(
            height: 10,
          ),
          InfoLabel(
            label: 'Enter computer operator system:',
            child: TextBox(
              placeholder: 'Operator System',
              expands: false,
              controller: _operatorSystemController,
            ),
          ),
          Offstage(
            offstage: true,
            child: Text("you must enter an operator system"),
          ),
          SizedBox(
            height: 10,
          ),
          InfoLabel(
            label: 'Enter computer processeur:',
            child: TextBox(
              placeholder: 'CPU',
              expands: false,
              controller: _cpuController,
            ),
          ),
          Offstage(
            offstage: true,
            child: Text("you must enter a CPU"),
          ),
          SizedBox(
            height: 10,
          ),
          InfoLabel(
            label: 'Enter computer random access memory:',
            child: TextBox(
              placeholder: 'RAM',
              expands: false,
              controller: _ramController,
            ),
          ),
          Offstage(
            offstage: true,
            child: Text("you must enter ram"),
          ),
          SizedBox(
            height: 10,
          ),
          InfoLabel(
            label: 'Enter computer physical memory:',
            child: TextBox(
              placeholder: 'physical memory',
              expands: false,
              controller: _physicalMemoryController,
            ),
          ),
          Offstage(
            offstage: true,
            child: Text("you must enter a model"),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 10,
          ),
          InfoLabel(
            label: 'Enter computer graphics:',
            child: TextBox(
              placeholder: 'Graphics',
              expands: false,
              controller: _gpuController,
            ),
          ),
          Offstage(
            offstage: true,
            child: Text("you must enter a model"),
          ),
          SizedBox(
            height: 10,
          ),
          InfoLabel(
            label: 'Enter computer purchase date:',
            child: FlatButton(
                onPressed: () => _showDatePicker(context),
                txt: _datepurchase.toString() == "null" ? "select date":_datepurchase.toString(),
                backGroundColor: Color(0xffffffff),
                textColor: primaryColor,
                borderColor: primaryColor,
                radius: 5,
                icon: Icons.date_range),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: ()=>Navigator.pop(context), child: Text('Cancel', style: TextStyle(color: primaryColor))),
        TextButton(onPressed: (){!isUpdate ? addComputer() : modifyComputer();}, child: Text(!isUpdate ? 'Add' : 'update',style: TextStyle(color: primaryColor),))
      ],
    );
  }
}

/*
SizedBox(
            height: 10,
          ),
          InfoLabel(
            label: 'Enter computer model:',
            child: TextBox(
              placeholder: 'Model',
              expands: false,
              controller: _modelController,
            ),
          ),
          Offstage(
            offstage: true,
            child: Text("you must enter a model"),
          ),
 */