import 'package:flutter/material.dart';

import 'router/routes.dart';
import 'theme/theme.dart';

class MapboxMapsApp extends StatelessWidget {
  const MapboxMapsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "MapboxMapsApp",
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.homeRoute,
      routes: AppRoutes.getAppRoutes,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
    );
  }
}
