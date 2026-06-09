**Amazing Facts Indonesia Mobile App (Revisi AFL 2 - MVVM & Jaringan Terintegrasi)**

Selamat datang di repositori proyek Amazing Facts Indonesia. Aplikasi mobile ini saya kembangkan menggunakan Flutter untuk memenuhi tugas revisi AFL 2. Melalui pembaruan ini, aplikasi sudah dikembangkan dengan standar arsitektur industri yang siap menghubungkan client-server secara asinkron menggunakan library HTTP.

**Penjelasan Singkat Arsitektur MVVM dan Komponennya**

Aplikasi ini dibangun sepenuhnya menggunakan arsitektur **MVVM (Model-View-ViewModel)** dengan bantuan package **Provider** sebagai pengatur status data (*state management*). Pemisahan ini sengaja dilakukan agar kodingan tampilan (UI) tidak bercampur dengan logika bisnis aplikasi.

Berikut adalah pembagian 4 lapisan utama komponen MVVM yang saya terapkan:

* **Model**: Berisi cetakan data mentah aplikasi (*blueprint data*). Semua model di sini (seperti UserModel dan RenunganModel) dibuat memperluas (*extends*) **Equatable** agar Flutter bisa membandingkan nilai objek secara efisien tanpa memicu kebocoran memori.
* **Repository**: Bagian terisolasi yang bertugas mengatur lalu lintas data dan menampung fungsi HTTPS request-response (GET dan POST). Lapisan ini mengonversi data JSON mentah dari server menjadi objek model sebelum dikirim ke ViewModel.
* **ViewModel**: Jembatan utama yang mengatur logika bisnis aplikasi. Kelas ini memperluas *ChangeNotifier* untuk menyiarkan sinyal perubahan data secara reaktif ke layar melalui fungsi *notifyListeners()*.
* **View**: Semua halaman visual yang dilihat oleh pengguna. Lapisan UI ini memanfaatkan widget *Consumer* dari package Provider agar bisa merespons perubahan status data secara otomatis dan instan.

Sesuai instruksi, saya juga menerapkan sistem satu pintu menggunakan **part** dan **part of** di setiap folder utama untuk mengelompokkan file individu dan menghilangkan penumpukan baris *import*. Di bagian tampilan, saya juga memisahkan folder menjadi **pages** (untuk halaman blueprint utuh) dan **widgets** (untuk komponen kustom modular yang bisa dipakai berulang kali, seperti *custom_input_field.dart*).

---

**Cara Menjalankan Aplikasi**

Aplikasi ini dapat dijalankan melalui dua jalur, tergantung apakah Anda ingin membukanya lewat GUI Xcode atau langsung menggunakan perintah Terminal:

**Opsi 1: Melalui Terminal (Universal - Windows & Mac)**
Ini adalah cara paling cepat untuk menjalankan aplikasi langsung menggunakan Android Emulator atau iOS Simulator yang sudah aktif di laptop Anda:

1. Buka folder proyek `amazing_facts_indo` di terminal atau VS Code.
2. Unduh seluruh package library yang dibutuhkan dengan mengetik perintah:
```bash
flutter pub get

```



```
3. Jalankan aplikasi menuju emulator perangkat Anda dengan perintah:
   ```bash
   flutter run

```

**Opsi 2: Melalui Xcode (Khusus Pengguna Mac)**
Jika Anda menggunakan perangkat Mac dan ingin memeriksa atau menjalankan proyek iOS langsung dari aplikasi Xcode, silakan ikuti langkah-langkah berikut:

1. Buka terminal di direktori utama proyek, lalu bersihkan cache dan unduh dependensi Flutter dengan mengetik:
```bash

```



flutter clean

```
   ```bash
flutter pub get

```

2. Masuk ke folder iOS untuk menginstal modul pod Apple agar library eksternal terkonfigurasi dengan benar:
```bash

```



cd ios

```
   ```bash
pod install

```

Setelah selesai, kembali ke folder utama dengan mengetik `cd ..`.
3. Buka aplikasi **Finder**, masuk ke folder proyek `amazing_facts_indo/ios/`, lalu klik dua kali berkas **`Runner.xcworkspace`** (pilih ikon yang berwarna putih, bukan berkas *xcodeproj* yang berwarna biru).
4. Setelah jendela Xcode terbuka, pilih simulator iOS yang ingin digunakan pada bar menu atas, lalu klik tombol **Play** (ikon segitiga di pojok kiri atas) atau tekan tombol **`Command + R`** pada keyboard Mac.

---

**Refleksi Tugas (Assignment Reflection)**

**Apa yang Saya Pelajari:**
Proses merombak total struktur aplikasi ini berdasarkan koreksi dari dosen benar-benar memberikan pemahaman baru bagi saya mengenai standar koding industri yang sebenarnya. Di proyek awal, saya akui masih sering mencampuradukkan baris import library pihak ketiga di sembarang file dan menggabungkan banyak logika di dalam satu halaman tampilan yang sama. Melalui revisi ini, saya belajar bagaimana mengisolasi urusan jaringan di folder data, membuat cetakan data yang efisien dengan Equatable, dan menyatukan berkas individu menggunakan sistem ekspor satu pintu (*library, part,* dan *part of*). Memisahkan halaman utama (*pages*) dengan komponen teks input modular (*widgets*) juga membuat saya paham bagaimana cara menulis kode yang efisien, hemat baris, dan tidak berulang-ulang.

**Tantangan yang Dihadapi:**
Tantangan terbesar dalam revisi ini adalah menyesuaikan kembali aliran data aplikasi setelah properti pada model diubah menjadi final demi memenuhi syarat Equatable. Saya sempat menghadapi kendala eror kompilasi Xcode yang cukup banyak karena Flutter menolak perubahan variabel user secara langsung menggunakan tanda sama dengan (=) saat fitur edit profil dieksekusi. Untuk mengatasinya, saya belajar menyiasati logika tersebut dengan menyusun ulang fungsi di UserViewModel agar membuat objek UserModel baru dari data input teks yang dikirim oleh View. Selain itu, melacak dan memastikan semua file individu terikat dengan benar ke file gerbang utamanya tanpa ada import mandiri yang terselip membutuhkan tingkat ketelitian yang tinggi. Namun, proses debugging ini sangat membantu saya dalam memahami cara kerja state management dan struktur berkas di Flutter dengan lebih baik.


Terima Kasih