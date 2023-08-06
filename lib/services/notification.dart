

import 'package:local_notifier/local_notifier.dart';

void notifier({title="",body=""}){
  LocalNotification notification = LocalNotification(
    title: title,
    body: body,
  );
  notification.onShow = () {
    print('onShow ${notification.identifier}');
  };
  notification.onClose = (closeReason) {
    // Only supported on windows, other platforms closeReason is always unknown.
    switch (closeReason) {
      case LocalNotificationCloseReason.userCanceled:
      // do something
        break;
      case LocalNotificationCloseReason.timedOut:
      // do something
        break;
      default:
    }
    //print('onClose ${_exampleNotification?.identifier} - $closeReason');
  };
  notification.onClick = () {
    print('onClick ${notification.identifier}');
  };
  notification?.onClickAction = (actionIndex) {
    print('onClickAction ${notification?.identifier} - $actionIndex');
  };

  notification.show();
}