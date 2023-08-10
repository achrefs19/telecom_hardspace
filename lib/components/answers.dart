import 'package:f/components/answer_bubble.dart';
import 'package:f/models/Answer.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';

class Answers extends StatelessWidget {
  Answers(this.reclaimId, {super.key});
  String reclaimId;

  //set up a listener which autmatically listens to the chat collection to automatically notify any changes
  //and then it will trigger the builder function to update the UI
  //snapshot object give us access to the data that was loaded from the backend
  @override
  Widget build(BuildContext context) {
    Firestore firestore = Firestore.instance;

    return StreamBuilder(
        stream: Firestore.instance.collection("answers").stream,
        builder: (context, chatSnapshots) {
          //test if receive some data
          if (chatSnapshots.connectionState == ConnectionState.waiting && !chatSnapshots.hasData){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          //check if we don't have data
          if (!chatSnapshots.hasData){
            return const Center(
              child: Text('No messages found.'),
            );
          }
          //check if we have an error
          if (chatSnapshots.hasError){
            return const Center(
              child: Text('No messages found.'),
            );
          }
          //if we know that we have data
          //get our loaded messages
          final loadedAnswers = chatSnapshots.data;
          return Flexible(
            flex: 1,
            child: ListView.builder(
                reverse: true,
                itemCount: loadedAnswers!.length,
                itemBuilder: (context, index)
          {
            final answer = loadedAnswers[index];
            //check if there are another message
            final nextanswer = index + 1 < loadedAnswers.length
                ? loadedAnswers[index + 1]
                : null;
            // get current message userId
            final currentMessageuserId = answer['userId'];
            // get next message userId if exist
            final nextMessageuserId = nextanswer != null
                ? nextanswer['userId']
                : null;
            //compare the two userId
            final nextUserIsSame = currentMessageuserId == nextMessageuserId;

            // isMe will change some styles
            if (answer["reclaimId"]==reclaimId){
              return AnswerBubble(Answer.fromDoc(answer));
              /*if (nextUserIsSame) {
                return MessageBubble.next(message: answer['text'],
                    isMe: FirebaseAuth.instance.userId == currentMessageuserId);
              }
              else {
                return MessageBubble.first(userImage: answer['userImage'],
                    username: answer['username'],
                    message: answer['text'],
                    isMe: FirebaseAuth.instance.userId == currentMessageuserId);
              }*/
          }
          else {
              return Container();
            }

                }),
          );
        });
  }
}
