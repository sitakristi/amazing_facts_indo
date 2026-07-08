# Amazing Facts Indonesia Mobile App

## Deskripsi Proyek

Amazing Facts Indonesia merupakan aplikasi mobile berbasis Flutter yang dikembangkan sebagai tugas pada mata kuliah Mobile Application Development. Proyek ini dikerjakan secara bertahap mulai dari Assignment for Learning (AFL) hingga Assignment of Learning Project (ALP).

Pada tahap awal, aplikasi berfokus pada pengembangan fitur utama seperti login, register, renungan harian, video pembelajaran, hotline pelayanan, dan informasi donasi. Seiring berjalannya proses pembelajaran, aplikasi terus dikembangkan dengan menerapkan arsitektur MVVM, integrasi REST API menggunakan Laravel, database SQLite, serta Unit Testing untuk meningkatkan kualitas aplikasi.

Seluruh pengembangan tersebut terdokumentasi pada repositori ini sebagai bagian dari proses pembelajaran selama satu semester.

# **Amazing Facts Indonesia Mobile App (AFL 2 & AFL 3 - MVVM, Jaringan, & Unit Testing)**

Selamat datang di repositori proyek Amazing Facts Indonesia. Aplikasi mobile ini saya kembangkan menggunakan Flutter untuk memenuhi tugas revisi AFL 2 sekaligus melengkapi modul pengujian otomatis untuk memenuhi tugas AFL 3. Melalui pembaruan ini, aplikasi sudah dikembangkan dengan standar arsitektur industri yang siap menghubungkan client-server secara asinkron menggunakan library HTTP.

---

## **Penjelasan Singkat Arsitektur MVVM dan Komponennya**

Aplikasi ini dibangun sepenuhnya menggunakan arsitektur **MVVM (Model-View-ViewModel)** dengan bantuan package **Provider** sebagai pengatur status data (*state management*). Pemisahan ini sengaja dilakukan agar kodingan tampilan (UI) tidak bercampur dengan logika bisnis aplikasi.

Berikut adalah pembagian **4 lapisan utama komponen MVVM** yang saya terapkan:

* **Model**: Berisi cetakan data mentah aplikasi (*blueprint data*). Semua model di sini (seperti UserModel, RenunganModel, VideoModel, dan KontakModel) dibuat memperluas (*extends*) **Equatable** agar Flutter bisa membandingkan nilai objek secara efisien tanpa memicu kebocoran memori atau rendering UI yang tidak perlu.
* **Repository**: Bagian terisolasi yang bertugas mengatur lalu lintas data dan menampung fungsi HTTPS request-response (GET dan POST). Lapisan ini mengonversi data JSON mentah dari server menjadi objek model sebelum dikirim ke ViewModel.
* **ViewModel**: Jembatan utama yang mengatur logika bisnis aplikasi. Kelas ini memperluas *ChangeNotifier* untuk menyiarkan sinyal perubahan data secara reaktif ke layar melalui fungsi *notifyListeners()*.
* **View**: Semua halaman visual yang dilihat oleh pengguna. Lapisan UI ini memanfaatkan widget *Consumer* dari package Provider agar bisa merespons perubahan status data secara otomatis dan instan.

Sesuai instruksi, saya juga menerapkan **sistem satu pintu** menggunakan **part** dan **part of** di setiap folder utama untuk mengelompokkan file individu dan menghilangkan penumpukan baris *import*. Di bagian tampilan, saya juga memisahkan folder menjadi **pages** (untuk halaman blueprint utuh seperti login, register, home, detail renungan) dan **widgets** (untuk komponen kustom modular yang bisa dipakai berulang kali, seperti *custom_input_field.dart*).

---

## **Cara Menjalankan Aplikasi**

Aplikasi ini dapat dijalankan melalui dua jalur, tergantung apakah Anda ingin membukanya lewat GUI Xcode atau langsung menggunakan perintah Terminal:

### **Opsi 1: Melalui Terminal (Mac atau Windows)**

Ini adalah cara paling cepat untuk menjalankan aplikasi langsung menggunakan Android Emulator atau iOS Simulator yang sudah aktif di laptop Anda:

1. Buka folder proyek `amazing_facts_indo` di terminal atau VS Code.
2. Unduh seluruh package library yang dibutuhkan dengan mengetik perintah:
```bash

```



flutter pub get

```
3.  Jalankan aplikasi menuju emulator perangkat Anda dengan perintah:
    ```bash
    flutter run

```

### **Opsi 2: Melalui Xcode (Khusus Pengguna Mac)**

Jika Anda menggunakan perangkat Mac dan ingin memeriksa atau menjalankan proyek iOS langsung dari aplikasi Xcode, silakan ikuti langkah-langkah berikut:

1. Buka terminal di direktori utama proyek, lalu bersihkan cache dan unduh dependensi Flutter dengan mengetik:
```bash
flutter clean
flutter pub get

```



```
2.  Masuk ke folder iOS untuk menginstal modul pod Apple agar library eksternal terkonfigurasi dengan benar:
    ```bash
    cd ios
    pod install

```

```
Setelah selesai, kembali ke folder utama dengan mengetik `cd ..`.

```

3. Buka aplikasi **Finder**, masuk ke folder proyek `amazing_facts_indo/ios/`, lalu klik dua kali berkas **`Runner.xcworkspace`** (pilih ikon yang berwarna putih/workspace, bukan berkas *xcodeproj* yang berwarna biru).
4. Setelah jendela Xcode terbuka, pilih simulator iOS yang ingin digunakan pada bar menu atas, lalu klik tombol **Play** (ikon segitiga di pojok kiri atas) atau tekan tombol **`Command + R`** pada keyboard Mac.

---

## **Dokumentasi Pengujian Otomatis (Capaian AFL 3 - Unit Testing)**

### **1. Deskripsi Fitur dan Komponen Unit yang Dipilih**

Sesuai dengan pembahasan mengenai tingkatan pengujian perangkat lunak (*level of software testing*), saya memilih komponen terkecil dari kode aplikasi (*Unit Testing*) yang berada pada lapisan `UserViewModel`. Unit spesifik yang diisolasi untuk diuji adalah logika fungsi validasi data masukan teks pada fungsi `registerUser()`. Pengujian ini menerapkan pendekatan *Whitebox Testing* karena berfokus pada keandalan logika internal jalur kode, memastikan alur kondisi percabangan (*branch/condition coverage*) dapat memfilter data dengan benar sebelum dialokasikan ke memori RAM aplikasi.

### **2. Karakteristik dan Lingkungan Pengujian**

Sesuai dengan karakteristik teknis pengujian, unit test ini dijalankan murni di dalam lingkungan pengembangan tanpa menggunakan emulator perangkat fisik atau virtual (*environment independent*). Pengujian ini mengandalkan kerangka kerja *flutter_test* bawaan dengan menerapkan pola struktur **AAA (Arrange, Act, Assert)**:

* **Arrange**: Menyiapkan kondisi awal data masukan tekstual tiruan (seperti skenario nama kosong vs nama lengkap terisi).
* **Act**: Mengeksekusi secara asinkron fungsi `.registerUser()` yang ada di dalam kelas target.
* **Assert**: Melakukan verifikasi ekspektasi menggunakan fungsi `expect()` untuk mencocokkan hasil aktual dengan kriteria validitas desain.

Untuk mengeksekusi berkas pengujian ini, Anda dapat menjalankan perintah berikut pada terminal:

```bash
flutter test test/user_validation_test.dart

```

### **3. Tabel Hasil Pengujian Perilaku Aplikasi (Black-Box & Functional View)**

Berikut adalah visualisasi hasil pengujian fungsional berdasarkan standar pelaporan penjaminan mutu perangkat lunak:

| No | Kondisi Fungsi Aplikasi | Aksi yang Diharapkan | Aksi yang Diperoleh | Status Pengujian |
| --- | --- | --- | --- | --- |
| **1** | Kolom nama lengkap kosong saat menekan tombol daftar | Sistem menolak proses registrasi dan data jemaat baru tidak tersimpan di memori | Pendaftaran gagal dan status akun pengguna baru tetap bernilai NULL | **Valid** |
| **2** | Semua kolom teks (Nama, Email, Password) terisi data yang sesuai | Sistem sukses menambahkan data jemaat baru ke dalam repositori lokal | Pendaftaran berhasil, jumlah data bertambah, dan informasi jemaat tersimpan dengan cocok | **Valid** |

---

## **Refleksi Tugas (Assignment Reflection)**

**Apa yang Saya Pelajari:**
Proses merombak total struktur aplikasi ini berdasarkan koreksi dari dosen benar-benar memberikan pemahaman baru bagi saya mengenai standar koding industri yang sebenarnya. Di proyek awal, saya akui masih sering mencampuradukkan baris import library pihak ketiga di sembarang file dan menggabungkan banyak logika di dalam satu halaman tampilan yang sama. Melalui revisi ini, saya belajar bagaimana mengisolasi urusan jaringan di folder data, membuat cetakan data yang efisien dengan Equatable, dan menyatukan berkas individu menggunakan sistem ekspor satu pintu (*library, part,* dan *part of*). Memisahkan halaman utama (*pages*) dengan komponen teks input modular (*widgets*) juga membuat saya paham bagaimana cara menulis kode yang efisien, hemat baris, dan tidak berulang-ulang.

Menerapkan tugas pengujian otomatis pada AFL 3 juga membuka mata saya tentang pentingnya aspek *Software Testability*. Saya belajar bahwa kode yang baik bukan hanya sekadar bisa berjalan saat diklik di simulator, melainkan harus memenuhi kriteria *Decomposability* yaitu kemampuan kode untuk dipecah menjadi unit-unit kecil terpisah agar bisa diuji secara terisolasi.

**Tantangan yang Dihadapi:**
Tantangan terbesar dalam revisi ini adalah menyesuaikan kembali aliran data aplikasi setelah properti pada model diubah menjadi final demi memenuhi syarat Equatable. Saya sempat menghadapi kendala eror kompilasi Xcode yang cukup banyak karena Flutter menolak perubahan variabel user secara langsung menggunakan tanda sama dengan (=) saat fitur edit profil dieksekusi. Untuk mengatasinya, saya belajar menyiasati logika tersebut dengan menyusun ulang fungsi di UserViewModel agar membuat objek UserModel baru dari data input teks yang dikirim oleh View. Tantangan berikutnya, melacak dan memastikan semua file individu terikat dengan benar ke file gerbang utamanya tanpa ada import mandiri yang terselip membutuhkan tingkat ketelitian yang tinggi. Namun, proses debugging ini sangat membantu saya dalam memahami cara kerja state management dan struktur berkas di Flutter dengan lebih baik.

Selain itu, tantangan di AFL 3 adalah memisahkan ketergantungan komponen (*Dependency Management*) agar fungsi yang diuji benar-benar berada dalam kondisi terisolasi murni. Melacak dan memastikan semua file individu terikat dengan benar ke file gerbang utamanya tanpa ada import mandiri yang terselip membutuhkan tingkat ketelitian yang tinggi. Namun, proses debugging dan penyusunan berkas uji ini sangat membantu saya dalam memahami cara kerja state management, siklus hidup pengujian otomatis, dan struktur berkas di Flutter dengan jauh lebih baik.

---

# Hasil Pengembangan ALP (Final Project)

Pada tahap Assignment of Learning Project (ALP), aplikasi kembali disempurnakan berdasarkan hasil usability testing yang dilakukan kepada beberapa pengguna. Masukan yang paling sering diberikan adalah penambahan koleksi video pembelajaran Alkitab.

Perbaikan yang telah dilakukan meliputi:

- penambahan jumlah video pembelajaran dari 2 video menjadi 9 video;
- penyempurnaan tampilan dan struktur aplikasi agar lebih mudah digunakan;
- seluruh video dapat dibuka langsung melalui YouTube;
- koleksi video akan terus diperbarui mengikuti penambahan konten pada kanal YouTube Amazing Facts Indonesia.

Selain itu, struktur aplikasi tetap menggunakan arsitektur MVVM, komunikasi data melalui REST API Laravel, database SQLite, serta Unit Testing yang telah diterapkan pada tahap AFL sebelumnya.

Pengembangan selanjutnya direncanakan mencakup fitur bookmark renungan, remember me, download konten offline, book store, serta upload bukti donasi.
---

Terima Kasih


---
