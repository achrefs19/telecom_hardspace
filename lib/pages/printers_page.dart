import 'package:f/components/flat_button.dart';
import 'package:f/constants.dart';
import 'package:f/enums/printer_type.dart';
import 'package:f/models/Computer.dart';
import 'package:f/models/Printer.dart';
import 'package:f/tools/image_taker.dart';
import 'package:f/widget/edit_add_computer.dart';
import 'package:f/widget/edit_add_printer.dart';
import 'package:firedart/firedart.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;

class PrintersPage extends StatefulWidget {
  PrintersPage({super.key});

  @override
  State<PrintersPage> createState() => _PrintersPageState();
}

class _PrintersPageState extends State<PrintersPage> {
  Firestore firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      bottomBar: Center(
        child: FlatButton(
            onPressed: () => showDialog(
                context: context,
                builder: (ctxt) {
                  return EditAddPrinter(
                      Printer("", "", "", "", "", "", PrinterType.laser, [], "", "", "","","")
                  );
                }),
            txt: "Add Printer",
            backGroundColor: primaryColor,
            icon: FluentIcons.add),
      ),
      content: StreamBuilder(
          stream: Firestore.instance.collection("printers").stream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting &&
                !snapshot.hasData) {
              return const Center(
                child: m.CircularProgressIndicator(),
              );
            }

            print(snapshot.data![0]["physicalMemory"]);

            //check if we don't have data
            if (!snapshot.hasData) {
              return const Center(
                child: Text('No computers found.'),
              );
            }

            //check if we have an error
            if (snapshot.hasError) {
              return const Center(
                child: Text('No computers found.'),
              );
            }

            return ListView.builder(
                itemCount: snapshot.data!.length,
                padding: EdgeInsets.all(10),
                itemBuilder: (context, index) {
                  // widget for big size of screens
                  List<Widget> computerContent = [
                    Expanded(
                      flex: 2,
                      child: ListTile(
                        title: Text(snapshot.data![index]["manufacturer"]),
                        subtitle: Column(
                          children: [
                            Row(
                              children: [
                                Tooltip(
                                  richMessage: m.TextSpan(
                                      text: snapshot.data![index]["status"]),
                                  displayHorizontally: true,
                                  useMousePosition: false,
                                  style: TooltipThemeData(preferBelow: true),
                                  child: Icon(FluentIcons.square_shape_solid,
                                      color: snapshot.data![index]["status"] ==
                                          "connected"
                                          ? m.Colors.green
                                          : m.Colors.red,
                                      size: 12.0),
                                ),
                                Text(
                                  snapshot.data![index]["model"],
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.6)),
                                ),
                              ],
                            ),
                            m.TextButton(
                                onPressed: () => {
                                  //if there are a user already linked we will retire him that means unlinked
                                  //if not we will linked him
                                  snapshot.data![index]["userId"] == "not used"
                                      ? firestore
                                      .collection("computers")
                                      .document(snapshot.data![index].id)
                                      .update({
                                    'status': "connected",
                                    'userId': FirebaseAuth.instance.userId
                                  })
                                      : firestore
                                      .collection("computers")
                                      .document(snapshot.data![index].id)
                                      .update({
                                    'status': "not used",
                                    'userId': "",
                                  })
                                },
                                child: Text(
                                  snapshot.data![index]["userId"] == "not used"
                                      ? "link"
                                      : "unlink",
                                  style: TextStyle(color: primaryColor),
                                ))
                          ],
                        ),
                        leading: Image.asset(
                          computerImageTaken(
                              snapshot.data![index]["manufacturer"]),
                          height: 200,
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        "purchased at  ${snapshot.data![index]["purchaseDate"]} \ngraphic card ${snapshot.data![index]["graphicCards"]}\noperator system ${snapshot.data![index]["operateurSystem"]}\nprocesseur ${snapshot.data![index]["processeur"]}\nrandom access memory ${snapshot.data![index]["randomAccessMemory"]}\nphysical memory ${snapshot.data![index]["physicalMemory"]}",
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
                    ),
                    Column(
                      children: [
                        m.ButtonBar(
                          alignment: MainAxisAlignment.end,
                          children: [
                            FlatButton(
                                icon: m.Icons.edit,
                                backGroundColor: Colors.white,
                                borderColor: primaryColor,
                                textColor: primaryColor,
                                onPressed: () {
                                  print("ok");
                                  showDialog(
                                      context: context,
                                      builder: (ctxt) {
                                        return EditAddComputer(Computer(
                                            snapshot.data![index].id,
                                            snapshot.data![index]["status"],
                                            snapshot.data![index]["userId"],
                                            snapshot.data![index]
                                            ["manufacturer"],
                                            snapshot.data![index]
                                            ["model"],
                                            snapshot.data![index]
                                            ["purchaseDate"],
                                            snapshot.data![index]
                                            ["graphicCards"],
                                            snapshot.data![index]
                                            ["operateurSystem"],
                                            snapshot.data![index]["processeur"],
                                            snapshot.data![index]
                                            ["randomAccessMemory"],
                                            snapshot.data![index]
                                            ["physicalMemory"]));
                                      });
                                },
                                txt: MediaQuery.of(context).size.width > 800
                                    ? 'edit'
                                    : ''),
                            FlatButton(
                              icon: m.Icons.delete,
                              backGroundColor: Colors.white,
                              borderColor: primaryColor,
                              textColor: primaryColor,
                              onPressed: () {
                                firestore
                                    .collection("computers")
                                    .document(snapshot.data![index].id)
                                    .delete();
                              },
                              txt: MediaQuery.of(context).size.width > 800
                                  ? 'remove'
                                  : '',
                            ),
                          ],
                        ),
                      ],
                    )
                  ];

                  // widget for small size of screens
                  List<Widget> mobileContent = [
                    ListTile(
                      title: Text(snapshot.data![index]["manufacturer"]),
                      subtitle: Column(
                        children: [
                          Row(
                            children: [
                              Tooltip(
                                richMessage: m.TextSpan(
                                    text: snapshot.data![index]["status"]),
                                displayHorizontally: true,
                                useMousePosition: false,
                                style: TooltipThemeData(preferBelow: true),
                                child: Icon(FluentIcons.square_shape_solid,
                                    color: snapshot.data![index]["status"] ==
                                        "connected"
                                        ? m.Colors.green
                                        : m.Colors.red,
                                    size: 12.0),
                              ),
                              Text(
                                snapshot.data![index]["model"],
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.6)),
                              ),
                            ],
                          ),
                          m.TextButton(
                              onPressed: () => {
                                //if there are a user already linked we will retire him that means unlinked
                                //if not we will linked him
                                snapshot.data![index]["userId"] == ""
                                    ? firestore
                                    .collection("computers")
                                    .document(snapshot.data![index].id)
                                    .update({
                                  'status': "connected",
                                  'userId': FirebaseAuth.instance.userId
                                })
                                    : firestore
                                    .collection("computers")
                                    .document(snapshot.data![index].id)
                                    .update({
                                  'status': "not used",
                                  'userId': "",
                                })
                              },
                              child: Text(
                                snapshot.data![index]["userId"] == ""
                                    ? "link"
                                    : "unlink",
                                style: const TextStyle(color: primaryColor),
                              ))
                        ],
                      ),
                      leading: Image.asset(
                        computerImageTaken(
                            snapshot.data![index]["model"]),
                        height: 200,
                        width: 200,
                      ),
                    ),
                    Text(
                      "purchased at  ${snapshot.data![index]["purchaseDate"]} \ngraphic card ${snapshot.data![index]["graphicCards"]}\noperator system ${snapshot.data![index]["operateurSystem"]}\nprocesseur ${snapshot.data![index]["processeur"]}\nrandom access memory ${snapshot.data![index]["randomAccessMemory"]}\nphysical memory ${snapshot.data![index]["physicalMemory"]}",
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                    m.ButtonBar(
                      alignment: MainAxisAlignment.end,
                      children: [
                        FlatButton(
                            icon: m.Icons.edit,
                            backGroundColor: Colors.white,
                            borderColor: primaryColor,
                            textColor: primaryColor,
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (ctxt) {
                                    return EditAddComputer(Computer(
                                        snapshot.data![index].id,
                                        snapshot.data![index]["status"],
                                        snapshot.data![index]["userId"],
                                        snapshot.data![index]["manufacturer"],
                                        snapshot.data![index]["model"],
                                        snapshot.data![index]["purchaseDate"],
                                        snapshot.data![index]["graphicCards"],
                                        snapshot.data![index]
                                        ["operateurSystem"],
                                        snapshot.data![index]["processeur"],
                                        snapshot.data![index]
                                        ["randomAccessMemory"],
                                        snapshot.data![index]
                                        ["physicalMemory"]));
                                  });
                            },
                            txt: 'edit'),
                        FlatButton(
                          icon: m.Icons.delete,
                          backGroundColor: Colors.white,
                          borderColor: primaryColor,
                          textColor: primaryColor,
                          onPressed: () {
                            firestore
                                .collection("computers")
                                .document(snapshot.data![index].id)
                                .delete();
                          },
                          txt: 'remove',
                        ),
                      ],
                    ),
                  ];

                  return Card(
                    margin: EdgeInsets.only(bottom: 10),
                    borderRadius: BorderRadius.circular(10),
                    borderColor: primaryColor,
                    child: MediaQuery.of(context).size.width > 800
                        ? Row(
                      children: computerContent,
                    )
                        : Column(
                      children: mobileContent,
                    ),
                  );
                });
          }),
    );
  }
} /**/
