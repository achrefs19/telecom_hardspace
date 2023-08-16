import 'package:f/constants.dart';
import 'package:f/pages/auth.dart';
import 'package:f/pages/home.dart';
import 'package:f/services/auth_service.dart';
import 'package:firedart/firedart.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:local_notifier/local_notifier.dart';

void main() async {
  FirebaseAuth.initialize('AIzaSyBpoRYI9Mc_sjt-3rSvuA-LgocDlFtfsSI', VolatileStore());
  Firestore.initialize("telecom-hardspace");
  WidgetsFlutterBinding.ensureInitialized();
  await localNotifier.setup(
    appName: 'local_notifier_example',
    // The parameter shortcutPolicy only works on Windows
    shortcutPolicy: ShortcutPolicy.requireCreate,
  );
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override


  @override
  Widget build(BuildContext context) {
    return FluentApp(
        debugShowCheckedModeBanner: false,
      title: "Telecom Hardspace",
      theme: FluentThemeData(
        acrylicBackgroundColor: blankColor,
        inactiveBackgroundColor: blankColor,

      ),
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
