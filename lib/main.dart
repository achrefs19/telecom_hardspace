import 'package:f/pages/home.dart';
import 'package:firedart/firedart.dart';
import 'package:fluent_ui/fluent_ui.dart';

void main() async {
  Firestore.initialize("telecom-hardspace");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      title: "Telecom Hardspace",
      /*theme: FluentThemeData(
        accentColor:
      ),*/
      home: HomePage(),
    );
  }
}
