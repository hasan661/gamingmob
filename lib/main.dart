import 'package:flutter/material.dart';
import 'package:gamingmob/product/providers/productprovider.dart';
import 'package:gamingmob/product/screens/splashscreen.dart';
import 'package:gamingmob/routes/routes.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Map<int, Color> color = {
      50: const Color.fromRGBO(18,144,203, .1),
      100: const Color.fromRGBO(18,144,203, .2),
      200: const Color.fromRGBO(18,144,203, .3),
      300: const Color.fromRGBO(18,144,203, .4),
      400: const Color.fromRGBO(18,144,203, .5),
      500: const Color.fromRGBO(18,144,203, .6),
      600: const Color.fromRGBO(18,144,203, .7),
      700: const Color.fromRGBO(18,144,203, .8),
      800: const Color.fromRGBO(18,144,203, .9),
      900: const Color.fromRGBO(18,144,203, 1),
    };
    MaterialColor colorCustom = MaterialColor(0x1290cb, color);
    return ChangeNotifierProvider(
      create: (ctc) => ProductProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: colorCustom,
          
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
        home: const SplashScreen(),
       routes: getRoutes(),
      ),
    );
  }
}
