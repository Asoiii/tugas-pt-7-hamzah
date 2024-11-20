import 'package:flutter/material.dart';
import 'package:klinik_app/helpers/user_info.dart';
import 'package:klinik_app/ui/poli_homepage.dart';
import 'package:klinik_app/ui/poli_login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var token = await UserInfo().getToken();
  print(token);
  runApp(MyApp(token: token));
}

class MyApp extends StatelessWidget {
  final String? token;

  const MyApp({Key? key, this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Klinik App",
      debugShowCheckedModeBanner: false,
      home: token == null ? Login() : PoliHomepage(),
    );
  }
}
