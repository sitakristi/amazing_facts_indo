import 'dart:io'; // <-- TAMBAHAN: Wajib diimport untuk mengaktifkan HttpOverrides
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// HANYA MENGIMPORT GERBANG UTAMA SESUAI ATURAN REVISI DOSEN
import 'viewmodels/viewmodels.dart'; 
import 'views/pages/pages.dart';       

// TAMBAHAN: Kelas khusus untuk memaksa iPhone mengizinkan sertifikat SSL lokal/devtunnels
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  // TAMBAHAN: Aktifkan bypass keamanan SSL sebelum aplikasi menyala
  HttpOverrides.global = MyHttpOverrides();
  
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