import 'package:f/components/flat_button.dart';
import 'package:f/constants.dart';
import 'package:f/models/Computer.dart';
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
  List datas = [];

  Future<List<Computer>> _getComputers() async {
    List<Computer> computers = [];
    var map = await Firestore.instance.collection("computers").get();
    map.forEach((computer) {
      computers.add(Computer(computer.id,computer["manufacturer"], computer["manufacturer"], computer["purchaseDate"], computer["manufacturer"], computer["manufacturer"], computer["manufacturer"],computer["manufacturer"],computer["manufacturer"]));
    });
    return computers;
  }



  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      bottomBar:
          Center(
            child: FlatButton(
                onPressed: () => showDialog(
                    context: context,
                    builder: (ctxt) {
                      return EditAddComputer(Computer("","","","","","","","",""));
                    }),
                txt: "Add Computer",
                backGroundColor: primaryColor,
                icon: FluentIcons.add),
          ),
      content: FutureBuilder<List<Computer>>(
        future: _getComputers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: m.CircularProgressIndicator(),
            );
          }

          //check if we don't have data
          if (!snapshot.hasData){
            return const Center(
              child: Text('No messages found.'),
            );
          }

          //check if we have an error
          if (snapshot.hasError){
            return const Center(
              child: Text('No messages found.'),
            );
          }

          return ListView.builder(
              itemCount: snapshot.data!.length,
              padding: EdgeInsets.all(10),
              itemBuilder: (context, index) {
                return Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Card(
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(snapshot.data![index].manufacturer),
                            subtitle: Text(
                              snapshot.data![index].model,
                              style: TextStyle(color: Colors.black.withOpacity(0.6)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'Greyhound divisively hello coldly wonderfully marginally far upon excluding.',
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
                                          return EditAddComputer(snapshot.data![index]);
                                        });
                                  },
                                  txt: 'edit'
                              ),
                              FlatButton(
                                icon: m.Icons.delete,
                                backGroundColor: Colors.white,
                                borderColor: primaryColor,
                                textColor: primaryColor,
                                onPressed: () {
                                 firestore.collection("computers").document(snapshot.data![index].id).delete();
                                },
                                txt: 'remove',
                              ),
                            ],
                          ),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(10),
                      borderColor: primaryColor,
                    ));
              });
        }
      ),
    );
  }
} /**/
