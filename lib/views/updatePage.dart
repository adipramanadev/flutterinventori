import 'package:flutter/material.dart';
import 'package:flutterinventori/model/PegawaiModel.dart';
import 'package:flutterinventori/services/PegawaiService.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UpdatePage extends StatefulWidget {
  final PegawaiModel pegawaiModel;
  const UpdatePage({required this.pegawaiModel, super.key});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  final Pegawaiservice pegawaiservice = Pegawaiservice();
  //controller untuk form field
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _nipController = TextEditingController();

  @override
  void initState() {
    //isi data form dengan data yang sudah ada berdasarkan ID
    _namaController.text = widget.pegawaiModel.nama ?? '';
    _nipController.text = widget.pegawaiModel.nip ?? '';
    _alamatController.text = widget.pegawaiModel.alamat ?? '';

    super.initState();
  }

  //function untuk update Data Pegawai
  void _updatePegawai() async {
    PegawaiModel updatePegawai = PegawaiModel(
        id: widget.pegawaiModel.id,
        nama: _namaController.text,
        nip: _nipController.text,
        alamat: _alamatController.text);

    //update datanya
    try {
      await pegawaiservice.updatePegawai(
          widget.pegawaiModel.id!, updatePegawai);
      Get.snackbar("Sukses", "Data Pegawai Berhasil DI update");
    } catch (e) {
      Get.snackbar("error", "Gagal Mengupdate Date Pegwawai");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        title: Text(
          'Edit Page',
          style: TextStyle(color: Colors.white),
        ),
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
                    //bagian update disini
                    _updatePegawai();
                    // Get.to(Homepage());
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                  ),
                  child: const Text(
                    'Ubah Data',
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
