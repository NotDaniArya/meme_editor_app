# Meme Editor App 🖼️
### Aplikasi ini dibuat untuk Flutter Engineer Test 2025 – PT. Qansa Solusi Indonesia
Sebuah aplikasi mobile sederhana yang dibangun menggunakan Flutter untuk membuat dan mengedit meme. Aplikasi ini memungkinkan pengguna untuk memilih template meme populer, menambahkan teks, dan menyimpannya ke galeri atau membagikannya.

Proyek ini dibuat sebagai studi kasus penerapan Clean Architecture dan praktik terbaik pengembangan aplikasi Flutter.

## ✨ Fitur Utama
Galeri Meme: Menampilkan daftar template meme yang diambil dari API publik (imgflip.com).

Caching Gambar: Gambar yang sudah dimuat akan disimpan di cache untuk performa yang lebih baik dan penggunaan offline.

Editor Interaktif:

Menambahkan satu atau lebih layer teks.

Memanipulasi teks (geser, ubah ukuran, dan putar) dengan gestur intuitif.

Mengedit konten teks dengan double-tap.

Undo/Redo: Membatalkan atau mengulangi aksi di halaman editor.

Simpan & Bagi:

Menyimpan hasil editan meme ke galeri perangkat.

Membagikan hasil meme ke aplikasi lain (media sosial, pesan, dll).

UI Modern: Termasuk fitur Pull-to-refresh di halaman utama.

## 🛠️ Arsitektur & Teknologi
Aplikasi ini dibangun dengan fokus pada kode yang bersih, teruji, dan mudah dikelola.

Arsitektur: Clean Architecture, dengan pemisahan yang jelas antara lapisan:

Presentation: UI (Widgets) dan State Management (Riverpod).

Domain: Logika bisnis murni (Use Cases & Entities), tidak bergantung pada framework.

Data: Implementasi pengambilan data (Repositories & Data Sources).

State Management: Riverpod

Navigasi: go_router

Networking: http

Functional Programming: dartz untuk menangani Either<Failure, Success>

Paket Utama Lainnya:

cached_network_image (Caching)

saver_gallery (Menyimpan ke Galeri)

share_plus (Membagikan File)

permission_handler (Mengelola Izin)

equatable & uuid

## 🚀 Instalasi & Menjalankan Proyek
Berikut adalah cara untuk menjalankan proyek ini di mesin lokal Anda.

Prasyarat
Pastikan Anda sudah menginstal Flutter SDK (versi 3.x atau lebih baru).

Sebuah emulator Android atau iOS, atau perangkat fisik.

Langkah-langkah
1. clone repositori ini
2. jalankan perintah 'flutter pub get' untuk menginstall semuan dependensi
3. (Jika Diperlukan) Generate file untuk testing/mocking dengan perintah 'flutter pub run build_runner build --delete-conflicting-outputs'
4. jalankan aplikasi dengan perintah 'flutter run'