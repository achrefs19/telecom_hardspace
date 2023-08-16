import 'package:date_format/date_format.dart';
import 'package:f/models/Answer.dart';
import 'package:f/models/User.dart';
import 'package:f/tools/image_taker.dart';
import 'package:firedart/firedart.dart';
import 'package:fluent_ui/fluent_ui.dart';

class AnswerBubble extends StatelessWidget {
  AnswerBubble(this.answer);
  Answer answer;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: Image.asset(userImageTaken(answer.userRole)),
        title: Text(answer.userName),
        subtitle: Text(answer.text),
        trailing: Text("${formatDate(answer.createdAt, [dd, ' ', MM, ' ', yyyy])}\n${formatDate(answer.createdAt, [hh, ':', nn, ' ',am])}"),
      ),
    );
  }
}

