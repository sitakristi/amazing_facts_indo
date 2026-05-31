import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart'; 
import '../viewmodels/renungan_viewmodel.dart';
import '../viewmodels/video_viewmodel.dart';
import '../viewmodels/kontak_viewmodel.dart';
import '../viewmodels/user_viewmodel.dart'; 
import 'renungan_detail_view.dart'; 
import 'login_view.dart';
import 'register_view.dart';
import 'edit_akun_view.dart';
import 'daftar_renungan_view.dart';
import 'daftar_video_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<RenunganViewModel>().fetchRenungan();
      context.read<VideoViewModel>().fetchVideos();
      context.read<KontakViewModel>().fetchKontakInfo();
    });
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Gagal membuka halaman: $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color afDarkBackground = Color(0xFF0D1B2A); 
    const Color afCardNavy = Color(0xFF1B263B);      
    const Color afPrimaryRed = Color(0xFFC62828);     
    const Color afGold = Color(0xFFFBC02D);          

    // PERBAIKAN UTAMA: MEMBUNGKUS SELURUH SECTOR DENGAN SATU CONSUMER GLOBAL
    return Consumer<UserViewModel>(
      builder: (context, userVM, child) {
        final isLoggedIn = userVM.currentUser != null;

        return Scaffold(
          backgroundColor: afDarkBackground,
          
          drawer: Drawer(
            backgroundColor: afDarkBackground,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                // HEADER DRAWER DINAMIS
                DrawerHeader(
                  decoration: const BoxDecoration(color: afPrimaryRed),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (isLoggedIn) ...[
                        const CircleAvatar(
                          radius: 25,
                          backgroundColor: afGold,
                          child: Icon(Icons.person, color: afDarkBackground, size: 30),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          userVM.currentUser!.namaLengkap,
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          userVM.currentUser!.email,
                          style: const TextStyle(color: Colors.white70, fontSize: 12),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ] else ...[
                        Image.asset('assets/images/logo.png', height: 50, errorBuilder: (c,e,s) => const Icon(Icons.bookmark, color: afGold, size: 40)),
                        const SizedBox(height: 10),
                        const Text("Amazing Facts Indonesia", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                      ],
                    ],
                  ),
                ),
                
                // MENU BERDASARKAN STATUS LOGIN
                if (!isLoggedIn) ...[
                  ListTile(
                    leading: const Icon(Icons.login, color: Colors.white), 
                    title: const Text("Masuk", style: TextStyle(color: Colors.white)), 
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginView()));
                    }
                  ),
                  ListTile(
                    leading: const Icon(Icons.person_add, color: Colors.white), 
                    title: const Text("Daftar Akun Baru", style: TextStyle(color: Colors.white)), 
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterView()));
                    }
                  ),
                ] else ...[
                  ListTile(
                    leading: const Icon(Icons.edit_note, color: afGold), 
                    title: const Text("Ubah Akun", style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.pop(context); 
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const EditAkunView()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.redAccent), 
                    title: const Text("Keluar Akun", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)), 
                    onTap: () {
                      // 1. Tutup menu drawer terlebih dahulu agar layar bersih
                      Navigator.pop(context); 
                      
                      // 2. Gunakan fungsi logoutUser() yang baru agar state terhapus murni
                      userVM.logoutUser(); 
                      
                      // 3. Tampilkan pesan pemberitahuan sukses keluar
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Anda telah berhasil keluar dari akun."),
                          backgroundColor: Colors.blueGrey,
                        ),
                      );
                    }
                  ),
                ],
                
                const Divider(color: Colors.white24),
                ListTile(
                  leading: const Icon(Icons.book, color: afGold), 
                  title: const Text("Renungan Harian", style: TextStyle(color: Colors.white)), 
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const DaftarRenunganView()));
                  }
                ),
                ListTile(
                  leading: const Icon(Icons.video_library, color: afGold), 
                  title: const Text("Koleksi Video AFTV", style: TextStyle(color: Colors.white)), 
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const DaftarVideoView()));
                  }
                ),
              ],
            ),
          ),
          
          appBar: AppBar(
            toolbarHeight: 75, 
            backgroundColor: const Color(0xFF050C1A),
            elevation: 0,
            actions: [
              Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white, size: 28),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
              const SizedBox(width: 8),
            ],
            automaticallyImplyLeading: false, 
            title: Row(
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  height: 50,
                  fit: BoxFit.contain,
                  errorBuilder: (c, e, s) => const Icon(Icons.auto_stories, color: afGold, size: 40),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    "PEKABARAN ALLAH ADALAH MISI KAMI",
                    style: TextStyle(
                      fontSize: 10, 
                      fontWeight: FontWeight.w800, 
                      color: Colors.white, 
                      letterSpacing: 0.5
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.all(16),
                  width: double.infinity,
                  height: 210, 
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.4), blurRadius: 10, offset: const Offset(0, 5))
                    ],
                    image: const DecorationImage(
                      image: NetworkImage('https://images.unsplash.com/photo-1516321318423-f06f85e504b3?q=80&w=600&auto=format&fit=crop'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          const Color(0xFF0D1B2A).withOpacity(0.95), 
                          afPrimaryRed.withOpacity(0.4),            
                          Colors.transparent,                        
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "INSPIRASI BULANAN & KABAR PELAYANAN", 
                                style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w900, letterSpacing: 0.5)
                              ),
                              const SizedBox(height: 6),
                              const Text(
                                "Daftarkan email Anda hari ini untuk menerima buletin ringkasan pelayanan bulanan.", 
                                style: TextStyle(color: Colors.white70, fontSize: 11, height: 1.3)
                              ),
                              const SizedBox(height: 16),
                              
                              Row(
                                children: [
                                  if (!isLoggedIn) ...[
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: afGold,
                                        foregroundColor: Colors.black,
                                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                        elevation: 2,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => const RegisterView()),
                                        );
                                      },
                                      child: const Text("DAFTAR", style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 0.5)),
                                    ),
                                    const SizedBox(width: 8),
                                    OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                        side: const BorderSide(color: Colors.white70, width: 1.5),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => const LoginView()),
                                        );
                                      },
                                      child: const Text("MASUK", style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                                    ),
                                  ] else ...[
                                    ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: afGold,
                                        foregroundColor: Colors.black,
                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                        elevation: 3,
                                      ),
                                      icon: const Icon(Icons.manage_accounts, size: 16, color: Colors.black),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => const EditAkunView()),
                                        );
                                      },
                                      label: const Text("UBAH AKUN", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 0.5)),
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Expanded(flex: 4, child: SizedBox()),
                      ],
                    ),
                  ),
                ),

                const Padding(padding: EdgeInsets.only(left: 18, top: 10, bottom: 8), child: Text("Renungan Harian", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: afGold))),
                Consumer<RenunganViewModel>(
                  builder: (context, viewModel, child) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: viewModel.daftarRenungan.length,
                      itemBuilder: (context, index) {
                        final r = viewModel.daftarRenungan[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(color: afCardNavy, borderRadius: BorderRadius.circular(16)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell( 
                                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => RenunganDetailView(renungan: r))),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(r.imageUrl, height: 160, width: double.infinity, fit: BoxFit.cover, errorBuilder: (c,e,s) => Container(height: 160, color: Colors.grey[900])),
                                    Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(r.tanggal, style: const TextStyle(color: Colors.white54, fontSize: 11)),
                                          const SizedBox(height: 6),
                                          Text(r.judul, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                                          const SizedBox(height: 6),
                                          Text(r.isi, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white70, fontSize: 13)),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),

                const Padding(padding: EdgeInsets.only(left: 18, top: 20, bottom: 8), child: Text("Perpustakaan Media & AFTV", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: afGold))),
                Consumer<VideoViewModel>(
                  builder: (context, viewModel, child) {
                    return SizedBox(
                      height: 190,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: viewModel.daftarVideo.length,
                        itemBuilder: (context, index) {
                          final v = viewModel.daftarVideo[index];
                          return Container(
                            width: 220,
                            margin: const EdgeInsets.only(left: 16, bottom: 10),
                            decoration: BoxDecoration(color: afCardNavy, borderRadius: BorderRadius.circular(14)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell( 
                                  onTap: () => _launchURL(v.videoUrl),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Image.network(v.thumbnailUrl, height: 110, width: 220, fit: BoxFit.cover, errorBuilder: (c,e,s) => Container(height: 110, color: Colors.black26)),
                                          Container(height: 110, color: Colors.black26),
                                          const Icon(Icons.play_circle_outline, color: afGold, size: 45),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(v.judul, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white)),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),

                const Padding(
                  padding: EdgeInsets.only(left: 18, top: 25, bottom: 12), 
                  child: Text("Kontak Pelayanan & Donasi", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: afGold)),
                ),
                Consumer<KontakViewModel>(
                  builder: (context, viewModel, child) {
                    if (viewModel.kontakInfo == null) return const SizedBox();
                    final k = viewModel.kontakInfo!;
                    
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      height: 240,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 12, offset: const Offset(0, 6))
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Image.network(
                                'https://images.unsplash.com/photo-1504052434569-70ad5836ab65?q=80&w=600&auto=format&fit=crop', 
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned.fill(
                              child: Container(
                                color: const Color(0xFF0D1B2A).withOpacity(0.6),
                              ),
                            ),

                            Positioned.fill(
                              child: ClipPath(
                                clipper: DiagonalSplitClipper(),
                                child: Stack(
                                  children: [
                                    Positioned.fill(
                                      child: Image.network(
                                        'https://images.unsplash.com/photo-1579621970563-ebec7560ff3e?q=80&w=600&auto=format&fit=crop', 
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: Container(
                                        color: const Color(0xFF1B263B).withOpacity(0.85), 
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            Positioned.fill(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.all(5),
                                                decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                                                child: const Icon(Icons.chat_bubble, color: Colors.white, size: 14),
                                              ),
                                              const SizedBox(width: 6),
                                              const Text("KONSELING", style: TextStyle(color: afGold, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 0.8)),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          const Text("Kontak Belajar Alkitab", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                                          const SizedBox(height: 4),
                                          const Text("Konsultasi rohani pribadi langsung via WhatsApp.", style: TextStyle(color: Colors.white70, fontSize: 10, height: 1.2)),
                                          const SizedBox(height: 10),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.green[600],
                                              foregroundColor: Colors.white,
                                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                              minimumSize: Size.zero,
                                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                            ),
                                            onPressed: () => _launchURL("https://wa.me/${k.nomorHotline}?text=Halo%20Amazing%20Facts%2C%20saya%20ingin%20konsultasi%20Alkitab."),
                                            child: const Text("CHAT CS", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    
                                    const SizedBox(width: 24),
                                    
                                    Expanded(
                                      flex: 5,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Text("MITRA DONASI", style: TextStyle(color: afGold, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 0.8)),
                                          const SizedBox(height: 8),
                                          Text(k.namaBank, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold), textAlign: TextAlign.end),
                                          const SizedBox(height: 2),
                                          Text(k.nomorRekening, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w900, letterSpacing: 0.5), textAlign: TextAlign.end),
                                          const SizedBox(height: 2),
                                          Text("a.n. ${k.atasNama}", style: const TextStyle(color: Colors.white54, fontSize: 9, fontStyle: FontStyle.italic), textAlign: TextAlign.end, maxLines: 1, overflow: TextOverflow.ellipsis),
                                          const SizedBox(height: 10),
                                          ElevatedButton.icon(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: afPrimaryRed,
                                              foregroundColor: Colors.white,
                                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                              minimumSize: Size.zero,
                                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                            ),
                                            icon: const Icon(Icons.send, size: 10),
                                            onPressed: () => _launchURL("https://wa.me/${k.nomorHumas}?text=Halo%20Humas%20Amazing%20Facts%2C%20saya%20ingin%20konfirmasi%20bukti%20donasi."),
                                            label: const Text("KONFIRMASI WA", style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        );
      },
    );
  }
}

class DiagonalSplitClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width * 0.35, size.height); 
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(size.width * 0.65, 0); 
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}