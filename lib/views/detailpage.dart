import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterinventori/model/PegawaiModel.dart';
import 'package:flutterinventori/services/PegawaiService.dart';
import 'package:flutterinventori/views/updatePage.dart';
import 'package:get/get.dart';

class DetailPage extends StatefulWidget {
  final PegawaiModel pegawai;
  DetailPage({required this.pegawai, super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  // Pegawaiservice pegawaiservice = Pegawaiservice();
  Pegawaiservice _pegawaiservice = Pegawaiservice();
  List<PegawaiModel> pegawaiList = [];
  // Function to load pegawai data
  _loadPegawai() async {
    pegawaiList = await _pegawaiservice.getPegawai();
    setState(() {
      // filteredList = pegawaiList; // Inisialisasi daftar yang difilter
    });
  }

  @override
  void initState() {
    _loadPegawai();
    Timer.periodic(Duration(seconds: 3), (timer) {
      _loadPegawai();
    });
    super.initState();
  }

  //function dialog delete
  void _showDialogDelete() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Konfirmasi Hapus Data'),
          content: Text('Apakah Anda Yakin Ingin Menghapus Data?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                //nanti kasih function hapus
                _deletePegawai();
                Navigator.pop(context);
              },
              child: Text(
                'Hapus',
                style: TextStyle(color: Colors.red),
              ),
            )
          ],
        );
      },
    );
  }

  //functionnya delete
  void _deletePegawai() async {
    try {
      await _pegawaiservice.deletePegawai(widget.pegawai.id!);
      Get.snackbar("Sukses", "Data Berhasil Dihapus");
      Navigator.pop(context); //kembali ke halaman sebelumnya
    } catch (e) {
      Get.snackbar("Error", "Gagal Menghapus Data Pegawai");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.grey[200], // Warna latar belakang yang lebih lembut
      appBar: AppBar(
        automaticallyImplyLeading: false, // Tambahkan tombol kembali
        title: Text(
          widget.pegawai.nama ?? 'Detail Pegawai',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(15.0), // Buat sudut kartu melengkung
          ),
          elevation: 8, // Tambahkan shadow untuk efek mengambang
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header dengan nama pegawai
                Center(
                  child: Text(
                    'Detail Pegawai',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
                SizedBox(height: 16.0),

                // Nama Pegawai
                _buildDetailRow(
                    'Nama Pegawai:', widget.pegawai.nama ?? 'Tidak tersedia'),

                Divider(), // Divider untuk memisahkan item

                // NIP Pegawai
                _buildDetailRow('NIP:', widget.pegawai.nip ?? 'Tidak tersedia'),

                Divider(),

                // Alamat Pegawai
                _buildDetailRow(
                    'Alamat:', widget.pegawai.alamat ?? 'Tidak tersedia'),

                Divider(),

                // Tanggal Dibuat
                _buildDetailRow('Created At:',
                    widget.pegawai.createdAt ?? 'Tidak tersedia'),

                Divider(),

                // Tanggal Diperbarui
                _buildDetailRow('Updated At:',
                    widget.pegawai.updatedAt ?? 'Tidak tersedia'),

                SizedBox(height: 16.0),

                // Tombol kembali (Opsional)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //tombol edit
                    ElevatedButton(
                      onPressed: () {
                        Get.to(() => UpdatePage(pegawaiModel: widget.pegawai));
                        // Get.snackbar("Info", "Fungsi Edit nanti disini ");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent,
                        padding: EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 12.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Text(
                        'Edit',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    //tombol hapus
                    //tombol edit
                    ElevatedButton(
                      onPressed: () {
                        //untuk ke halaman Delete
                        _showDialogDelete();

                        // Get.snackbar("Info", "Fungsi Delete nanti disini ");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        padding: EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 12.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Text(
                        'Delete',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context); // Navigasi kembali
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          padding: EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 12.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Text(
                          'Kembali',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget Helper untuk menampilkan baris detail
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
