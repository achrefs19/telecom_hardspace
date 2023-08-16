import 'dart:math';

import 'package:f/components/flat_button.dart';
import 'package:f/components/my_multi_select.dart';
import 'package:f/components/progress_but.dart';
import 'package:f/constants.dart';
import 'package:f/enums/printer_function.dart';
import 'package:f/enums/printer_type.dart';
import 'package:f/models/Printer.dart';
import 'package:firedart/firedart.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:progress_state_button/progress_button.dart' as pb;
import 'package:windows_system_info/windows_system_info.dart';
import 'package:process_run/shell.dart';

class EditAddPrinter extends StatefulWidget {
  Printer printer;
  EditAddPrinter(this.printer, {super.key});
  @override
  State<EditAddPrinter> createState() => _EditAddPrinterState();
}

class _EditAddPrinterState extends State<EditAddPrinter> {
  var butttonState = pb.ButtonState.idle;
  bool isUpdate = false;
  List<PrinterFunction?> _printerFunctions = [];
  String? _selectedType = "";

  /*void _autoDetect() async {
    butttonState = pb.ButtonState.loading;
    setState(() {});
    var shell = Shell();
    // Dump outputs.
    await shell.run('powershell -c "Get-Printer"').then((value) => print(value.outLines));
    //var s = await shell.startAndReadAsString("powershell -Command " + '"Get-Host | Select-Object Version"');
    //_manufacturerController.text = await shell.startAndReadAsString('powershell script.ps1');
      _modelController.text = widget.printer.model;
      _colourPrintSpeedController.text = widget.printer.colourPrintSpeed;
      _monoPrintSpeedController.text = widget.printer.monoPrintSpeed;
      _resolutionController.text = widget.printer.resolution;
      _dimensionsController.text = widget.printer.dimensions;
      _weightController.text = widget.printer.weight;

    butttonState = pb.ButtonState.success;
    setState(() {});
  }*/

  Firestore fireStore = Firestore.instance;
  List datas = [];
  void addPrinter() async {
    print(_printerFunctions);
    /*await fireStore.collection("printers").add({
      'manufacturer': _manufacturerController.text,
      'model': _modelController.text,
      'type': _selectedType,
      'functions': _printerFunctions,
      'resolution': _resolutionController.text,
      'monoPrintSpeed': _monoPrintSpeedController.text,
      'colourPrintSpeed': _colourPrintSpeedController.text,
      'dimensions': _dimensionsController.text,
      'weight': _weightController.text,
      'purchaseDate': _datepurchase,
      'userId': "not used",
      'status': "not used"
    });
    Navigator.pop(context);*/
  }

  void modifyPrinter() async {
    await fireStore.collection("printers").document(widget.printer.id).set({
      'manufacturer': _manufacturerController.text,
      'model': _modelController.text,
      'resolution': _resolutionController.text,
      'monoPrintSpeed': _monoPrintSpeedController.text,
      'colourPrintSpeed': _colourPrintSpeedController.text,
      'dimensions': _dimensionsController.text,
      'weight': _weightController.text,
      'purchaseDate': _datepurchase,
      'userId': widget.printer.userId,
      'status': widget.printer.status
    });
    Navigator.pop(context);
  }

  late TextEditingController _manufacturerController;
  late TextEditingController _modelController;
  late TextEditingController _resolutionController;
  late TextEditingController _monoPrintSpeedController;
  late TextEditingController _colourPrintSpeedController;
  late TextEditingController _dimensionsController;
  late TextEditingController _weightController;

  var _datepurchase;

  @override
  void initState() {
    // TODO: implement initState
    _manufacturerController = TextEditingController();
    _modelController = TextEditingController();
    _resolutionController = TextEditingController();
    _colourPrintSpeedController = TextEditingController();
    _monoPrintSpeedController = TextEditingController();
    _dimensionsController = TextEditingController();
    _weightController = TextEditingController();

    if (widget.printer.id.isNotEmpty) {
      isUpdate = true;
      _manufacturerController.text = widget.printer.manufacturer;
      _modelController.text = widget.printer.model;
      _colourPrintSpeedController.text = widget.printer.colourPrintSpeed;
      _monoPrintSpeedController.text = widget.printer.monoPrintSpeed;
      _resolutionController.text = widget.printer.resolution;
      _dimensionsController.text = widget.printer.dimensions;
      _weightController.text = widget.printer.weight;
      _datepurchase = widget.printer.PurchaseDate;
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
      title: const Text('Add Printer'),
      content: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InfoLabel(
              label: 'Select printer type:',
              child: Container(
                height: 40,
                child: ComboBox<String>(
                  icon: Icon(FluentIcons.print),
                  iconSize: 15,
                  iconEnabledColor: primaryColor,
                  value: _selectedType!.isEmpty ? null : _selectedType,
                  items: PrinterType.values.map<ComboBoxItem<String>>((e) {
                    return ComboBoxItem<String>(
                      child: Text(e.name),
                      value: e.toString(),
                    );
                  }).toList(),
                  onChanged: (priorty) {
                    setState(() => _selectedType = priorty);
                  },
                  placeholder: const Text('Select a type'),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            MyMultiSelect(selectedItems: _printerFunctions,title: "functions",buttonText: "select functions",buttonIcon: Icons.settings_suggest),
            const SizedBox(
              height: 10,
            ),
            InfoLabel(
              label: 'Enter printer manufacturer:',
              child: TextBox(
                placeholder: 'Manufacturer',
                expands: false,
                controller: _manufacturerController,
              ),
            ),
            const Offstage(
              offstage: true,
              child: Text("you must enter a manufacturer"),
            ),
            const SizedBox(
              height: 10,
            ),
            InfoLabel(
              label: 'Enter printer model:',
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
            SizedBox(
              height: 10,
            ),
            InfoLabel(
              label: 'Enter printer resolution:',
              child: TextBox(
                placeholder: 'Resolution',
                expands: false,
                controller: _resolutionController,
              ),
            ),
            const Offstage(
              offstage: true,
              child: Text("you must enter resolution"),
            ),
            const SizedBox(
              height: 10,
            ),
            InfoLabel(
              label: 'Enter printer mono print speed:',
              child: TextBox(
                placeholder: 'Mono print speed',
                expands: false,
                controller: _monoPrintSpeedController,
              ),
            ),
            const Offstage(
              offstage: true,
              child: Text("you must enter mono print speed"),
            ),
            const SizedBox(
              height: 10,
            ),
            InfoLabel(
              label: 'Enter printer colour print speed:',
              child: TextBox(
                placeholder: 'Colour print speed',
                expands: false,
                controller: _colourPrintSpeedController,
              ),
            ),
            const Offstage(
              offstage: true,
              child: Text("you must enter colour print speed"),
            ),
            const SizedBox(
              height: 10,
            ),
            InfoLabel(
              label: 'Enter printer dimensions:',
              child: TextBox(
                placeholder: 'Dimensions',
                expands: false,
                controller: _dimensionsController,
              ),
            ),
            const Offstage(
              offstage: true,
              child: Text("you must enter dimensions"),
            ),
            const SizedBox(
              height: 10,
            ),
            InfoLabel(
              label: 'Enter printer weight:',
              child: TextBox(
                placeholder: 'Weight',
                expands: false,
                controller: _weightController,
              ),
            ),
            const Offstage(
              offstage: true,
              child: Text("you must enter a model"),
            ),
            const SizedBox(
              height: 10,
            ),
            InfoLabel(
              label: 'Enter printer purchase date:',
              child: FlatButton(
                  onPressed: () => _showDatePicker(context),
                  txt: _datepurchase.toString() == "null"
                      ? "select date"
                      : _datepurchase.toString(),
                  backGroundColor: Color(0xffffffff),
                  textColor: primaryColor,
                  borderColor: primaryColor,
                  height: 40,
                  radius: 5,
                  icon: Icons.date_range),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: primaryColor))),
        TextButton(
            onPressed: () {
              !isUpdate ? addPrinter() : modifyPrinter();
            },
            child: Text(
              !isUpdate ? 'Add' : 'update',
              style: TextStyle(color: primaryColor),
            ))
      ],
    );
  }
}
