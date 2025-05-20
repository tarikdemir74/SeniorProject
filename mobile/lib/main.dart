// main.dart
// Uygulamanın giriş noktası. Provider ile tema ve kullanıcı yönetimi sağlar.
// MaterialApp ile uygulamanın genel temasını ve rotalarını ayarlar.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'theme_provider.dart';
import 'home_screen.dart';
import 'user_provider.dart';
import 'screens/splash_screen.dart';
import 'dart:async';

void main() async {
    WidgetsFlutterBinding.ensureInitialized(); // Flutter motoru başlatılır
  await Firebase.initializeApp();   // Uygulama başlatılırken Provider ile global state yönetimi sağlanır.
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()), // Tema yönetimi
        ChangeNotifierProvider(
            create: (_) => UserProvider()), // Kullanıcı verileri
      ],
      child: const BesinovaApp(),
    ),
  );
}

// Basit çeviri fonksiyonu (ileride gerçek localization ile değiştirilebilir)
String t(String key) {
  // Placeholder for localization. In the future, use Intl or similar.
  return key;
}

/// Uygulamanın ana widget'ı. Tema, rotalar ve genel ayarlar burada yapılır.
class BesinovaApp extends StatelessWidget {
  const BesinovaApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    // Tema renkleri
    const Color tropicalLime = Color(0xFFA3EBB1);
    const Color deepFern = Color(0xFF52796F);
    const Color midnightBlue = Color(0xFF2C3E50);
    const Color whiteSmoke = Color(0xFFF5F5F5);
    const Color oliveShadow = Color(0xFF6B705C);

    return MaterialApp(
      title: 'Besinova',
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.themeMode,
      // Açık tema ayarları
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme),
        scaffoldBackgroundColor: whiteSmoke,
        appBarTheme: AppBarTheme(
          backgroundColor: deepFern.withOpacity(0.95),
          elevation: 0,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: deepFern,
          secondary: tropicalLime,
          surface: whiteSmoke,
          onSurface: midnightBlue,
        ),
        cardTheme: CardTheme(
          color: whiteSmoke,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      // Koyu tema ayarları
      darkTheme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(
          ThemeData.dark().textTheme,
        ),
        scaffoldBackgroundColor: midnightBlue,
        appBarTheme: AppBarTheme(
          backgroundColor: deepFern.withOpacity(0.95),
          elevation: 0,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: deepFern,
          brightness: Brightness.dark,
          secondary: tropicalLime,
          surface: midnightBlue.withOpacity(0.8),
          onSurface: whiteSmoke,
        ),
        cardTheme: CardTheme(
          color: midnightBlue.withOpacity(0.8),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: midnightBlue.withOpacity(0.8),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      home: const SplashScreen(), // Açılışta SplashScreen gösterilir
      routes: {
        '/home': (context) => const HomeScreen(), // Ana ekran rotası
      },
    );
  }
}
