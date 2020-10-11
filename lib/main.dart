import 'package:flutter/material.dart';
import 'package:parcelacion/src/pages/home_page.dart';
import 'package:parcelacion/src/pages/materia_page.dart';
import 'package:parcelacion/src/routes/route_generate.dart';

void main()  => runApp(Parcelacion());

class Parcelacion  extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:HomePage(),
      routes:<String, WidgetBuilder>{
        'home' : (BuildContext context) => HomePage(),
      },
      onGenerateRoute: RouteGenerate.generateRoute,
    );
  }
}

