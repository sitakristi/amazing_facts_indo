// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// HANYA MENGIMPORT GERBANG UTAMA SESUAI ATURAN REVISI DOSEN
import 'viewmodels/viewmodels.dart'; 
import 'views/pages/pages.dart';       

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RenunganViewModel()),
        ChangeNotifierProvider(create: (_) => VideoViewModel()),
        ChangeNotifierProvider(create: (_) => KontakViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
      ],
      child: MaterialApp(
        title: 'Amazing Facts Indonesia',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
          fontFamily: 'Roboto', // Menggunakan font bawaan standar agar aman
        ),
        // Mengarahkan tampilan awal ke SplashScreen yang berada di dalam pages.dart
        home: const SplashScreen(), 
      ),
    );
  }
}