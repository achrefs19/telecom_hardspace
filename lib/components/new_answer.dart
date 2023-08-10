import 'package:f/components/send_button.dart';
import 'package:f/components/text_input.dart';
import 'package:f/constants.dart';
import 'package:firedart/firedart.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:progress_state_button/iconed_button.dart';

class NewAnswer extends StatefulWidget {
  NewAnswer(this.reclamId, {super.key});
  String reclamId;

  @override
  State<NewAnswer> createState() => _NewAnswerState();
}

class _NewAnswerState extends State<NewAnswer> {
  var _responseController = TextEditingController();

  @override
  void dispose() {
    _responseController.dispose();
    super.dispose();
  }

  void _submitResponse() async {
    final enteredMessage = _responseController.text;

    if (enteredMessage.trim().isEmpty) {
      return;
    }

    FocusScope.of(context).unfocus();

    //final userData = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

    Firestore firestore = Firestore.instance;
    final userData = await firestore
        .collection("users")
        .document(FirebaseAuth.instance.userId)
        .get();

    firestore.collection('answers').add({
      'text': enteredMessage,
      'createdAt': DateTime.now(),
      'userId': FirebaseAuth.instance.userId,
      'reclaimId': widget.reclamId,
      'userName': userData["firstName"] + ' ' + userData['lastName'],
      'userRole': userData["role"]
    });

    _responseController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: TextBox(
            placeholder: "type your answer",
            cursorColor: primaryColor,
            //padding: EdgeInsets.fromLTRB(40,10,10,20),
            style: const TextStyle(
              fontSize: 20,
            ),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide.none),
              //image: DecorationImage(image: ResizeImage(AssetImage(assetImage),height: 20,width: 20),alignment: AlignmentDirectional.centerStart,),
              color: Colors.transparent,
            ),
            highlightColor: primaryColor,
            expands: false,
            controller: _responseController,
          ),
        ),
        SendButton(txt:"send", onPressed: ()=>_submitResponse(),backGroundColor: primaryColor, borderColor: secondaryColor,)
      ],
    );
  }
}
