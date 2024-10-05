# FlutterInventori

FlutterInventori adalah aplikasi CRUD sederhana yang dibangun menggunakan Flutter untuk mengelola data inventori pegawai. Aplikasi ini memungkinkan pengguna untuk **menambah**, **mengedit**, **menghapus**, dan **menampilkan** data pegawai.

## Fitur Utama

- **Tambah Data Pegawai**: Pengguna dapat menambahkan pegawai baru ke dalam sistem.
- **Edit Data Pegawai**: Pengguna dapat memperbarui data pegawai yang sudah ada.
- **Hapus Data Pegawai**: Pengguna dapat menghapus data pegawai.
- **Tampilkan Daftar Pegawai**: Menampilkan daftar pegawai secara real-time.
  
## Teknologi yang Digunakan

- **Flutter**: Framework utama untuk membangun antarmuka pengguna.
- **Dart**: Bahasa pemrograman untuk Flutter.
- **HTTP Package**: Untuk berkomunikasi dengan backend API.
- **GetX**: Manajemen state dan navigasi.
- **Laravel**: Backend API yang menangani operasi CRUD di database.

## Instalasi

Untuk menjalankan project ini di lokal, ikuti langkah-langkah berikut:

### Persyaratan
Pastikan kamu sudah menginstal:
- **Flutter SDK**: [Instalasi Flutter](https://docs.flutter.dev/get-started/install)
- **Android Studio** atau **Visual Studio Code** dengan plugin Flutter
- **Laravel Backend** (pastikan backend berjalan)

### Langkah-Langkah

1. **Clone Repository**
   ```bash
   git clone https://github.com/username/flutterinventori.git
   cd flutterinventori
   ```

2. **Install Dependencies**
   Jalankan perintah berikut untuk menginstal semua dependensi Flutter:
   ```bash
   flutter pub get
   ```

3. **Jalankan Aplikasi**
   Setelah semua dependensi diinstal, jalankan aplikasi dengan:
   ```bash
   flutter run
   ```

4. **Backend Setup**
   Pastikan backend Laravel kamu sudah diatur dan berjalan pada URL yang benar sesuai dengan yang disetting di file service Flutter.

## Struktur Folder

```plaintext
lib/
├── main.dart                  # Entry point aplikasi Flutter
├── model/
│   └── PegawaiModel.dart       # Model data Pegawai
├── services/
│   └── PegawaiService.dart     # Service untuk komunikasi HTTP dengan API
├── views/
│   ├── homepage.dart           # Halaman utama untuk menampilkan daftar pegawai
│   ├── tambahdata.dart         # Halaman untuk menambahkan pegawai baru
│   └── detailpegawai.dart      # Halaman detail pegawai
```

## API Endpoints (Laravel)

Aplikasi ini terhubung dengan API berbasis Laravel yang menyediakan endpoint untuk CRUD. Berikut adalah beberapa endpoint yang digunakan dalam project ini:

- **GET /api/pegawai** - Mendapatkan semua data pegawai
- **POST /api/pegawai** - Menambahkan pegawai baru
- **PUT /api/pegawai/{id}** - Memperbarui data pegawai
- **DELETE /api/pegawai/{id}** - Menghapus pegawai

Pastikan backend Laravel terhubung dengan database yang benar dan memiliki migrasi tabel pegawai.

## Dokumentasi Tambahan

Untuk mempelajari lebih lanjut tentang Flutter, berikut adalah beberapa sumber daya yang direkomendasikan:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)
- [Online Documentation](https://docs.flutter.dev/): Tutorial, contoh kode, dan referensi API.

## Kontribusi

Kontribusi sangat terbuka! Jika kamu ingin berkontribusi pada project ini, silakan lakukan **fork**, buat branch baru, dan buat pull request.

1. **Fork** repositori ini.
2. Buat **branch** fitur baru (`git checkout -b feature/fitur-baru`).
3. **Commit** perubahanmu (`git commit -m 'Menambahkan fitur baru'`).
4. Push ke branch (`git push origin feature/fitur-baru`).
5. Buat **pull request**.

---

### Lisensi

Project ini dilisensikan di bawah lisensi MIT - lihat file [LICENSE](LICENSE) untuk detailnya.

author : Herry Prasetyo
