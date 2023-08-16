import 'package:f/tools/mailer.dart';
import 'package:f/tools/notification.dart';
import 'package:firedart/firedart.dart';

class ReclaimServices{

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future notify() async {
    try {

      var reclaims = await Firestore.instance.collection("reclaims").get();
      for (var reclaim in reclaims) {
        List<String> viewers = List.from(reclaim["viewers"]);
        if(!viewers.contains(FirebaseAuth.instance.userId)){
          notifier(title: reclaim["title"],body: reclaim["description"]);
        }
      }
    } catch(e) {
      return e.toString();
    }
  }

  Future markView(reclaimId) async {
    try {

      var reclaim = await Firestore.instance.collection("reclaims").document(reclaimId).get();
      List<String> viewers = List.from(reclaim["viewers"]);

      if(!viewers.contains(FirebaseAuth.instance.userId)){
        viewers.add(FirebaseAuth.instance.userId);
        print(viewers);
        await Firestore.instance.collection("reclaims").document(reclaimId).update(
            {
              "viewers":viewers
            });
      }
      } catch(e) {
      return e.toString();
    }
  }

}