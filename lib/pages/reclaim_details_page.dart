import 'package:f/components/answers.dart';
import 'package:f/components/new_answer.dart';
import 'package:f/constants.dart';
import 'package:f/models/Reclaim.dart';
import 'package:fluent_ui/fluent_ui.dart';

class ReclaimDetailsPage extends StatefulWidget {
  Reclaim reclaim;
  ReclaimDetailsPage( this.reclaim, {super.key});

  @override
  State<ReclaimDetailsPage> createState() => _ReclaimDetailsPageState();
}

class _ReclaimDetailsPageState extends State<ReclaimDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Card(child: ListTile(
            title: Text(widget.reclaim.title,style: const TextStyle(
              fontSize: 24, color: primaryColor
            ),),
            subtitle: Text(widget.reclaim.description,style: const TextStyle(
                fontSize: 16,color: secondaryColor
            )),

          )),
          const SizedBox(
            height: 10,
          ),
          Answers(widget.reclaim.id),
          const SizedBox(
            height: 10,
          ),
          NewAnswer(widget.reclaim.id),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
