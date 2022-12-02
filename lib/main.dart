import 'package:flutter/material.dart';
import 'package:hashcat_flutter/pages/init_hashcat/init_hashcat.dart';
import 'package:hashcat_flutter/providers/crack_options.dart';
import 'package:hashcat_flutter/providers/hashcat.dart';
import 'package:hashcat_flutter/routes.dart';
import 'package:provider/provider.dart';

import 'constants.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<HashcatProvider>(create: (context) => HashcatProvider(),),
        ChangeNotifierProvider<CrackOptionsProvider>(create: (context) => CrackOptionsProvider(),),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hashcat',
      theme: themeLight,
      darkTheme: themeDark,
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      routes: routes,
      home: const InitHashcat(),
    );
  }
}
