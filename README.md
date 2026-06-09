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

**Cara Menjalankan Aplikasi Menggunakan Xcode di Mac**

Jika Anda ingin membuka dan menjalankan proyek iOS dari aplikasi ini melalui Xcode di perangkat Mac, silakan ikuti langkah-langkah mudah berikut:

**1. Unduh Dependensi Awal**
Buka aplikasi Terminal di Mac Anda, masuk ke direktori utama proyek `amazing_facts_indo`, lalu jalankan dua perintah ini secara berurutan untuk membersihkan cache dan mengunduh library Flutter yang dibutuhkan:

```bash
flutter clean

```

```bash
flutter pub get

```

**2. Rakit Struktur Berkas Pods**
Masuk ke dalam folder direktori iOS proyek untuk memasang modul pod Xcode agar seluruh library eksternal (seperti url_launcher) terkonfigurasi dengan sistem Apple:

```bash
cd ios

```

```bash
pod install

```

Setelah proses instalasi pod selesai, kembali ke folder utama dengan mengetik perintah `cd ..`.

**3. Membuka Proyek Melalui GUI Xcode**

* Buka aplikasi **Finder** di Mac Anda, lalu arahkan ke folder proyek `amazing_facts_indo/ios/`.
* Cari berkas bernama **`Runner.xcworkspace`** (pastikan memilih ikon yang berwarna putih/workspace, bukan berkas *xcodeproj* yang berwarna biru).
* Klik dua kali berkas tersebut untuk membukanya secara resmi ke dalam aplikasi Xcode.

**4. Menjalankan Proyek di Simulator**

* Setelah jendela Xcode terbuka sempurna, lihat bagian bar menu atas Xcode.
* Pilih target perangkat simulator iOS yang ingin Anda gunakan (misalnya iPhone 15 atau iPhone 17).
* Klik tombol **Play** (ikon segitiga di pojok kiri atas Xcode) atau tekan kombinasi tombol **`Command + R`** pada keyboard Mac Anda.
* Tunggu hingga proses perakitan selesai (*Build Succeeded*), dan aplikasi Amazing Facts Indonesia akan otomatis menyala di simulator.

---

**Refleksi Tugas (Assignment Reflection)**

**Apa yang Saya Pelajari:**
Proses merombak total struktur aplikasi ini berdasarkan koreksi dari dosen benar-benar memberikan pemahaman baru bagi saya mengenai standar koding industri yang sebenarnya. Di proyek awal, saya akui masih sering mencampuradukkan baris import library pihak ketiga di sembarang file dan menggabungkan banyak logika di dalam satu halaman tampilan yang sama. Melalui revisi ini, saya belajar bagaimana mengisolasi urusan jaringan di folder data, membuat cetakan data yang efisien dengan Equatable, dan menyatukan berkas individu menggunakan sistem ekspor satu pintu (*library, part,* dan *part of*). Memisahkan halaman utama (*pages*) dengan komponen teks input modular (*widgets*) juga membuat saya paham bagaimana cara menulis kode yang efisien, hemat baris, dan tidak berulang-ulang.

**Tantangan yang Dihadapi:**
Tantangan terbesar dalam revisi ini adalah menyesuaikan kembali aliran data aplikasi setelah properti pada model diubah menjadi final demi memenuhi syarat Equatable. Saya sempat menghadapi kendala eror kompilasi Xcode yang cukup banyak karena Flutter menolak perubahan variabel user secara langsung menggunakan tanda sama dengan (=) saat fitur edit profil dieksekusi. Untuk mengatasinya, saya belajar menyiasati logika tersebut dengan menyusun ulang fungsi di UserViewModel agar membuat objek UserModel baru dari data input teks yang dikirim oleh View. Selain itu, melacak dan memastikan semua file individu terikat dengan benar ke file gerbang utamanya tanpa ada import mandiri yang terselip membutuhkan tingkat ketelitian yang tinggi. Namun, proses debugging ini sangat membantu saya dalam memahami cara kerja state management dan struktur berkas di Flutter dengan lebih baik.


Terima Kasih