import 'package:business_card_admin/routers.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Digital Business Card - Admin',
      debugShowCheckedModeBanner: false,
      routerConfig: routerList,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          background: const Color(0xFF151928),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        primaryTextTheme: Theme.of(context)
            .primaryTextTheme
            .copyWith(
          bodyLarge: const TextStyle(),
          bodyMedium: const TextStyle(),
          bodySmall: const TextStyle(),
        )
            .apply(
          bodyColor: const Color(0xFFADB3CC),
          displayColor: const Color(0xFFADB3CC),
        ),
        textTheme: Theme.of(context)
            .primaryTextTheme
            .copyWith(
          bodyLarge: const TextStyle(),
          bodyMedium: const TextStyle(),
          bodySmall: const TextStyle(),
        )
            .apply(
          bodyColor: const Color(0xFFADB3CC),
          displayColor: const Color(0xFFADB3CC),
        ),
        inputDecorationTheme: Theme.of(context).inputDecorationTheme.copyWith(
          fillColor: const Color(0xFF1E2032),
          hintStyle: const TextStyle(color: Color(0xFF424A70)),
          iconColor: const Color(0xFF424A70),
        ),
        searchBarTheme: Theme.of(context).searchBarTheme.copyWith(
            backgroundColor: const MaterialStatePropertyAll(Color(0xFF1E2032)),
            elevation: const MaterialStatePropertyAll(0),
            overlayColor: const MaterialStatePropertyAll(Color(0xFF1E2032)),
            hintStyle: const MaterialStatePropertyAll(
              TextStyle(color: Color(0xFF424A70)),
            ),
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            )),
      ),
    );
  }
}