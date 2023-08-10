import 'package:f/components/flat_button.dart';
import 'package:f/constants.dart';
import 'package:f/models/Computer.dart';
import 'package:f/services/image_taker.dart';
import 'package:f/widget/edit_add_computer.dart';
import 'package:firedart/firedart.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;

class ComputerPage extends StatefulWidget {
  ComputerPage({super.key});

  @override
  State<ComputerPage> createState() => _ComputerPageState();
}

class _ComputerPageState extends State<ComputerPage> {
  Firestore firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      bottomBar: Center(
        child: FlatButton(
            onPressed: () => showDialog(
                context: context,
                builder: (ctxt) {
                  return EditAddComputer(
                      Computer("", "", "", "", "", "", "", "", ""));
                }),
            txt: "Add Computer",
            backGroundColor: primaryColor,
            icon: FluentIcons.add),
      ),
      content: StreamBuilder(
          stream: Firestore.instance.collection("computers").stream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting && !snapshot.hasData) {
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
                  List<Widget> computerContent = [
                    Expanded(
                      flex: 1,
                      child: ListTile(
                        title: Text(snapshot.data![index]["manufacturer"]),
                        subtitle: Text(
                          snapshot.data![index]["manufacturer"],
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.6)),
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
                      flex: 2,
                      child: Text(
                        "purchased at  ${snapshot.data![index]["purchaseDate"]} \ngraphic card ${snapshot.data![index]["graphicCards"]}\noperator system ${snapshot.data![index]["operateurSystem"]}\nprocesseur ${snapshot.data![index]["processeur"]}\nrandom access memory ${snapshot.data![index]["randomAccessMemory"]}\nphysical memory ${snapshot.data![index]["physicalMemory"]}",
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
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
                                        snapshot.data![index]["manufacturer"],
                                        snapshot.data![index]["manufacturer"],
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
                  ];

                  List<Widget> mobileContent = [
                    ListTile(
                      title: Text(snapshot.data![index]["manufacturer"]),
                      subtitle: Text(
                        snapshot.data![index]["manufacturer"],
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
                      leading: Image.asset(
                        computerImageTaken(
                            snapshot.data![index]["manufacturer"]),
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
                                        snapshot.data![index]["manufacturer"],
                                        snapshot.data![index]["manufacturer"],
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
                    )
                  ];

                  return Container(
                      child: Card(
                    borderRadius: BorderRadius.circular(10),
                    borderColor: primaryColor,
                    child: MediaQuery.of(context).size.width > 800
                        ? Row(
                            children: computerContent,
                          )
                        : Column(
                            children: mobileContent,
                          ),
                  ));
                });
          }),
    );
  }
} /**/
