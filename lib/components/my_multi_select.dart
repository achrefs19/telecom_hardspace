import 'package:f/constants.dart';
import 'package:f/enums/printer_function.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:multi_select_flutter/chip_field/multi_select_chip_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class MyMultiSelect extends StatefulWidget {
  MyMultiSelect({this.buttonIcon = FluentIcons.increase_indent_arrow, this.title = "items" , this.buttonText = "select" , required this.selectedItems, super.key});
  IconData buttonIcon;
  String buttonText;
  String title;
  List<PrinterFunction?> selectedItems;
  final _items = PrinterFunction.values
      .map((item) => MultiSelectItem<PrinterFunction?>(item, item.name))
      .toList();
  @override
  State<MyMultiSelect> createState() => _MyMultiSelectState();
}

class _MyMultiSelectState extends State<MyMultiSelect> {
  final _multiSelectKey = GlobalKey<FormFieldState>();


  @override
  Widget build(BuildContext context) {
    return m.Card(
      child: MultiSelectDialogField<PrinterFunction?>(
          items: widget._items,
          key: _multiSelectKey,
          title: Text(widget.title),
          buttonText: Text(widget.buttonText),
          buttonIcon: Icon(widget.buttonIcon,color: primaryColor),
          selectedColor: secondaryColor,
          checkColor: primaryColor,
          dialogWidth: 300,
          dialogHeight: 600,
          validator: (values) {

          },
        onConfirm: (v) => widget.selectedItems = v,

          /*itemBuilder: (item, state) {
        // return your custom widget here
        return m.InkWell(
          onTap: () {
            widget.selectedItems.contains(item.value)
                ? widget.selectedItems.remove(item.value)
                : widget.selectedItems.add(item.value);
            state.didChange(widget.selectedItems);
            _multiSelectKey.currentState!.validate();
          },
          child: Text(item.value!.name),
        );
      },*/
      ),
    );
  }
}
