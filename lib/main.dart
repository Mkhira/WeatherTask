import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Constant/RoutesConstants.dart';
import 'Provider/MainProvider.dart';
import 'Router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MainProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,

          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: RoutesConstants.splash,
        onGenerateRoute: PageRouter.generateRoute,
      ),
    );
  }
}