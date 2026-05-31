# Amazing Facts Indonesia Mobile App (AFL 2 - MVVM Implementation)
Halo Pak Mychael, Ini adalah proyek aplikasi mobile **Amazing Facts Indonesia** yang dikembangkan menggunakan Flutter untuk memenuhi tugas **AFL 2 (Sesi 8)**. Aplikasi ini dibuat sebagai pusat informasi rohani terpadu agar pengguna bisa mengakses seluruh materi pembelajaran dan layanan komunikasi dalam satu platform tanpa harus berpindah-pindah aplikasi.

Aplikasi ini dibangun sepenuhnya menggunakan arsitektur **Industrial MVVM (Model-View-ViewModel)** dengan bantuan package **Provider** sebagai pengatur state-nya untuk menjamin pemisahan kode yang bersih antara UI (Frontend) dan logika bisnis.


## Struktur Arsitektur (Bagaimana Kode Ini Dividisikan)
Aplikasi ini dibagi menjadi 4 lapisan utama sesuai prinsip MVVM agar kodenya rapi, terstruktur, dan mudah dirawat:
1.  **Model**: Berisi cetakan data mentah aplikasi (blueprint data), seperti cetakan data profil pengguna (`UserModel`), data artikel renungan, data galeri video, hingga data kontak pelayanan.
2.  **Repository**: Bagian terisolasi yang bertugas mengatur lalu lintas data (simulasi database lokal), termasuk mengeksekusi fungsi manajemen data CRUD (Create, Read, Update, Delete) akun pengguna.
3.  **ViewModel**: Jembatan utama yang mengatur logika bisnis dan menyediakan data siap pakai untuk tampilan UI. Kelas ini memperluas `ChangeNotifier` untuk menyiarkan sinyal perubahan data secara reaktif ke layar.
4.  **View**: Semua halaman visual yang dilihat dan digunakan oleh pengguna. Lapisan ini memanfaatkan widget `Consumer` dari package Provider agar UI bisa merespons perubahan status data secara instan dan otomatis.


## Daftar Fitur Lengkap Aplikasi (Capaian AFL 2)
Berikut adalah seluruh fitur fungsional yang sudah berhasil diimplementasikan di dalam aplikasi hingga tahap evaluasi AFL 2:

### Modul Autentikasi & Manajemen Akun (Penyimpanan Memori Sementara)
1. **Registrasi Akun Baru**: Pengguna dapat mendaftarkan akun baru menggunakan email, nama lengkap, dan kata sandi. Data ini disimpan sementara di dalam memori aplikasi menggunakan pola Repository lokal.
2. **Akses Masuk (Login)**: Pengguna bisa masuk ke dalam sistem aplikasi secara aman untuk mengakses fitur privat. Proses pencocokan data dilakukan via simulasi di dalam kelas UserViewModel.
3. **Sesi Keluar (Logout)**: Menghapus data sesi login secara murni dari memori aplikasi (RAM), mengubah tampilan aplikasi kembali ke status sebelum masuk, dan menutup drawer secara otomatis.
4. **Formulir Ubah Profil**: Pengguna yang sudah masuk bisa memperbarui data diri lengkap mereka melalui form input teks fungsional di halaman Edit Akun, dan datanya langsung terupdate di layar secara *real-time*.
5. *Catatan Teknis (Frontend Development)*: Karena tugas AFL 2 ini berfokus pada arsitektur pola MVVM, semua data akun di atas disimpan di dalam memori lokal jangka pendek (State Management). Jika aplikasi di-*restart* atau dihentikan dari VS Code, data akun akan kembali ke kondisi bawaan (reset) karena belum terhubung ke database server permanen atau API eksternal.

### Modul Konten Rohani Terpusat (Simulasi Data Lokal)
1. **Feed Renungan Harian**: Menampilkan daftar artikel renungan terbaru di halaman utama lengkap dengan gambar, tanggal, judul, dan ringkasan teks (menggunakan simulasi data lokal/mock data dari RenunganViewModel).
2. **Arsip Renungan Utuh**: Menu navigasi khusus untuk melihat seluruh daftar arsip artikel renungan rohani yang tersedia secara terorganisir.
3. **Detail Renungan**: Pengguna bisa mengetuk artikel renungan tertentu untuk membaca seluruh isi pesan rohani secara penuh di halaman detail secara dinamis.

### Modul Perpustakaan Media & Video (Simulasi Data Lokal)
1. **Galeri Video Pembelajaran**: Menampilkan kumpulan video pembelajaran Alkitab interaktif pada halaman utama dalam bentuk *horizontal-scrolling list* (menggunakan data dummy lokal yang terstruktur via VideoViewModel).
2. **Koleksi Video AFTV**: Halaman arsip khusus yang memuat daftar lengkap koleksi video Amazing Facts TV.
3. **Integrasi Pemutar YouTube**: Menggunakan fitur *deep linking* eksternal melalui package `url_launcher`. Setiap video dummy yang diketuk pengguna akan otomatis meluncurkan dan membuka aplikasi YouTube atau browser asli menuju tautan video yang sesungguhnya.

### Modul Hotline Pelayanan & Donasi (Banner Diagonal Split)
1. **Hotline Konseling Alkitab**: Tombol akses cepat terintegrasi langsung yang akan mengarahkan pengguna ke aplikasi WhatsApp CS untuk melakukan konsultasi rohani pribadi.
2. **Informasi Rekening Donasi**: Menampilkan detail informasi rekening bank resmi pelayanan (Nama Bank, Nomor Rekening, dan Atas Nama) secara jelas tanpa memakan banyak ruang layar.
3. **Konfirmasi Bukti Donasi**: Tombol interaktif khusus yang otomatis terhubung ke WhatsApp Humas untuk mempermudah pendukung pelayanan mengirimkan konfirmasi dukungan.


## Cara Menjalankan Aplikasi di Laptop Anda
Ikuti langkah mudah berikut untuk membuka dan mengetes proyek ini:
1.  **Buka Folder Proyek**: Pastikan kamu sudah membuka folder utama `amazing_facts_indo` di VS Code atau terminal kamu.
2.  **Unduh Dependensi**: Jalankan perintah berikut di terminal untuk mendownload semua library (termasuk Provider dan Url Launcher):
    ```bash
    flutter pub get
    ```
3.  **Nyalakan Simulator**: Buka Xcode Simulator (untuk pengguna Mac) atau Android Emulator.
4.  **Jalankan Aplikasi**: Tekan tombol **F5** pada keyboard di VS Code, atau ketik perintah ini di terminal:
    ```bash
    flutter run
    ```


## Refleksi Tugas (Assignment Reflection)
**Apa yang Saya Pelajari:**
Membangun aplikasi ini menggunakan pola desain MVVM benar-benar membuka mata saya tentang cara menyusun kode yang rapi. Di proyek-proyek sebelumnya, saya terbiasa mencampur kodingan tampilan UI dengan logika aplikasi di dalam satu file yang sama, sehingga kodenya jadi berantakan dan susah kalau mau mencari eror. Dengan memisahkan program menjadi lapisan Model, View, dan ViewModel, sekarang saya paham bagaimana sebuah aplikasi standar industri yang profesional itu dirancang. Mengelola data akun pengguna lewat lapisan Repository serta belajar cara memperbarui data teks tertentu secara spesifik memberikan saya banyak wawasan koding Flutter yang sangat praktis.

**Tantangan yang Dihadapi:**
Tantangan paling berat yang saya hadapi dalam tugas ini adalah menyinkronkan status login pengguna secara global di berbagai komponen layar. Membuat tombol di banner halaman utama berubah otomatis dari "Daftar/Masuk" menjadi "Ubah Akun" di detik yang sama saat pengguna sukses login membutuhkan pelacakan data (*state*) yang sangat teliti. Saya juga sempat bingung dengan masalah cakupan data, di mana tombol keluar akun di menu samping ternyata tidak otomatis menyegarkan tampilan halaman depan. Menyelesaikan masalah eror notifikasi ini memaksa saya untuk membungkus halaman menggunakan widget Consumer global, yang akhirnya sangat melatih kemampuan *debugging* dan menaikkan rasa percaya diri saya dalam mengembangkan aplikasi dengan Flutter.