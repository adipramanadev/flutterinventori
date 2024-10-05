import 'package:flutter/material.dart';
import 'package:flutterinventori/model/PegawaiModel.dart';
import 'package:flutterinventori/services/PegawaiService.dart';
import 'package:flutterinventori/views/homepage.dart';
import 'package:get/get.dart';

class Tambahdata extends StatefulWidget {
  const Tambahdata({super.key});

  @override
  State<Tambahdata> createState() => _TambahdataState();
}

class _TambahdataState extends State<Tambahdata> {
  Pegawaiservice _pegawaiservice = Pegawaiservice();

  //function simpan
  Future<void> _tambahPegawai() async {
    String nama = _namaController.text.trim();
    String alamat = _alamatController.text.trim();
    String nip = _nipController.text.trim();

    //validasi
    if (nama.isEmpty || nip.isEmpty || alamat.isEmpty) {
      Get.snackbar('eror', 'Semua field harus di isi',
          backgroundColor: Colors.red, colorText: Colors.white);
    }

    //buat instance pegwai model
    PegawaiModel pegawaiBaru =
        PegawaiModel(nama: nama, alamat: alamat, nip: nip);

    try {
      //Simpan data ke server menggunakan service yang kita buat
      await _pegawaiservice.createPegawai(pegawaiBaru);
      //tampilkan pesan sukses
      Get.snackbar(
        'Sukses',
        'Pegawai berhasil ditambahkan ',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      //reset form setelah data berhasil di simpan
      _namaController.clear();
      _alamatController.clear();
      _nipController.clear();

      Get.back();
    } catch (e) {
      //tampilkan pesan error jika ada kesalahan
      Get.snackbar(
        'Error',
        'gagal menambahkan pegawai : $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  //controller untuk form field
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _nipController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Tambah Data',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _namaController,
              decoration: InputDecoration(
                labelText: 'Nama',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            TextField(
              controller: _nipController,
              decoration: InputDecoration(
                labelText: 'NIP',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            TextField(
              controller: _alamatController,
              decoration: InputDecoration(
                labelText: 'Alamat',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    //bagian save disini
                    _tambahPegawai();
                    Get.to(Homepage());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                  ),
                  child: const Text(
                    'Simpan Data',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}