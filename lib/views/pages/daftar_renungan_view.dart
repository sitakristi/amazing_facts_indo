part of pages;

class DaftarRenunganView extends StatelessWidget {
  const DaftarRenunganView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      appBar: AppBar(
        title: const Text("Daftar Renungan Harian", style: TextStyle(color: Colors.white)), 
        backgroundColor: const Color(0xFF050C1A), 
        iconTheme: const IconThemeData(color: Colors.white)
      ),
      body: Consumer<RenunganViewModel>(
        builder: (context, vm, child) {
          return ListView.builder(
            itemCount: vm.daftarRenungan.length,
            itemBuilder: (context, idx) {
              final r = vm.daftarRenungan[idx];
              return ListTile(
                leading: const Icon(Icons.book, color: Color(0xFFFBC02D)),
                title: Text(r.judul, style: const TextStyle(color: Colors.white)),
                subtitle: Text(r.tanggal, style: const TextStyle(color: Colors.white54)),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RenunganDetailView(renungan: r))),
              );
            },
          );
        },
      ),
    );
  }
}