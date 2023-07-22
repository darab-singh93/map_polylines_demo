import 'package:fictive_box_task/providers/location_details_provider.dart';
import 'package:fictive_box_task/providers/user_details_provider.dart';
import 'package:fictive_box_task/routes/route_path.dart';
import 'package:fictive_box_task/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserDetailsProvider()),
        ChangeNotifierProvider(create: (_) => LocationDetailsProvider()),
      ],
      child: MaterialApp(
        title: StringUtils.appName,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: Routers.generateRoute,
        initialRoute: RoutePath.home,
      ),
    );
  }
}
