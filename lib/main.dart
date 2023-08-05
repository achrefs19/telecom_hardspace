import 'package:f/constants.dart';
import 'package:f/pages/auth.dart';
import 'package:f/pages/home.dart';
import 'package:f/services/auth_service.dart';
import 'package:firedart/firedart.dart';
import 'package:fluent_ui/fluent_ui.dart';

void main() async {
  FirebaseAuth.initialize('AIzaSyBpoRYI9Mc_sjt-3rSvuA-LgocDlFtfsSI', VolatileStore());
  Firestore.initialize("telecom-hardspace");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      title: "Telecom Hardspace",
      theme: FluentThemeData(
        acrylicBackgroundColor: blankColor,
        inactiveBackgroundColor: blankColor,

      ),
      /*theme: FluentThemeData(
        accentColor:
      ),*/
      home:StreamBuilder(
          stream: _firebaseAuth.signInState,
          builder: (ctx, snapshot) {
           /* if (snapshot.connectionState == ConnectionState.waiting) {
              return const ProgressRing();
            }*/
            if (snapshot.data==true) {
              print(snapshot.data);
              return HomePage();
            }
            print(snapshot.data);
            return const Auth();
          }));
  }
}
