import 'package:flutter/material.dart';
import 'package:pocket_track/core/database.dart';
import 'package:pocket_track/homescreen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  Database db = Database();
  await db.initialize();
  runApp(ChangeNotifierProvider(create: (_) => db, child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final lightColorScheme = ColorScheme(
    brightness: Brightness.light,

    primary: Color(0xFF1F6F78),
    onPrimary: Color(0xFFFFFFFF),

    secondary: Color(0xFF2ECC71),
    onSecondary: Color(0xFFFFFFFF),

    error: Color(0xFFE74C3C),
    onError: Color(0xFFFFFFFF),

    surface: Color(0xFFF7F9FC),
    onSurface: Color(0xFF1C1C1E),
  );

  final darkColorScheme = ColorScheme(
    brightness: Brightness.dark,

    primary: Color(0xFF4DA3FF),
    onPrimary: Color(0xFF12171D),

    secondary: Color(0xFF2ECC71),
    onSecondary: Color(0xFF12171D),

    error: Color(0xFFFF6B6B),
    onError: Color(0xFF12171D),

    surface: Color(0xFF12171D),
    onSurface: Color(0xFFF3F4F6),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: lightColorScheme, useMaterial3: true),
      darkTheme: ThemeData(colorScheme: darkColorScheme, useMaterial3: true),
      home: const HomeScreen(title: 'Pocket Track'),
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
    );
  }
}
