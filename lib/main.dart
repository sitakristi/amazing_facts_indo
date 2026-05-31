import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/renungan_viewmodel.dart';
import 'viewmodels/video_viewmodel.dart';
import 'viewmodels/kontak_viewmodel.dart';
import 'viewmodels/user_viewmodel.dart'; 
import 'views/splash_screen.dart';
import '../viewmodels/user_viewmodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Di sini proses Dependency Injection (DI) dipasang untuk membungkus seluruh aplikasi.
    // Ini adalah alternatif terbaik pengganti Singleton sesuai dengan instruksi materi kuliahmu!
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
          fontFamily: 'Roboto', // Menggunakan font bawaan standar yang bersih
        ),
        // Mengarahkan agar aplikasi pertama kali dibuka menampilkan Halaman Sambutan (Splash)
        home: const SplashScreen(),
      ),
    );
  }
}