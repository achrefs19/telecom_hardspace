import 'package:date_format/date_format.dart';
import 'package:f/components/flat_button.dart';
import 'package:f/constants.dart';
import 'package:f/models/Reclaim.dart';
import 'package:f/models/User.dart';
import 'package:f/pages/reclaim_details_page.dart';
import 'package:f/widget/edit_add_reclamation.dart';
import 'package:firedart/firedart.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;

class ReclaimPage extends StatefulWidget {
  ReclaimPage({super.key});

  @override
  State<ReclaimPage> createState() => _ReclaimPageState();
}

class _ReclaimPageState extends State<ReclaimPage> {
  Firestore firestore = Firestore.instance;
  List data = [];
  String selectedReclaimId = '';
  late Reclaim selectedReclaim = Reclaim("", "", "", DateTime.now(), "", User());

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      bottomBar:
      Center(
        child: FlatButton(
            onPressed: () => showDialog(
                context: context,
                builder: (ctxt) {
                  return EditAddReclamation(Reclaim("","","",DateTime.now(),"",User()));
                }),
            txt: "Add Reclaim.dart",
            backGroundColor: primaryColor,
            icon: FluentIcons.add),
      ),

      content:
      StreamBuilder(
          stream: Firestore.instance.collection("reclamations").stream,
          builder: (context, snapshot) {

            bool changeUI = MediaQuery.of(context).size.width<500 &&  selectedReclaimId.isNotEmpty;

            if (!snapshot.hasData){
              return const Center(
                child: m.CircularProgressIndicator(),
              );
            }
            //check if we have an error
            if (snapshot.hasError){
              return const Center(
                child: Text('No computers found.'),
              );
            }



            return Row(
              children: [
                if(!changeUI)
                SizedBox(
                  width: MediaQuery.of(context).size.width<500 ? MediaQuery.of(context).size.width :selectedReclaimId.isEmpty ? MediaQuery.of(context).size.width*0.7 :MediaQuery.of(context).size.width*0.34,
                  child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {

                        return ListTile.selectable(
                          tileColor: ButtonState.resolveWith((states) => selectedReclaimId == snapshot.data![index].id ? secondaryColor : states.isHovering? primaryColor : blankColor),
                          //tileColor: ButtonState.forStates(Set(), pressed: ButtonState.all(primaryColor), focused: ButtonState.all(primaryColor), hovering: ButtonState.all(primaryColor), disabled: ButtonState.all(blankColor), none: ButtonState.all(blankColor)),
                          //onPressed: () => Navigator.push(context, FluentDialogRoute(builder: (context) => ReclamationDetailsPage(Reclamation.fromDoc(snapshot.data![index])),context: context)),
                          title: Text(snapshot.data![index]["userName"],style: const TextStyle(
                          )),
                          subtitle: Text(
                            snapshot.data![index]["title"],
                            style: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 20),
                          ),
                          trailing: Text("${formatDate(snapshot.data![index]["createdAt"], [dd, ' ', MM, ' ', yyyy])}\n${formatDate(snapshot.data![index]["createdAt"], [hh, ':', nn, ' ', am])}"),
                          selected: selectedReclaimId == snapshot.data![index].id,
                          onSelectionChange: (v) => setState((){selectedReclaimId = snapshot.data![index].id; selectedReclaim = Reclaim.fromDoc(snapshot.data![index]);}),
                          shape: const BorderDirectional(
                              bottom: BorderSide(color: primaryColor, width: 1)
                          ),
                        );
                      }),
                ),
                if(selectedReclaimId.isNotEmpty)
                SizedBox(
                    width: changeUI ? MediaQuery.of(context).size.width:MediaQuery.of(context).size.width*0.4,
                    child: ReclaimDetailsPage(selectedReclaim)
                ),
              ],
            );
          }
      ),
    );
  }
}