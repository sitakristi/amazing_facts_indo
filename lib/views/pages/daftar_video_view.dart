part of pages;

class DaftarVideoView extends StatelessWidget {
  const DaftarVideoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      appBar: AppBar(
        title: const Text("Daftar Video AFTV", style: TextStyle(color: Colors.white)), 
        backgroundColor: const Color(0xFF050C1A), 
        iconTheme: const IconThemeData(color: Colors.white)
      ),
      body: Consumer<VideoViewModel>(
        builder: (context, vm, child) {
          return ListView.builder(
            itemCount: vm.daftarVideo.length,
            itemBuilder: (context, idx) {
              final v = vm.daftarVideo[idx];
              return ListTile(
                leading: const Icon(Icons.play_circle_fill, color: Color(0xFFFBC02D)),
                title: Text(v.judul, style: const TextStyle(color: Colors.white)),
                onTap: () async {
                  final Uri uri = Uri.parse(v.videoUrl);
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                },
              );
            },
          );
        },
      ),
    );
  }
}