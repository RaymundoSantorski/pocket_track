import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
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
      home: const MyHomePage(title: 'Pocket Track'),
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    ColorScheme theme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: theme.surface,
      appBar: AppBar(
        backgroundColor: theme.primary,
        title: Text(
          widget.title,
          style: TextStyle(
            color: theme.onPrimary,
            fontWeight: FontWeight.w600,
            fontFamily: "Inter",
          ),
        ),
      ),
    );
  }
}
