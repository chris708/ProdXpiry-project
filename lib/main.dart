import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:food_app/model/expire.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:splashscreen/splashscreen.dart';
import 'model/expire.dart';
import 'package:food_app/page/expire_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(ExpireAdapter());
  await Hive.openBox<Expire>('expiration');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Hive Food App';

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: title,
    theme: ThemeData(primarySwatch: Colors.indigo),
    home: Splash2(),
  );
}

class Splash2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      backgroundColor: Color(0xff3cae70),
      seconds: 3,
      navigateAfterSeconds: ExpirePage(),
      title: Text('ProdXpiry', style: TextStyle(color: Colors.white, fontSize: 34.0),),
      image: Image.asset('images/splash2.jpeg'),
      loaderColor: Color(0xff3cae70),
      photoSize: 250.0,

    );
  }
}