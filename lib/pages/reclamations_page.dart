import 'package:date_format/date_format.dart';
import 'package:f/components/flat_button.dart';
import 'package:f/constants.dart';
import 'package:f/models/Computer.dart';
import 'package:f/models/Reclamation.dart';
import 'package:f/models/User.dart';
import 'package:f/widget/edit_add_computer.dart';
import 'package:f/widget/edit_add_reclamation.dart';
import 'package:firedart/firedart.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;

class ReclamationsPage extends StatefulWidget {
  ReclamationsPage({super.key});

  @override
  State<ReclamationsPage> createState() => _ReclamationsPageState();
}

class _ReclamationsPageState extends State<ReclamationsPage> {
  Firestore firestore = Firestore.instance;
  List datas = [];
  bool _isSelect = true;

  @override
  Widget build(BuildContext context) {
    return _isSelect ? ScaffoldPage(
      bottomBar:
      Center(
        child: FlatButton(
            onPressed: () => showDialog(
                context: context,
                builder: (ctxt) {
                  return EditAddReclamation(Reclamation("","","","","",User()));
                }),
            txt: "Add Reclamation.dart",
            backGroundColor: primaryColor,
            icon: FluentIcons.add),
      ),

      content:
      StreamBuilder(
          stream: Firestore.instance.collection("reclamations").stream,
          builder: (context, snapshot) {

            //check if we don't have data

            if (snapshot.connectionState == ConnectionState.waiting){
              return const Center(
                child: m.CircularProgressIndicator(),
              );
            }

            if (!snapshot.hasData){
              return const Center(
                child: Text('No computers found.'),
              );
            }
            //check if we have an error
            if (snapshot.hasError){
              return const Center(
                child: Text('No computers found.'),
              );
            }

            return ListView.builder(
                itemCount: snapshot.data!.length,
                padding: EdgeInsets.all(10),
                itemBuilder: (context, index) {

                  return Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Card(
                        borderColor: primaryColor,
                        child: Column(
                          children: [
                            ListTile(
                              onPressed: () => setState(() {
                                _isSelect = false;
                                print("ok");
                              }),
                              title: Text(snapshot.data![index]["userName"],style: TextStyle(
                              )),
                              subtitle: Text(
                                snapshot.data![index]["title"],
                                style: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 20),
                              ),
                              trailing: Text(formatDate(snapshot.data![index]["createdAt"], [dd, ' ', MM, ' ', yyyy])+"\n"+formatDate(snapshot.data![index]["createdAt"], [hh, ':', nn])),
                            ),
                          ],
                        ),
                      ));
                });
          }
      ),
    ):Text("ss");
  }
} /**/
