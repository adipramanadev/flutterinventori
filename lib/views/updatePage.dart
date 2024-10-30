import 'package:flutter/material.dart';
import 'package:flutterinventori/model/PegawaiModel.dart';
import 'package:flutterinventori/services/PegawaiService.dart';
import 'package:flutterinventori/views/homepage.dart';
import 'package:get/get.dart';

class UpdatePage extends StatefulWidget {
  final PegawaiModel pegawaiModel;
  const UpdatePage({required this.pegawaiModel, super.key});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  bool _isLoading = false;
  final Pegawaiservice pegawaiservice = Pegawaiservice();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _nipController = TextEditingController();

  @override
  void initState() {
    _namaController.text = widget.pegawaiModel.nama ?? '';
    _nipController.text = widget.pegawaiModel.nip ?? '';
    _alamatController.text = widget.pegawaiModel.alamat ?? '';
    super.initState();
  }

  Future<void> _asyncOperation() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await Future.delayed(Duration(seconds: 2));
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
      print("error: $error");
    }
  }

  @override
  void dispose() {
    // Batalkan semua operasi async atau listener di sini jika ada
    _namaController.dispose();
    _alamatController.dispose();
    _nipController.dispose();
    super.dispose();
  }

  void _updatePegawai() async {
    PegawaiModel updatePegawai = PegawaiModel(
        id: widget.pegawaiModel.id,
        nama: _namaController.text,
        nip: _nipController.text,
        alamat: _alamatController.text);

    try {
      await pegawaiservice.updatePegawai(
          widget.pegawaiModel.id!, updatePegawai);
      Get.snackbar("Sukses", "Data Pegawai Berhasil Diupdate");
    } catch (e) {
      Get.snackbar("Error", "Gagal Mengupdate Data Pegawai");
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
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
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
                  SizedBox(height: 16.0),
                  TextField(
                    controller: _nipController,
                    decoration: InputDecoration(
                      labelText: 'NIP',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: _alamatController,
                    decoration: InputDecoration(
                      labelText: 'Alamat',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _updatePegawai();
                        Get.to(Homepage());
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
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
