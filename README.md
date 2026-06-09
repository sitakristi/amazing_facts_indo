
**Amazing Facts Indonesia Mobile App (Revisi AFL 2 - MVVM & Jaringan Terintegrasi)**

Selamat malam Pak Mychael, ini adalah pembaruan proyek aplikasi mobile Amazing Facts Indonesia yang telah direfaktor total untuk memenuhi seluruh poin instruksi revisi pada AFL 2. Pada pembaruan ini, aplikasi tidak lagi sekadar menggunakan simulasi memori lokal mentah, melainkan sudah dikembangkan dengan standar arsitektur industri yang siap menghubungkan client-server secara asinkron.

**Struktur Arsitektur dan Pembagian Folder (Sistem Satu Pintu)**

Mengikuti instruksi dari Bapak, proyek ini sekarang menerapkan sistem library tunggal menggunakan kata kunci "part" dan "part of" di setiap folder utama. Tujuannya adalah menghilangkan penumpukan baris import di setiap file individu, sehingga manajemen kode menjadi jauh lebih bersih. Aplikasi kini dibagi menjadi lapisan-lapisan berikut:

**1. data (Networking & Sirkulasi Data)**
Folder ini bertindak sebagai pengatur sirkulasi data keluar-masuk aplikasi. Di dalamnya terdapat sub-folder "network" dan file "api_client.dart" yang menggunakan library "http" dari pub.dev. File ini bertindak sebagai HTTPS client untuk mengatur hubungan asinkron dengan server luar (API server) sekaligus menangani status respons internet, seperti mendeteksi apakah koneksi berhasil (status code 200) atau gagal.

**2. models (Blueprint Data & Equatable)**
Folder ini berisi cetakan data mentah aplikasi. Semua model di sini (UserModel, RenunganModel, VideoModel, dan KontakModel) sekarang wajib memperluas (extends) "Equatable" dari pub.dev. Dengan mengimplementasikan props, Flutter dapat membandingkan nilai objek secara efisien tanpa memicu kebocoran memori atau rendering UI yang tidak perlu.

**3. repositories (Penampung Fungsi GET & POST)**
Folder ini bertindak sebagai penghubung antar model dan lapisan jaringan. Semua fungsi asinkron untuk mengambil atau mengirim data ke server luar (seperti loginCheck, getRenungan, getVideos, dan getKontakInfo) ditampung di sini. Data respons mentah (JSON) dari ApiClient pertama kali diterima oleh Repository, didecode, diconvert ke dalam bentuk objek model, baru kemudian dilempar ke ViewModel.

**4. viewmodels (Manajemen State & Aliran Stream)**
Folder ini berisi pengatur alur data (stream) sebelum disiarkan ke UI. Semua kelas di sini memperluas "ChangeNotifier" untuk mengatur status loading aplikasi dan memicu fungsi "notifyListeners()". ViewModel memanggil fungsi dari Repository, lalu menyiarkan data tersebut agar tampilan visual di layar bisa langsung terupdate.

**5. views (Pemisahan Pages dan Widgets Modular)**
Lapisan visual UI sekarang dipisah secara tegas menjadi dua bagian:

* **views/pages**: Berisi file blueprint halaman utuh (tampilan penuh aplikasi) seperti splash_screen, login_view, register_view, home_screen, daftar_renungan_view, renungan_detail_view, daftar_video_view, dan edit_akun_view.
* **views/widgets**: Berisi komponen modular kecil yang bisa digunakan kembali secara massal untuk keperluan berbeda di berbagai halaman. Sebagai contoh, kami membuat "custom_input_field.dart" yang membungkus dekorasi TextField bertema gelap dan emas universal, sehingga halaman login dan register tinggal memanggil widget kustom ini tanpa perlu menulis ulang dekorasi yang panjang.

**6. shared (Konstanta Universal)**
Folder baru yang ditambahkan untuk mendeklarasikan variabel yang digunakan secara massal di seluruh aplikasi, seperti menyimpan konfigurasi Base URL universal dan nama aplikasi di dalam file "constants.dart".

---

**Daftar Pembaruan Fitur Aplikasi (Capaian Hasil Revisi)**

Berikut adalah sirkulasi fitur yang sudah berjalan stabil setelah perbaikan arsitektur:

* **Mekanisme Error Handling Jaringan Terbuka**: Saat aplikasi dijalankan, ViewModel otomatis memicu penarikan data asinkron dari Repositori menuju ApiClient. Jika server eksternal (seperti Laravel lokal) belum aktif atau gagal merespons, sistem try-catch yang kami buat di lapisan data tidak akan membuat aplikasi crash. Sistem akan langsung menampilkan log pemberitahuan di terminal dan otomatis mengalihkan aliran data ke cadangan data simulasi internal agar UI tetap tampil dengan aman.
* **Autentikasi dan Mutasi Profil Reaktif**: Proses registrasi, pemeriksaan login, dan logout sudah terhubung berjenjang dari halaman ke UserViewModel melalui UserRepository. Karena UserModel sekarang bersifat Equatable (property final), fitur ubah profil di halaman Edit Akun diimplementasikan dengan metode pembuatan objek instans baru di dalam ViewModel, yang terbukti sukses memperbarui data jemaat secara real-time di layar depan tanpa merusak state aplikasi.
* **Perpustakaan Video dan Deep Linking**: Daftar Koleksi Video AFTV kini ditarik secara terstruktur. Saat salah satu kartu video diketuk oleh pengguna, fungsi asinkron akan memicu library "url_launcher" yang diimport terpusat di gerbang "pages.dart" untuk membuka deep link tautan YouTube eksternal melalui browser atau aplikasi YouTube asli perangkat.
* **Banner Layanan Konseling & Donasi**: Bagian bawah halaman utama menampilkan banner informasi kontak yang memisahkan fitur chat WhatsApp CS Konseling dan detail rekening mitra donasi dengan aman melalui komponen DiagonalSplitClipper kustom.

---

**Cara Menjalankan Aplikasi di Perangkat Simulator**

1. Pastikan Anda berada di direktori utama proyek melalui terminal VS Code: amazing_facts_indo
2. Bersihkan sisa cache kompilasi build lama dengan mengetik:
`flutter clean`
3. Unduh ulang paket dependensi http, equatable, provider, dan url_launcher yang terdaftar di berkas satu pintu melalui perintah:
`flutter pub get`
4. Pastikan simulator iOS atau emulator Android Anda sudah aktif dan terdeteksi di pojok kanan bawah VS Code.
5. Jalankan aplikasi dengan mengetik perintah:
`flutter run`

---

**Refleksi Tugas (Assignment Reflection)**

**Apa yang Saya Pelajari:**
Proses merombak total struktur aplikasi ini berdasarkan koreksi dari Bapak benar-benar memberikan pemahaman baru bagi saya mengenai standar koding industri yang sebenarnya. Di proyek awal, saya akui masih sering mencampuradukkan baris import library pihak ketiga di sembarang file dan menggabungkan banyak logika di dalam satu halaman tampilan. Melalui revisi ini, saya belajar bagaimana mengisolasi urusan jaringan di folder data, membuat cetakan data yang efisien dengan Equatable, and menyatukan berkas individu menggunakan sistem ekspor satu pintu (library, part, dan part of). Memisahkan halaman utama (pages) dengan komponen teks input modular (widgets) juga membuat saya paham bagaimana cara menulis kode yang efisien, hemat baris, dan tidak berulang-ulang.

**Tantangan yang Dihadapi:**
Tantangan terbesar dalam revisi ini adalah memperbaiki putusnya aliran data akibat perubahan property model menjadi final demi memenuhi syarat Equatable. Saya sempat menghadapi kendala eror kompilasi Xcode yang cukup banyak karena Flutter menolak tanda sama dengan (=) untuk mengubah variabel user secara langsung saat fitur edit profil dieksekusi. Saya harus mencari cara dan belajar untuk dapat menyusun ulang fungsi di UserViewModel agar membuat cetakan objek UserModel baru dari data input tekstual yang dikirim oleh View. Selain itu, melacak dan memastikan semua file individu terikat dengan benar ke file gerbang utamanya tanpa ada import mandiri yang terselip membutuhkan tingkat ketelitian yang sangat tinggi. Namun, ketika melihat aplikasi ini akhirnya berhasil berjalan mulus di simulator tanpa ada baris eror merah lagi di terminal, hal itu sangat meningkatkan rasa percaya diri saya dalam menguasai framework Flutter.