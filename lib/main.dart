import 'package:flutter/material.dart';
import 'package:gamingmob/authentication/providers/authprovider.dart';
import 'package:gamingmob/authentication/screens/slidescreen.dart';
import 'package:gamingmob/blogs/providers/blogprovider.dart';
import 'package:gamingmob/eventmanagement/provider/eventprovider.dart';
import 'package:gamingmob/forum/providers/forumprovider.dart';
import 'package:gamingmob/product/providers/categoriesprovider.dart';
import 'package:gamingmob/product/providers/productprovider.dart';

import 'package:gamingmob/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Map<int, Color> color = {
      50: const Color.fromRGBO(141, 27, 165, .1),
      100: const Color.fromRGBO(141, 27, 165, .2),
      200: const Color.fromRGBO(141, 27, 165, .3),
      300: const Color.fromRGBO(141, 27, 165, .4),
      400: const Color.fromRGBO(141, 27, 165, .5),
      500: const Color.fromRGBO(141, 27, 165, .6),
      600: const Color.fromRGBO(141, 27, 165, .7),
      700: const Color.fromRGBO(141, 27, 165, .8),
      800: const Color.fromRGBO(141, 27, 165, .9),
      900: const Color.fromRGBO(141, 27, 165, 1),
    };
    MaterialColor colorCustom = MaterialColor(0xff8d1ba5, color);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctc) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CategoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => BlogProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => ForumProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => EventProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: colorCustom,
          textTheme: const TextTheme(
            headline3: TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
            headline4: TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        // FlexThemeData.light(
        //   scheme: FlexScheme.bahamaBlue,

        // ),
        home: const SlideScreen(),

        routes: getRoutes(),
      ),
    );
  }
}
