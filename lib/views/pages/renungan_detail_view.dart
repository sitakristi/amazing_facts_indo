// lib/views/pages/renungan_detail_view.dart
part of pages;

class RenunganDetailView extends StatelessWidget {
  final RenunganModel renungan;
  const RenunganDetailView({Key? key, required this.renungan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      appBar: AppBar(
        title: const Text("Baca Renungan", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFFC62828), 
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(renungan.imageUrl, fit: BoxFit.cover, width: double.infinity, errorBuilder: (c,e,s) => Container(height: 200, color: Colors.grey[900])),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(renungan.tanggal, style: const TextStyle(color: Colors.white54, fontSize: 13)),
                  const SizedBox(height: 10),
                  Text(renungan.judul, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white, height: 1.3)),
                  const Divider(color: Colors.white24, height: 30, thickness: 1),
                  Text(renungan.isi, style: const TextStyle(fontSize: 15, color: Colors.white70, height: 1.6)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}